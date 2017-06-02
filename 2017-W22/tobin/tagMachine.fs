// 2-Tag system:
// a -> bc
// b -> a
// c -> aaa

let reString (tag: char list): string = List.toArray tag |> System.String

let step = function
  | ('a'::_::rest) -> rest @ ['b';'c']
  | ('b'::_::rest) -> rest @ ['a']
  | ('c'::_::rest) -> rest @ ['a';'a';'a']
  | bad -> invalidArg "tag" (reString bad |> sprintf "Invalid tag: %s")

let rec run (previous: char list list) (tag: char list): char list list =
  if tag.Length < 2
  then tag :: previous
  else run (tag :: previous) (step tag)

[<EntryPoint>]
let main (argv : string array) : int =
  argv.[0]
    |> Seq.toList
    |> run []
    |> List.rev
    |> List.map reString
    |> String.concat "\n"
    |> printfn "%s"
  0
