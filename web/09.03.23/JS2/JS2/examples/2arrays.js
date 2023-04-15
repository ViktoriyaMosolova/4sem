// добавление/удаление

// const arr = [0]
// console.log(arr)
//
// arr.push(1,2,3)
// console.log(arr)
//
// arr.pop()
// console.log(arr)
//
// arr.unshift(2,3,4)
// console.log(arr)
//
// arr.shift()
// console.log(arr)


// перебор элементов

// const arr = [1,2,3,4,5]

// for (let i = 0; i < arr.length; i++) {
// console.log(arr[i])
// }

// for (const number of arr) {
//     console.log(number)
// }


// Остальные основные методы

// const arr = [1, 2, 3, 4, 5,]
// console.log(arr.slice(0, 3))
// console.log(arr.join('/'))
// console.log(arr.includes(1))
// arr.sort((a, b) => b - a)
// console.log(arr)
//
// const arr2 = [[1, 2], [3, 4]]
// console.log(arr2.flat())


// Методы высшего порядка

// forEach, map, filter, reduce

// const arr1 = [1, 2, 3, 4, 5]

// arr1.forEach((value, index, array) => {
//     console.log(value)
//     return 123
// })

// const arr2 = arr1.map(item => {
//     return item < 3 ? 0 : 1
// })
// console.log(arr2)
//
// const arr3 = arr1.filter(item => item !== 3)
// console.log(arr3)
//
// const arr4 = arr1.reduce((prev,current) => prev+current, 0)
// console.log(arr4)


// Spread оператор

// const arr1 = [1, 2, 3]
// const arr2 = [...arr1, 4, 5]
// arr1[0] = 2
// console.log(arr1, arr2)
//
// const sum = (a, b) => a + b
// const result = sum(...arr1)
// console.log(result)