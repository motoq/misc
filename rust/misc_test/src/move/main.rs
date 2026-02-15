/// Demonstraates implicity copy of POD when Copy trait is
/// associated with a structure.

/// Default structure with POD
struct Point {
    x: f64,
    y: f64,
}

/// ...with Copy
/// Note, Copy is a marker (empty) trait does have any method and
/// instead indicates properties/behaviors of the structure
///  Hence, .copy() is not called, but .clone(), if used explicity. 
///
#[derive(Clone, Copy)]
struct PointCopy {
    x: f64,
    y: f64,
}

fn main() {

    let p1 = Point {
        x: 7.5,
        y: 5.0,
    };

    // Copy not implemented, p2 takes possesion of p1
    let p2 = p1;

    //println!("p1 ({}, {}k)", p1.x, p1.y);  // Nope, p1 invalid
    println!("p2 ({}, {}k)", p2.x, p2.y);

    println!("");

    let p1 = PointCopy {
        x: 6.0,
        y: 5.5,
    };

    // Implicit copy
    let p2 = p1;
    // Explicit (copy() not callable - use clone())
    let p3 = p1.clone();

    println!("p1 ({}, {}k)", p1.x, p1.y);
    println!("p2 ({}, {}k)", p2.x, p2.y);
    println!("p3 ({}, {}k)", p3.x, p3.y);
}
