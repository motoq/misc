import org.apache.commons.math3.linear.RealMatrix;
import org.apache.commons.math3.linear.Array2DRowRealMatrix;


public class TestVector {

  public static void main(String[] args) {


    double[][] a1 = { { 1., 2., 3. },
                      { 4., 5., 6. },
                      { 7., 8., 9. } };
    double[] v1 = { 9., 8., 7. };

    RealMatrix mtx1 = new Array2DRowRealMatrix(a1);
    RealMatrix mtx2 = new Array2DRowRealMatrix(v1);
    RealMatrix mtx;

    TMatrix ten1 = new TMatrix(a1);
    TVector ten2 = new TVector(v1);
    TMatrix ten = new TMatrix(3,1);



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
      ten.mult(ten1, ten2);
    }
    System.err.println("Tensor:  " + (System.currentTimeMillis() - t));

    t = System.currentTimeMillis();
    for (int ii=0; ii<n; ii++) {
      ten2.mult(1.001);
      ten.mult(ten1, ten2);
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
      ten.mult(ten1, ten2);
    }
    System.err.println("Tensor:  " + (System.currentTimeMillis() - t));

  }
}
