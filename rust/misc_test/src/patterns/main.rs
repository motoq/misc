/// Demonstrates:
///   # Match on the number of elements in an array

fn main() {
    println!("--- Test pattern matching on number of elements in an array ---");
    let people = [];
    greet_people(&people);
    let people = ["Bob"];
    greet_people(&people);
    let people = ["Bob", "Ralph"];
    greet_people(&people);
    let people = ["Bob", "Ralph", "Suzan"];
    greet_people(&people);
}


/// Function illustrating match on number of elements of an array
fn greet_people(names: &[&str]) {
    match names {
        [] => { println!("Hellow, nobody.") },
        [a] => { println!("Hellow, {}.", a) },
        [a, b] => { println!("Hellow, {} and {}.", a, b) },
        [a, ..,b] => { println!("Hellow, everyone from {} to {}.", a, b) },
    }
}
