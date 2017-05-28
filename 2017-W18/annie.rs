//https://repl.it/HodX/10
use std::mem;


fn main() {
   //false, false, false, true, true, true
   // note the type signature
    let examples: &[&[_]]= &[&[1, 2, 4], &[-5, -3, -1, 2, 4, 6], &[0; 0], &[-1, 1], &[-97364, -71561, -69336, 19675, 71561, 97863], &[-53974, -39140, -36561, -23935, -15680, 0]];

// grab the abs value, sort bc dedup[licate] needs it, unique-ify it, check if the lengths are the same (or if we had a 0)
    for elem in examples.iter() {
      let mut abs = elem.to_vec().iter().map(|&x| i32::abs(x)).collect::<Vec<_>>();
      abs.sort();
      abs.dedup();
      println!("{}, {:?}",  (elem.len() == abs.len() || elem[0] == 0), elem );
    }
    
}

// one line in haskell
// snd $ foldl (\(acc, prevTruth) x -> if ((-x) `elem` acc) then (x:acc, True) else (x:acc, prevTruth)) ([], False)  [-97364, -71561, -69336, 19675, 71561, 97863]
