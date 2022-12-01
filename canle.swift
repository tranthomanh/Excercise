let input = "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. ThefirstlineofLoremIpsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32"
//Function: check char
func isChar(char: Character) -> Bool {
    if char == " "
    {
        return false
    }
    return true
}

func getChar(inp: String, index: Int) -> Character {
    let ch = inp[inp.index(inp.startIndex, offsetBy: index)]
    return ch;
}
//Function get start index of the next word 
func nextIndex(str: String, pos: Int) -> Int {
    let length = str.count
    let type = isChar(
        char: getChar(inp: str, index: pos)
    )
    var cur = pos + 1;
    if type == false {
        return cur
    }
    for i in (pos+1)...(length - 1) {
        let curType = isChar(
                char: getChar(inp: str, index: i)
        )
        if(curType == false) {
            break
        } else {
            cur+=1
        }
    }
    return cur
}
//function edit string 1 column left alignment
func editNotByColumn(inp: String) -> String {
    var ans: String = ""
    let maxChar = 80
    var cur = 0
    var curLength = 0
    while cur < inp.count {
        let nextPos = nextIndex(str: inp, pos: cur)
        let start = inp.index(inp.startIndex, offsetBy: cur)
        let end = inp.index(inp.startIndex, offsetBy: nextPos - 1)
        let res = inp[start...end]
        if curLength + res.count > maxChar {
            ans += "\n"
            curLength = 0
        } else {
            if res == " " && curLength == 0 {
                cur = nextPos
            } else {
                ans += res
                curLength += res.count
                cur = nextPos
            }
        }
        
        
    }
    return ans
}
//function edit string >1 column left alignment
func editByColumn(inp: String){
    let maxChar = 100
    let totalLength = inp.count
    let columnNum = 4
    let spaceNum = 4
    var charPerCol = totalLength / columnNum
    if totalLength % columnNum != 0 {
        charPerCol += 1
    }
    let charPerRow = (maxChar - (columnNum - 1) * spaceNum)/4
    var arr = Array(repeating: "", count: 50)
    var cur = 0
    var maxId = 0
    
    var rowId = 0
    var sum = 0
    while cur < inp.count{
        let nextPos = nextIndex(str: inp, pos: cur)
        let start = inp.index(inp.startIndex, offsetBy: cur)
        let end = inp.index(inp.startIndex, offsetBy: nextPos - 1)
        let res = inp[start...end]
        if sum + res.count > charPerRow {
           if sum > 0 {
                while arr[rowId].count < charPerRow {
                    arr[rowId] += " "
                }
                sum = 0
                rowId += 1
           } else {
                let end2 = inp.index(inp.startIndex, offsetBy: cur + charPerRow - 1)
                arr[rowId] += inp[start...end2]
                cur += charPerRow - 1
                rowId += 1
                sum = 0
           }
        } else {
            if res == " " && sum == 0{
                cur = nextPos
            } else{
                arr[rowId] += res
                sum += res.count
                cur = nextPos
            }
        }
         if maxId < rowId{
            maxId = rowId
        }
    }
    maxId += 1
    let rowNum = maxId / columnNum
    var numPerRow = Array(repeating: rowNum, count: columnNum)
    for i in stride(from: 1, to: (maxId % columnNum) + 1, by: 1) {
        numPerRow[i-1] += 1
    }

    for i in 0..<numPerRow[0] {
        var j = i
        var num = 1
        var res = ""
        while j < maxId {
            res += arr[j]
            if num < columnNum {
                res += "    "
            }
            j += numPerRow[num-1]
            num += 1
        }
        print(res)
    }
}
print("Can trai\n")
print(editNotByColumn(inp: input))
print("\n")
print("Chia theo cot\n")
editByColumn(inp: input)