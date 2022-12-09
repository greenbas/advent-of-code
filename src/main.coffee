title = 'Advent of code'

document.addEventListener("load",() ->
  window.input = document.getElementById("input")
  window.output = document.getElementById("output")
)

window.toOutput = (str) -> 
  output.innerText = JSON.stringify(str)

`
function intersection(setA, setB) {
    const result = new Set();

    for (const elem of setA) {
        if (setB.has(elem)) {
            result.add(elem);
        }
    }

    return result;
}
`

window.main = () ->
  rucksacks = input.value.trim().split('\n')
  groups = (rucksacks[i..i+2] for i in [0...rucksacks.length] by 3)
  groups.map((cur) -> 
    cur = cur.sort((a,b) -> a.length - b.length)
      .map((group) -> new Set(group.split("")))
    union01 = intersection(cur[0],cur[1])
    [...intersection(union01,cur[2])][0].charCodeAt(0)
  ).reduce(((acc,cur) -> 
    isCapital = !(cur & 32)
    rank = cur & 31
    acc + rank + if isCapital then 26 else 0
  ),0)
  
