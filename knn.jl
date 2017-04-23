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
allNonTestPoints = vcat(pointsg1,pointsg2)

for point in pointstst
  kNN[point] = sort([(dist(allNonTestPoints[i],point),allNonTestPoints[i]) for i in 1:length(allNonTestPoints)])
end

classifiedg1 = []
classifiedg2 = []

for point = keys(kNN)
  #println(kNN[point])
  g1 = 0
  g2 = 0

  for p in kNN[point][1:3]
    #println(p[2])
    if p[2] in pointsg1
      g1 += 1
    elseif p[2] in pointsg2
      g2 += 1
    end
  end

  println(g1)
  println(g2)

  if g1 > g2
    push!(classifiedg1,point)
  else
    push!(classifiedg2,point)
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

x_3 = [x[1] for x in classifiedg1]
y_3 = [x[2] for x in classifiedg1]

x_4 = [x[1] for x in classifiedg2]
y_4 = [x[2] for x in classifiedg2]

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
scatter(x_3,y_3,alpha=0.5,color="red",marker="^")
scatter(x_4,y_4,alpha=0.5,color="blue",marker="v")

savefig("classification.png")
