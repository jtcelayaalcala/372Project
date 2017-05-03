
type Student
  name :: String
  age :: Int
  id :: Int64
  major :: String
  class :: String

  function Student(name, age, id, major, class)
    new(name, age, id, major, class)
  end

end

S = Student("Jose", 18, 23249508, "Computer Science", "Junior")

println("$(S.name) is a $(S.major) major. $(S.name) is $(S.age) years old.")

function printStudentInfo(S :: Student)
  println("$(S.name) is a $(S.major) major. $(S.name) is $(S.age) years old.")
end

printStudentInfo(S)

randomStuff = ["Hello", 8, [7,5]]
nums = [1,2,3]

println(length(randomStuff)) #find the length of the list

push!(randomStuff, "t") #append "t" to randomStuff

println(randomStuff) #print new list

println(sum(nums)) #sum of all numbers in nums

println(prod(nums)) #product of all numbers in nums

i = 0

while(i < 100)
  i+=1
end

if i % 2 == 0
  println(i)
else
  println(i+1)
end


for i = 1:20
  println(i)
end

oddNums = [x for x in 1:50 if x % 2 == 1]

squares = [x^2 for x in oddNums]


i = 0
doIf = true

#while loop
while i < 10
  i+=1
end

#for loop
for k = 1:5
  println(k)
end

#if with an else
if doIf
  println("In the if!")
else
  println("Not in if!")
end

#if with an elseif
if i == 10
  println(i)
elseif i < 10
  print("i is bigger than 10!")
end

#short circuit evaluations
if i == 10 || k < 100 #second part will not be evaluated since first is true
  println("i < 10 and k < 100")
end

if i % 2 == 1 && k < 20 #second part not evaluated since first is false
  println("i is odd or k < 20")
end

#ternary operator
j = i < 10 ? 0 : 1 #if i < 10, j = 0, else j = 1

#compuond expressions, two ways
z = begin
    x = 1
    y = 2
    x + y
    end

z = (x = 1; y = 2; x + y)

function sqrt_second(x)
  try
    sqrt(x[2])
  catch y
    if isa(y, DomainError)
        sqrt(complex(x[2], 0))
    elseif isa(y, BoundsError)
        sqrt(x)
    end
end



A = [1,2] #initialize A
B = A

println(A) #result: [1,2]

push!(B,3) #append 3 to B

print(A) #result: [1,2,3]
