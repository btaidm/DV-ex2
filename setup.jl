using Plots, DataFrames, ExcelReaders, StatPlots, StatsBase
data = readxlsheet(DataFrame,"Evaluation-Table.xlsx","Sheet1")
data[:User] = map(Int,data[:User])
stackedData = stack(data,2:15,1)
stackedData[:variable] = map(string,stackedData[:variable])

scaledData = by(stackedData,:variable) do df
h = fit(Histogram,df[2],[0,1,2,3,4,5])
weights = h.weights./sum(h.weights)
weights = cumsum(weights)
DataFrame(A1=weights[1],A2=weights[2],A3=weights[3],A4=weights[4],A5=weights[5])
end


function makeBarChart()
    s = scaledData
    s[1] = map(string,s[1])

    p = bar(s,:variable,keys(s.colindex)[end:-1:2])
    plot!(p, s,:variable,keys(s.colindex)[end:-1:2])
    return p
end