using Plots, DataFrames, ExcelReaders, StatPlots, StatsBase
data = readxlsheet(DataFrame,"Evaluation-Table.xlsx","Sheet1")
stackedData = stack(data[2:end])

scaledData = by(stackedData,:variable) do df
h = fit(Histogram,df[2],[0,1,2,3,4,5])
weights = h.weights./sum(h.weights)
weights = cumsum(weights)
DataFrame(A1=weights[1],A2=weights[2],A3=weights[3],A4=weights[4],A5=weights[5])
end

# s = scaledData
# s[1] = map(string,s[1])
# bar(s,:variable,keys(s.colindex)[end:-1:2])
# plot!(s,:variable,keys(s.colindex)[end:-1:2])