/*
 c  TMatrix.java
 c
 c  Copyright (C) 2017 Kurt Motekew
 c
 c  This library is free software; you can redistribute it and/or
 c  modify it under the terms of the GNU Lesser General Public
 c  License as published by the Free Software Foundation; either
 c  version 2.1 of the License, or (at your option) any later version.
 c
 c  This library is distributed in the hope that it will be useful,
 c  but WITHOUT ANY WARRANTY; without even the implied warranty of
 c  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 c  Lesser General Public License for more details.
 c
 c  You should have received a copy of the GNU Lesser General Public
 c  License along with this library; if not, write to the Free Software
 c  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
 c  02110-1301 USA
 */

package cognition.math.tensor;

import java.util.function.IntBinaryOperator;

/**
 * Matrix class.  Note the get() and set() methods are offset based
 * such that the first index is zero (C/C++ and Java convention).
 * The ndx accessor methods are one based (FORTRAN, Matlab).
 *
 * @author Kurt Motekew
 * @since 20171203
 */
public class TMatrix extends Tensor {
  private final int ROWS;
  private final int COLS;
  private final double[] vals;
  private final IntBinaryOperator off;
  private final IntBinaryOperator inx;

  /**
   * Initialize with all elements set to zero.
   *
   * @param  rows     The number of rows to create in the new matrix
   * @param  columns  The number of columns to create in the new matrix
   */
  public TMatrix(int rows, int columns) {
    super(rows, columns);
    ROWS = rows;
    COLS = columns;
    vals = super.valuesPtr();
    off = (int ii, int jj) -> COLS*ii + jj;
    inx = (int ii, int jj) -> COLS*(ii - 1) + jj - 1;
  }

  /**
   * Initialize given an array of arrays.  The first index represents
   * the row, the 2nd the column.
   *
   * @param  mtx  A double[][] used to initialize this TMatrix
   *              It should be a block double array, not jagged.
   *              Values are copied into this matrix.
   */
  public TMatrix(double[][] mtrx) {
    this(mtrx.length, mtrx[0].length);
    for (int ii=0; ii<ROWS; ii++) {
      for (int jj=0; jj<COLS; jj++) {
        vals[off.applyAsInt(ii, jj)] = mtrx[ii][jj];
      }
    }
  }

  /**
   * Initialize given an input TMatrix.
   *
   * @param  mtx  Values are copied
   */
  public TMatrix(TMatrix mtx) {
    this(mtx.ROWS, mtx.COLS);
    System.arraycopy(mtx.vals, 0, vals, 0, size());
  }

  /**
   * Copy values from an input matrix into this matrix.
   *
   * @param  mtx  Values from mtx will be copied to this TMatrix.  The
   *              rows and columns must match.
   */
  public void set(TMatrix mtx) {
    if (mtx.ROWS != ROWS  ||  mtx.COLS != COLS) {
      throw new IllegalArgumentException(
        "TMatrix.set:  Can't set a " + ROWS + "x" + COLS + " TMatrix with a " +
                                      mtx.ROWS + "x" + mtx.COLS + " TMatrix."
      );
    }
    System.arraycopy(mtx.vals, 0, vals, 0, size());
  }

  /** @return  The number of rows in this matrix */
  int numRows() { return ROWS; }

  /** @return  The number of columns in this matrix */
  int numColumns() { return COLS; }

  /**
   * Offset based accessor method
   *
   * @param  ii  Row, 0 <= ii < numRows
   * @param  jj  Column, 0 <= jj < numColumns
   *
   * @return  Value stored in the iith row offset and
   *          jjth column offset
   */
  public double get(int ii, int jj) {
    return vals[off.applyAsInt(ii, jj)];
  }

  /**
   * Offset based accessor method
   *
   * @param  ii     Row, 0 <= ii < numRows
   * @param  jj     Column, 0 <= jj < numColumns
   * @param  value  Value to store in the iith row offset and
   *                jjth column offset
   */
  public void set(int ii, int jj, double value) {
    vals[off.applyAsInt(ii, jj)] = value;
  }

  /**
   * Index based accessor method
   *
   * @param  row  Row, 1 <= ii <= numRows
   * @param  col  Column, 1 <= jj <= numColumns
   *
   * @return  Value stored in the iith row and jjth column
   */
  public double ndx(int row, int col) {
    return vals[inx.applyAsInt(row, col)];
  }

  /**
   * Index based accessor method
   *
   * @param  row    Row, 1 <= ii <= numRows
   * @param  col    Column, 1 <= jj <= numColumns
   * @param  value  Value to store in the iith row and
   *                jjth column
   */
  public void ndx(int row, int col, double value) {
    vals[inx.applyAsInt(row, col)] = value;
  }

  /**
   * Sets this matrix to the product of the two input matrices.
   * Rows and columns must be compatible - input notation assumes
   * this is a MxN matrix.
   *
   * @param  aMat  MxP matrix
   * @param  bMat  PxN matrix
   */
  public void mult(TMatrix aMat, TMatrix bMat) {
    if (aMat.ROWS != ROWS  ||  bMat.COLS != COLS  ||  aMat.COLS != bMat.ROWS) {
      throw new IllegalArgumentException("TMatrix.mult(A, B):  " +
        ROWS + "x" + COLS + " ?= " + aMat.ROWS + "x" + aMat.COLS + 
                             " * " + bMat.ROWS + "x" + bMat.COLS);
    }
    final int ACOLS = aMat.numColumns();
    zero();
    for (int ii=0; ii<ROWS; ii++) {
      for (int kk=0; kk<ACOLS; kk++) {
        for (int jj=0; jj<COLS; jj++) {
          vals[off.applyAsInt(ii, jj)] += 
              aMat.vals[aMat.off.applyAsInt(ii,kk)]*
              bMat.vals[bMat.off.applyAsInt(kk,jj)];
        }
      }
    }
  }

  /**
   * Add input matrix to this matrix
   *
   * @param  mtx  Input matrix to add.  Dimensions must match this matrix
   */
  public void plus(TMatrix mtx) {
    if (mtx.ROWS != ROWS  ||  mtx.COLS != COLS) {
      throw new IllegalArgumentException(
        "TMatrix.plus:  Can't add a " + ROWS + "x" + COLS + " TMatrix to a " +
                                     mtx.ROWS + "x" + mtx.COLS + " TMatrix."
      );
    }
    final int N = size();
    for (int ii=0; ii<N;  ii++) {
      vals[ii] += mtx.vals[ii];
    }
  }

  /**
   * Subtract input matrix from this matrix
   *
   * @param  mtx  Input matrix to subtract.  Dimensions must match this matrix
   */
  public void minus(TMatrix mtx) {
    if (mtx.ROWS != ROWS  ||  mtx.COLS != COLS) {
      throw new IllegalArgumentException(
        "TMatrix.plus:  Can't subtract a " + ROWS + "x" + COLS + 
        " TMatrix from a " + mtx.ROWS + "x" + mtx.COLS + " TMatrix."
      );
    }
    final int N = size();
    for (int ii=0; ii<N;  ii++) {
      vals[ii] -= mtx.vals[ii];
    }
  }

  /**
   * Sets this matrix to the product of the two input matrices.
   * Rows and columns must be compatible.
   *
   * @param  aMat  MxP matrix
   * @param  bMat  PxN matrix
   *
   * @return  MxN matrix
   */
  public TMatrix mult(TMatrix mat) {
    if (COLS != mat.ROWS) {
      throw new IllegalArgumentException("C = TMatrix.mult(B):  ?! " +
        ROWS + "x" + COLS + " * " + mat.ROWS + "x" + mat.COLS);
    }
    final int N = mat.numColumns();
    TMatrix m3 = new TMatrix(ROWS, N);
    for (int ii=0; ii<ROWS; ii++) {
      for (int kk=0; kk<COLS; kk++) {
        for (int jj=0; jj<N; jj++) {
          m3.vals[off.applyAsInt(ii, jj)] += vals[off.applyAsInt(ii,kk)]*
                                         mat.vals[off.applyAsInt(kk,jj)];
        }
      }
    }
    return m3;
  }
}
