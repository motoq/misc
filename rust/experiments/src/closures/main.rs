/// Demonstrates default capture of variables by closures as references,
/// and passing of arguments
///
/// 2026/02/23

use std::ops::{Sub};

/// POD with Sub implemented
#[derive(Debug)]
struct Point {
    x: f64,                                                                     
    y: f64,                                                                     
} 

/// Take arguments by reference.  Otherwise, subtraction will consume
/// self and other
impl Sub<&Point> for &Point {
    type Output = Point;

    fn sub(self, other: &Point) -> Point {
        Point {
            x: self.x - other.x,
            y: self.y - other.y,
        }
    }
}
/* 
// With lifetimes to illustrate
impl<'a, 'b> Sub<&'b Point> for &'a Point {
    type Output = Point;

    fn sub(self, other: &'b Point) -> Point {
        Point {
            x: self.x + other.x,
            y: self.y + other.y,
        }
    }
}
*/


/// POD with Copy enabled
#[derive(Clone, Copy, Debug)]
struct PointCopyClone {
    x: f64,                                                                     
    y: f64,                                                                     
} 

// Will recieve a copy, leaving RHS valid afterwards
impl Sub for PointCopyClone {
    type Output = Self;

    fn sub(self, other: Self) -> Self {
        PointCopyClone {
            x: self.x - other.x,
            y: self.y - other.y,
        }
    }
}


fn main() {
    // Origin, a "configured" parameter
    let origin = Point {
        x: 0.5,                                                                 
        y: 0.25,                                                                 
    };

    // Point w.r.t. (0, 0), argument to closure
    let r_p_0 = Point {
        x: 7.0,                                                                 
        y: 5.0,                                                                 
    };

    // Illustrate operator works without moving RHS
    let xy = &r_p_0 - &origin; 
    println!("{:?} = {:?} - {:?}", xy, r_p_0, origin);


    println!("\nClosure without operator overloading");

    // Need to pass head by reference or else it will be moved since
    // Copy is not implemented.  Origin is captured by reference.
    let update_origin = |head: &Point| {
        Point {
            x: head.x - origin.x,
            y: head.y - origin.y,
        }
    };

    let r_p = update_origin(&r_p_0);

    println!("Given Origin {:?})", origin);    // Nope
    println!("Old Point {:?})", r_p_0);        // Nope
    println!("New Point {:?})", r_p);


    println!("\nClosure with operator overloading");

    // Argument and capture variable explicitly by reference
    let update_origin = |point: &Point| { point - &origin };

    let r_p = update_origin(&r_p_0);

    println!("Given Origin {:?})", origin);    // Nope
    println!("Old Point {:?})", r_p_0);        // Nope
    println!("New Point {:?})", r_p);


    println!("\nClosure that copies");

    // Origin, a "configured" parameter
    let origin = PointCopyClone {
        x: 0.5,                                                                 
        y: 0.25,                                                                 
    };

    // Point w.r.t. (0, 0), argument to closure
    let r_p_0 = PointCopyClone {
        x: 7.0,                                                                 
        y: 5.0,                                                                 
    };

    // Copy origin (because sub for this version of Point takes
    // possession, so Copy is called since implemented)
    let update_origin = |point| { point - origin };

    // Copy r_p_0
    let r_p = update_origin(r_p_0);

    println!("Given Origin {:?})", origin);    // Nope
    println!("Old Point {:?})", r_p_0);        // Nope
    println!("New Point {:?})", r_p);

    println!("Intrinsic values copied");
    for i in 0..5 {
        println!("new {} and old {}", (|| {i + 1})(), i);
    }

    println!("");
}

