
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

push!("t",randomStuff) #append "t" to randomStuff

println(randomStuff) #print new list

println(sum(nums)) #sum of all numbers in nums

println(prod(nums)) #product of all numbers in nums
