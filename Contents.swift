//: Playground - noun: a place where people can play

//import UIKit
import Darwin
//1 给定一个Dictionary，Dictionary包含key值name和age，用map函数返回age字符串数组;
var dictionary:[String:Int] = ["zhang":10,"li":20,"chen":50,"he":30,"cai":18]
for i in dictionary{
    print(i.value)
}
let zidian = dictionary.map({
    return "\($0.value)"
})
print(zidian)
//2 给定一个String数组，用filter函数选出能被转成Int的字符串
let str = ["11","zhang","32","5","fsf"]
let fiter = str.filter({
    return Int($0) != nil
})
print(fiter)
//3用reduce函数把String数组中元素连接成一个字符串，以逗号分隔
let reduce = str.reduce("",{
    return $0 == "" ? $1 : $0 + "," + $1
})
print(reduce)
//4用 reduce 方法一次求出整数数组的最大值、最小值、总数和
var int = [2,4,7,23,5]
let tuple = {
    (int:[Int]) -> [Int] in
    var yuanzu = [Int]()
    yuanzu.append(int.reduce(Int.min, max))
    yuanzu.append(int.reduce(Int.max, min))
    yuanzu.append(int.reduce(0,+))
    return yuanzu
}(int)
print(tuple)
//5新建一个函数数组，函数数组里面保存了不同函数类型的函数，要求从数组里找出参数为一个整数，返回值为一个整数的所有函数；
var arr = [Any]()
func f1(p1:String) -> String{
    return p1
}
func f2(p1:Int) ->Int{
    return p1
}
func f3(p1:String) -> Int{
    return 1
}
arr.append(f1)
arr.append(f2)
arr.append(f3)
for i in arr{
    if i is ((Int)->Int) {
        print(i)
    }
}
//6扩展Int，增加sqrt方法，可以计算Int的Sqrt值并返回浮点数，进行验证；
extension Int{
    mutating func sqrt() -> Double{
        
        return Darwin.sqrt(Double(self))
    }
}
var i = 4
print(i.sqrt())
//7实现一个支持泛型的函数，该函数接受任意个变量并返回最大和最小值，分别传入整数值、浮点数值、字符串进行验证。
func maxmin<T:Comparable>(a:[T]) -> (max:T,min:T){
    var max = a[0]
    var min = a[0]
    for i in a{
        if i > max{
            max = i
        }
        if i < min{
            min = i
        }
    }
    return (max,min)
}
let a = [2,4,7,20]
let b = [2.0,4,33.2,12,9.8]
let c = ["ss","aa","fas","gsdg"]
print(maxmin(a: a))
print(maxmin(a: b))
print(maxmin(a: c))

enum Gender{
    case male
    case female
    static func >(one:Gender,two:Gender) -> Bool{
        if one.hashValue > two.hashValue{
            return true
        }else{
            return false
        }
    }
}
class Person:CustomStringConvertible{
    var firstName:String
    var lastName:String
    var age:Int
    var gender:Gender
    init(firstName:String,lastName:String,age:Int,gender:Gender) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.gender = gender
    }
    convenience init(name:String){
        self.init(firstName:name,lastName:"",age:18,gender:Gender.female)
    }
    var fullName:String{
        get{
            return firstName+lastName
        }
    }
    var description: String{
        return "name:"+fullName+" age:\(age)"+" Gender:\(gender)"
    }
    var run:String{
        return "Person"+fullName+"is running"
    }
    static func ==(right:Person,left:Person) -> Bool {
        return(right.firstName==left.firstName&&right.lastName==left.lastName&&right.age==left.age&&right.gender==left.gender)
    }
    static func !=(right:Person,left:Person) -> Bool {
        return !(right.firstName==left.firstName&&right.lastName==left.lastName&&right.age==left.age&&right.gender==left.gender)
    }
}
let p1 = Person(firstName: "zhang", lastName: "xiaoxiao", age: 18, gender: Gender.female)
let p2 = Person(name: "zhangxiao")
let p3 = Person(name: "zhangxiao")
print(p1)
print(p2)
print(p1 == p2)
print(p2 != p3)
enum department{
    case zuzhang
    case shuji
    case normal
}
protocol SchoolProtocol{
    var depart:department{get}
    func lendBook()
}
class Teacher:Person,SchoolProtocol{
    var depart: department = department.normal
    
    func lendBook() {
        print("teacher lend books")
    }
    
    var title:String
    init(title:String,firstName: String, lastName: String, age: Int, gender: Gender) {
        self.title = title
        super.init(firstName: firstName, lastName: lastName, age: age, gender: gender)
    }
    override var description: String{
        return "name:"+fullName+" age:\(age)"+" Gender:\(gender)"+" title:"+title
    }
    override var run: String{
        return "Teacher"+fullName+"is running"
    }
    
}
class Student:Person,SchoolProtocol{
    var depart: department = department.normal
    
    func lendBook() {
        print("student lend books")
    }
    
    var stuNo:String
    init(stuNo:String,firstName: String, lastName: String, age: Int, gender: Gender) {
        self.stuNo = stuNo
        super.init(firstName: firstName, lastName: lastName, age: age, gender: gender)
    }
    override var description: String{
        return "name:"+fullName+" age:\(age)"+" Gender:\(gender)"+" stuNo:"+stuNo
    }
    override var run: String{
        return "Student"+fullName+"is running"
    }
    
}
let t1 = Teacher(title: "t1", firstName: "li", lastName: "li", age: 20, gender: Gender.male)
print(t1)
let t2 = Teacher(title: "t2", firstName: "zhang", lastName: "dada", age: 30, gender: Gender.male)
print(t2)
let s1 = Student(stuNo: "001", firstName: "chen", lastName: "xiang", age: 40, gender: Gender.male)
let s2 = Student(stuNo: "002", firstName: "xi", lastName: "xiao", age: 25, gender: Gender.female)
print(s1)
print(s2)
var people = [Person]()
people.append(p1)
people.append(p2)
people.append(t1)
people.append(t2)
people.append(s1)
people.append(s2)
var nump = 0
var numt = 0
var nums = 0
for person in people{                 //统计每个类的对象装进字典
    if person is Teacher {
        numt+=1
    }else if person is Student {
        nums+=1
    }else{
        nump+=1
    }
}
var dictionarys:[String:Int] = [:]
dictionarys["people"] = nump
dictionarys["teacher"] = numt
dictionarys["student"] = nums
//print(dictionarys)
//print(s1 is Person)
let byAge = people.sorted(by: {(one:Person,two:Person) -> Bool in
    return one.age > two.age
} )
print(byAge)
let byfullName = people.sorted(by: {(one:Person,two:Person) -> Bool in
    return one.fullName > two.fullName
} )
print(byfullName)

let byGa = people.sorted(by: {(one:Person,two:Person) -> Bool in
    return one.gender > two.gender && one.age > two.age
} )
print(byGa)
for i in people{
    print(i.run)
    if let t =  i as? Teacher{
        t.lendBook()
    }
    if let s = i as? Student{
        s.lendBook()
    }
}
