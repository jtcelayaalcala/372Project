#= Name:        dist
 =
 = Purpose:    Calculates the distance between two two-tuples using the two
 =              norm
 =
 = Parameters:  A- the first tuple
 =              B - the second tuple
 =
 = Returns:    The distance between points A and B
 =#
function dist(A,B)
  return ((A[1]-B[1])^2 + (A[2]-B[2])^2)^(0.5)
end

#= Name:        minIndex
 =
 = Purpose:   Finds the index of the minimum value in a list by finding keep
 =            track of the index of the smallest encountered while iterating
 =            through the list
 =
 = Parameters:  A- the list we want the index of the minimum element of
 =
 = Returns:     An integer that is the index of the min value of a. If this
 =              minimum value occurs more than once, the smallest index is
 =              returned.
 =#
function minIndex(A)
  # Assume the first element is the smallest
  min = 1
  for i = 1:length(A)
    # If you find a smaller number, keep track of the index
    if A[i] < A[min]
      min = i
    end
  end
  return min
end

# Read in the points from the file points.txt
f = open("points.txt")
lines = readlines(f)

# Keep track of the first group of points--(x,y) where x < y, the second
# group of points--(x,y) where y > x, and the test points
pointGroupOne = []
pointGroupTwo = []
testGroup = []

# Store the points in arrays
groupNumber = 1
groups = [pointGroupOne,pointGroupTwo,testGroup]
for line in lines
# Split about commas
  point = split(line, ',')

  # The delimiter for the groups is "#######", which will have length < 2 when
  # split about commas. This is then a condition for reaching the group
  # delimiter
  if length(point) < 2
    # Move on to the next group
    groupNumber += 1
    continue
  end

  # Add the point read to the corresponding group. Parse converts the string
  # containing the number to the corresponding number
  push!(groups[groupNumber],(parse(Int64,point[1]),parse(Int64,point[2])))
end

kNN = Dict()
allNonTestPoints = vcat(pointGroupOne,pointGroupTwo)

for point in testGroup
  kNN[point] = sort([(dist(allNonTestPoints[i],point),allNonTestPoints[i]) for i in 1:length(allNonTestPoints)])
end

classifiedGroupOne = []
classifiedGroupTwo = []

for point = keys(kNN)

  g1 = 0
  g2 = 0

  for p in kNN[point][1:3]
    #println(p[2])
    if p[2] in pointGroupOne
      g1 += 1
    elseif p[2] in pointGroupTwo
      g2 += 1
    end
  end

  if g1 > g2
    push!(classifiedGroupOne,point)
  else
    push!(classifiedGroupTwo,point)
  end
end
using PyPlot

#################
#  Create Data  #
#################
x_1 = [x[1] for x in pointGroupOne]
y_1 = [x[2] for x in pointGroupOne]

x_2 = [x[1] for x in pointGroupTwo]
y_2 = [x[2] for x in pointGroupTwo]

x_3 = [x[1] for x in classifiedGroupOne]
y_3 = [x[2] for x in classifiedGroupOne]

x_4 = [x[1] for x in classifiedGroupTwo]
y_4 = [x[2] for x in classifiedGroupTwo]

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
