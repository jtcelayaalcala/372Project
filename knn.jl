function dist(A,B)

  return ((A[1]-B[1])^2 + (A[2]-B[2])^2)^(0.5)
end

function minIndex(A)
  min = 1
  for i = 1:length(A)
    if A[i] < A[min]
      min = i
    end
  end
  return i
end

f = open("points.txt")
lines = readlines(f)

pointsg1 = []
pointsg2 = []
pointstst = []

i = 1
k = 3

groups = [pointsg1,pointsg2,pointstst]

for line in lines
  point = split(line, ',')

  if length(point) < 2
    i += 1
    continue
  end

  push!(groups[i],(parse(Int64,point[1]),parse(Int64,point[2])))
end

kNN = Dict()
allNonTestPoints = append!(pointsg1,pointsg2)

for point in pointstst
  kNN[point] = [allNonTestPoints[1],allNonTestPoints[2],allNonTestPoints[3]]

  minDistIndex = minIndex([dist(kNN[point][1], point),dist(kNN[point][2], point),dist(kNN[point][3], point)])

  for posspoint in allNonTestPoints
    if dist(point, posspoint) < dist(point, kNN[point][minDistIndex])
      kNN[point][minDistIndex] = posspoint
    end
  end
end

using PyPlot

#################
#  Create Data  #
#################
x_1 = [x[1] for x in pointsg1]
y_1 = [x[2] for x in pointsg1]

x_2 = [x[1] for x in pointsg2]
y_2 = [x[2] for x in pointsg2]

x_3 = [x[1] for x in pointstst]
y_3 = [x[2] for x in pointstst]

##################
#  Scatter Plot  #
##################
fig = figure("pyplot_scatterplot",figsize=(10,10))
ax = axes()

title("Data Points")
xlabel("X")
ylabel("Y")
grid("on")

scatter(x_1,y_1,alpha=0.5,color="red")
scatter(x_2,y_2,alpha=0.5,color="blue")
scatter(x_3,y_3,alpha=0.5,color="black")

savefig("classification.png")
