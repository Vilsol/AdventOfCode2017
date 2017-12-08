import scala.collection.mutable

val file = scala.io.Source.fromFile("input.txt")
val data = try file.mkString finally file.close()
val lines = data.split("\n")
val pattern = "^(\\S+)\\s(inc|dec)\\s(-?[0-9]+)\\sif\\s(\\S+)\\s(==|<=|>=|!=|>|<)\\s(-?[0-9]+)$".r
val register = mutable.HashMap[String, Int]()

lines.foreach(s => {
  val result = pattern.findFirstMatchIn(s).get

  val key = result.group(1)
  val increment = result.group(2) == "inc"
  val amount = Integer.parseInt(result.group(3))
  val ifKey = result.group(4)
  val clause = result.group(5)
  val ifAmount = Integer.parseInt(result.group(6))

  val ifKeyValue = register.getOrElseUpdate(ifKey, 0)
  var success = false

  clause match {
    case "==" =>
      success = ifKeyValue == ifAmount
    case "<=" =>
      success = ifKeyValue <= ifAmount
    case ">=" =>
      success = ifKeyValue >= ifAmount
    case "!=" =>
      success = ifKeyValue != ifAmount
    case ">" =>
      success = ifKeyValue > ifAmount
    case "<" =>
      success = ifKeyValue < ifAmount
  }

  if(success){
    if(increment){
      register.put(key, register.getOrElseUpdate(key, 0) + amount)
    }else{
      register.put(key, register.getOrElseUpdate(key, 0) - amount)
    }
  }
})

var maxValue = Integer.MIN_VALUE

for (e <- register.keySet) {
  if(register.getOrElse(e, 0) > maxValue){
    maxValue = register.getOrElse(e, 0)
  }
}

println(maxValue)