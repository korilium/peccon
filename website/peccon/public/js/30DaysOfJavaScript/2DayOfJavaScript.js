let word = 'JavaScript'


word[0] = 'Y'

let numOne = 3
let numTwo = 3

console.log(numOne == numTwo)

let js = 'JavaScript'
let py = 'Python'

console.log(js == py)

let lightOn = true
let lightOff = false

console.log(lightOn == lightOff)
    // non premititve data types
let nums = [1, 2, 3]
nums[0] = 10

console.log(nums)

let numbers = [1, 2, 3]

console.log(nums == numbers)

let userOne = {
    name: 'Asabeneh',
    role: 'teaching',
    country: 'Finland'
}

let userTwo = userOne

console.log(userOne == userTwo)

//numbers 

let age = 35
const gravity = 9.81
let mass = 72
const PI = 3.14

const boilingPoint = 100
const bodyTemp = 37
console.log(age, gravity, mass, PI, boilingPoint, bodyTemp)

//Math Object 
const Pi = Math.PI

console.log(PI)

console.log(Math.round(PI))
console.log(Math.round(9.81))
console.log(Math.floor(PI))
console.log(Math.ceil(PI))
console.log(Math.min(-5, 3, 20, 4, 5, 10))
console.log(Math.max(-5, 3, 20, 4, 5, 10))

const randNum = Math.random()
console.log(randNum)

const num = Math.floor(Math.random() * 11)
console.log(num)


//Absolute value
console.log(Math.abs(-10)) // 10

//Square root
console.log(Math.sqrt(100)) // 10

console.log(Math.sqrt(2)) // 1.4142135623730951

// Power
console.log(Math.pow(3, 2)) // 9

console.log(Math.E) // 2.718

// Logarithm
// Returns the natural logarithm with base E of x, Math.log(x)
console.log(Math.log(2)) // 0.6931471805599453
console.log(Math.log(10)) // 2.302585092994046

// Trigonometry
Math.sin(0)
Math.sin(60)

Math.cos(0)
Math.cos(60)

let randomNum = Math.random() // generates 0 to 0.999
let numBtnZeroAndTen = randomNum * 11

console.log(numBtnZeroAndTen) // this gives: min 0 and max 10.99

let randomNumRoundToFloor = Math.floor(numBtnZeroAndTen)
console.log(randomNumRoundToFloor) // this gives between 0 and 10

//Strings 

let space = ' ' // an empty space string
let firstName = 'Asabeneh'
let lastName = 'Yetayeh'
let country = 'Finland'
let city = 'Helsinki'
let language = 'JavaScript'
let job = 'teacher'
let quote = "The saying,'Seeing is Believing' is not correct in 2020."
let quotWithBackTick = `The saying,'Seeing is Believing' is not correct in 2020.`

let fullName = firstName + space + lastName; // concatenation, merging two string together.
console.log(fullName);



let personInfoOne = fullName + '. I am ' + age + '. I live in ' + country; // ES5 string addition

console.log(personInfoOne)

const paragraph = "My name is Asabeneh Yetayeh. I live in Finland, Helsinki.\
I am a teacher and I love teaching. I teach HTML, CSS, JavaScript, React, Redux, \
Node.js, Python, Data Analysis and D3.js for anyone who is interested to learn. \
In the end of 2019, I was thinking to expand my teaching and to reach \
to global audience and I started a Python challenge from November 20 - December 19.\
It was one of the most rewarding and inspiring experience.\
Now, we are in 2020. I am enjoying preparing the 30DaysOfJavaScript challenge and \
I hope you are enjoying too."

console.log(paragraph)

console.log('I hope everyone is enjoying the 30 Days Of JavaScript challenge.\nDo you ?') // line break
console.log('Days\tTopics\tExercises')
console.log('Day 1\t3\t5')
console.log('Day 2\t3\t5')
console.log('Day 3\t3\t5')
console.log('Day 4\t3\t5')
console.log('This is a backslash  symbol (\\)') // To write a backslash
console.log('In every programming language it starts with \"Hello, World!\"')
console.log("In every programming language it starts with \'Hello, World!\'")
console.log('The saying \'Seeing is Believing\' isn\'t correct in 2020')

console.log(`The sum of 2 and 3 is 5`) // statically writing the data
let a = 2
let b = 3
console.log(`The sum of ${a} and ${b} is ${a + b}`) // injecting the data dynamically


let personInfoTwo = `I am ${fullName}. I am ${age}. I live in ${country}.` //ES6 - String interpolation method
let personInfoThree = `I am ${fullName}. I live in ${city}, ${country}. I am a ${job}. I teach ${language}.`
console.log(personInfoTwo)
console.log(personInfoThree)

console.log(`${a} is greater than ${b}: ${a > b}`)

console.log(js.length) // 10

console.log(firstName.length) // 8 


let string = 'JavaScript'
let firstLetter = string[0]

console.log(firstLetter) // J

let secondLetter = string[1] // a
let thirdLetter = string[2]
let lastLetter = string[9]

console.log(lastLetter) // t

let lastIndex = string.length - 1

console.log(lastIndex) // 9
console.log(string[lastIndex])


console.log(string.split()) // Changes to an array -> ["30 Days Of JavaScript"]
console.log(string.split(' ')) // Split to an array at space -> ["30", "Days", "Of", "JavaScript"]



console.log(firstName.split()) // Change to an array - > ["Asabeneh"]
console.log(firstName.split('')) // Split to an array at each letter ->  ["A", "s", "a", "b", "e", "n", "e", "h"]

let countries = 'Finland, Sweden, Norway, Denmark, and Iceland'

console.log(countries.split(',')) // split to any array at comma -> ["Finland", " Sweden", " Norway", " Denmark", " and Iceland"]
console.log(countries.split(', ')) //  ["Finland", "Sweden", "Norway", "Denmark", "and Iceland"]


console.log(string.includes('Days')) // true
console.log(string.includes('days')) // false - it is case sensitive!
console.log(string.includes('Script')) // true
console.log(string.includes('script')) // false
console.log(string.includes('java')) // false
console.log(string.includes('Java'))


let numInt = parseInt(num)
console.log(numInt) // 10

// exercises

let challenge = '30 Days Of JavaScript'

console.log(challenge)
console.log(challenge.length)
console.log(challenge.toUpperCase())
console.log(challenge.toLowerCase())
console.log(challenge.substring(3, 7))
console.log(challenge.substring(3, 20))
console.log(challenge.includes('Script'))
console.log(challenge.split(' '))

let companies = 'Facebook, Google, Microsoft, Apple, IBM, Oracle, Amazon'

console.log(companies.split(', '))
console.log(challenge.replace('JavaScript', 'Python'))
console.log(challenge.charAt(15))
console.log(challenge.charCodeAt('J'))
console.log(challenge.indexOf('a'))
console.log(challenge.lastIndexOf("a"))