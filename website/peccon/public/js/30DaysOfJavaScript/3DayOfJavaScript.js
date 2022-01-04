let isLightOn = true
let isRaining = false
let isHungry = false
let truValue = 4 > 3 // true
let falseValue = 4 < 3 // false




let empty = null
console.log(empty)




let numOne = 4
let numTwo = 3
let sum = numOne + numTwo
let diff = numOne - numTwo
let mult = numOne * numTwo
let div = numOne / numTwo
let remainder = numOne % numTwo
let powerOf = numOne ** numTwo

console.log(sum, diff, mult, div, remainder, powerOf) // 7,1,12,1.33,1, 64

const PI = 3.14
let radius = 100 // length in meter

//Let us calculate area of a circle
const areaOfCircle = PI * radius * radius
console.log(areaOfCircle) //  314 m

const gravity = 9.81 // in m/s2
let mass = 72 // in Kilogram

// Let us calculate weight of an object
const weight = mass * gravity
console.log(weight) // 706.32 N(Newton)

const boilingPoint = 100 // temperature in oC, boiling point of water
const bodyTemp = 37 // body temperature in oC


// Concatenating string with numbers using string interpolation
/*
 The boiling point of water is 100 oC.
 Human body temperature is 37 oC.
 The gravity of earth is 9.81 m/s2.
 */
console.log(
    `The boiling point of water is ${boilingPoint} oC.\nHuman body temperature is ${bodyTemp} oC.\nThe gravity of earth is ${gravity} m / s2.`
)




const now = new Date()
console.log(now)


let firstName = 'Ignace'
let lastName = 'Decocq'
let country = 'Belgium'
let city = 'Borgloon'
let age = 23
let isMarried = false

console.log(typeof firstName)
console.log(typeof age)
console.log(typeof isMarried)
console.log('10' === 10)
console.log(parseInt(9.8) === 10)

/*let base = prompt('enter base:', 'base')
let height = prompt('enter height:', 'height')
let area = 0.5 * base * height
console.log(`The area of the triangle is ${area} `)
*/