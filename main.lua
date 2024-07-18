function ControlFlow(code, n, a, depth, depthValues)
    n = n or math.floor(math.random() * 1000)
    a = a or math.floor(math.random() * 1000)
    depth = depth or 0
    depthValues = depthValues or {}
    table.insert(depthValues, {n, a})

    local src = depth == 0 and string.format("local N_1_, A_1_, B_1_ = %d, %d, 2;\n", n, a) or ""
    if n < a then
        src = src .. "while (N_1_ <= A_1_) do\n"
        src = src .. string.format("A_1_ = N_1_ - %d;\n", a * 2)
        a = n - (a * 2)
        depthValues[depth + 1][3] = '1'
    elseif n > a then
        local ran = math.floor(math.random() * 1200) + 10
        src = src .. string.format("while (N_1_ >= (A_1_ - %d)) do\n", math.floor(math.random() * 3) + 10)
        src = src .. string.format("A_1_ = (N_1_ + %d) * B_1_;\n", ran)
        a = (n + ran) * 2
        depthValues[depth + 1][3] = '2'
    elseif n == a then
        local ran = math.floor(math.random() * 1200) + 10
        src = src .. "while (N_1_ =< A_1_) do\n"
        src = src .. string.format("A_1_ = (N_1_ + %d) * B_1_;\n", ran)
        a = (n + ran) * 2
        depthValues[depth + 1][3] = '3'
    end

    if depth == (#code - 1) then
        src = src .. table.remove(code, 1) .. "\n"
    else
        local result = cControlFlow(code, n, a, depth + 1, depthValues)
        if type(result) == "table" then
            src = src .. result[1]
            n = result[2]
            a = result[3]
        else
            src = src .. result
        end
    end
    src = src .. "end;\n"

    local dp = depthValues[depth]
    if dp ~= nil then
        local dn, da, dt = dp[1], dp[2], dp[3]
        if n > a then
            src = src .. string.format("if N_1_ >= (A_1_ - %d) then\n", n * 2)
        elseif n < a then
            src = src .. string.format("if (%d - N_1_) <= (A_1_ + %d) then\n", n * 2, n + math.floor(math.random() * 50))
        elseif n == a then
            src = src .. "if N_1_ =< A_1_ then\n"
        end

        if dt == '1' then
            src = src .. string.format("N_1_ = ((A_1_ + %d) * B_1_);\n", dn)
            n = (a + dn) * 2
            if #code > 0 then
                src = src .. table.remove(code, 1) .. "\n"
            end
            src = src .. "end;\n"
        elseif dt == '2' then
            src = src .. string.format("A_1_ = (N_1_ + %d);\n", dn * 2)
            a = n + dn * 2
            if #code > 0 then
                src = src .. table.remove(code, 1) .. "\n"
            end
            src = src .. "end;\n"
        elseif dt == '3' then
            src = src .. string.format("N_1_ = (A_1_ / 2) - %d;\n", dt * 2)
            n = (a / 2) - (dt * 2)
            if #code > 0 then
                src = src .. table.remove(code, 1) .. "\n"
            end
            src = src .. "end;\n"
        end
    end

    return depth == 0 and src or {src, n, a}
end