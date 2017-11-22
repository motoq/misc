import org.apache.commons.math3.linear.RealMatrix;
import org.apache.commons.math3.linear.Array2DRowRealMatrix;


public class TestMatrix {

  public static void main(String[] args) {


    double[][] a1 = { { 1., 2., 3. },
                      { 4., 5., 6. },
                      { 7., 8., 9. } };
    double[][] a2 = { { 9., 8., 7. },
                      { 6., 5., 4. },
                      { 3., 2., 1. } };

    RealMatrix mtx1 = new Array2DRowRealMatrix(a1);
    RealMatrix mtx2 = new Array2DRowRealMatrix(a2);
    RealMatrix mtx;

    TMatrix ten1 = new TMatrix(a1);
    TMatrix ten2 = new TMatrix(a2);
    TMatrix ten; // = new TMatrix(3,3);;


    //mtx = mtx1.multiply(mtx2);
    //ten.mult(ten1, ten2);

    final long n = 1000000;

    long t = System.currentTimeMillis();
    for (int ii=0; ii<n; ii++) {
      mtx1 = mtx1.scalarMultiply(.99);
      mtx = mtx1.multiply(mtx2);
    }
    System.err.println("Commons:  " + (System.currentTimeMillis() - t));

    t = System.currentTimeMillis();
    for (int ii=0; ii<n; ii++) {
      ten1.mult(.99);
      //ten = new TMatrix(3,3);
      //ten.mult(ten1, ten2);
      ten = ten1.mult(ten2);
    }
    System.err.println("Tensor:  " + (System.currentTimeMillis() - t));

    t = System.currentTimeMillis();
    for (int ii=0; ii<n; ii++) {
      ten2.mult(1.001);
      //ten = new TMatrix(3,3);
      //ten.mult(ten1, ten2);
      ten = ten1.mult(ten2);
    }
    System.err.println("Tensor:  " + (System.currentTimeMillis() - t));

    t = System.currentTimeMillis();
    for (int ii=0; ii<n; ii++) {
      mtx2 = mtx2.scalarMultiply(1.001);
      mtx = mtx1.multiply(mtx2);
    }
    System.err.println("Commons:  " + (System.currentTimeMillis() - t));

    t = System.currentTimeMillis();
    for (int ii=0; ii<n; ii++) {
      mtx1 = mtx1.scalarMultiply(.99);
      mtx2 = mtx2.scalarMultiply(1.001);
      mtx = mtx1.multiply(mtx2);
    }
    System.err.println("Commons:  " + (System.currentTimeMillis() - t));

    t = System.currentTimeMillis();
    for (int ii=0; ii<n; ii++) {
      ten1.mult(.99);
      ten2.mult(1.001);
      //ten = new TMatrix(3,3);
      //ten.mult(ten1, ten2);
      ten = ten1.mult(ten2);
    }
    System.err.println("Tensor:  " + (System.currentTimeMillis() - t));


  }
}
