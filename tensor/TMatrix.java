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

import java.util.function.IntBinaryOperator;

public class TMatrix extends Tensor {
  private final int ROWS;
  private final int COLS;
  private final double[] vals;
  private final IntBinaryOperator off;
  private final IntBinaryOperator inx;

  public TMatrix(int m, int n) {
    super(m, n);
    ROWS = m;
    COLS = n;
    vals = super.valuesPtr();
    off = (int ii, int jj) -> COLS*ii + jj;
    inx = (int ii, int jj) -> COLS*(ii - 1) + jj - 1;
  }

  public TMatrix(double[][] mtrx) {
    this(mtrx.length, mtrx[0].length);
    for (int ii=0; ii<ROWS; ii++) {
      for (int jj=0; jj<COLS; jj++) {
        vals[off.applyAsInt(ii, jj)] = mtrx[ii][jj];
      }
    }
  }

  int numRows() { return ROWS; }

  int numColumns() { return COLS; }

  public double get(int ii, int jj) {
    return vals[off.applyAsInt(ii, jj)];
  }

  public void set(int ii, int jj, double value) {
    vals[off.applyAsInt(ii, jj)] = value;
  }

  public double ndx(int row, int col) {
    return vals[inx.applyAsInt(row, col)];
  }

  public void ndx(int row, int col, double value) {
    vals[inx.applyAsInt(row, col)] = value;
  }

  public void mult(TMatrix aMat, TMatrix bMat) {
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

  public TMatrix mult(TMatrix mat) {
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
