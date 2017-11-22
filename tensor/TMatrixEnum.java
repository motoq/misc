/*
 c  TMatrixEnum.java
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

public class TMatrixEnum<I extends Enum<I>, J extends Enum<J>> extends TMatrix {

  public TMatrixEnum(I ii, J jj) {
    super(ii.getDeclaringClass().getEnumConstants().length,
          jj.getDeclaringClass().getEnumConstants().length);
  }

  public double get(I eRow, J eCol) {
    return super.get(eRow.ordinal(), eCol.ordinal());
  }

  public void set(I eRow, J eCol, double value) {
    super.set(eRow.ordinal(), eCol.ordinal(), value);
  }

  public static void main(String[] args) {
    TMatrixEnum<Basis3D, Basis3D> mtx = new TMatrixEnum<>(Basis3D.I, Basis3D.J);
    //TMatrixEnum<Basis3D, Basis3D> mtx = new TMatrixEnum<>(Basis3D.I, Q.Q0);
  }
}
