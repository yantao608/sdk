// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// The test checks the gathering of the constraints during type inference in
// case the supertype of the match is a FutureOr<X> or one of its alternatives
// (either Future<X> or X).

/*cfe.library: nnbd=false*/
/*cfe:nnbd.library: nnbd=true*/
import 'dart:async';

// -----------------------------------------------------------------------------

// Gathering constraints for S from comparison Null <: FutureOr<S>.
void func1() {
  void foo<S>(FutureOr<S> bar) {}

  /*invoke: void*/ foo/*<Null>*/(/*Null*/ null);
}

// -----------------------------------------------------------------------------

// Gathering constraints for S from comparison Null <: Future<S>.
void func2() {
  void foo<S>(Future<S> bar) {}

  /*invoke: void*/ foo/*<dynamic>*/(/*Null*/ null);
}

// -----------------------------------------------------------------------------

// Gathering constraints for S from comparison Null <: S.
void func3() {
  void foo<S>(S bar) {}

  /*invoke: void*/ foo/*<Null>*/(/*Null*/ null);
}

// -----------------------------------------------------------------------------

void func4() {
  void foo<S>(FutureOr<FutureOr<S>> bar) {}

  /*invoke: void*/ foo/*<Null>*/(/*Null*/ null);
}

// -----------------------------------------------------------------------------

// Gathering constraints for S from comparison int <: FutureOr<S>.
void func5() {
  void foo<S>(FutureOr<S> bar) {}

  /*invoke: void*/ foo /*cfe|dart2js.<int>*/ /*cfe:nnbd.<int!>*/ (
      /*cfe|dart2js.int*/ /*cfe:nnbd.int!*/ 42);
}

// -----------------------------------------------------------------------------

// Gathering constraints for S from comparison int <: S.
void func6() {
  void foo<S>(S bar) {}

  /*invoke: void*/ foo /*cfe|dart2js.<int>*/ /*cfe:nnbd.<int!>*/ (
      /*cfe|dart2js.int*/ /*cfe:nnbd.int!*/ 42);
}

// -----------------------------------------------------------------------------

void func7() {
  void foo<S>(FutureOr<FutureOr<S>> bar) {}

  /*invoke: void*/ foo /*cfe|dart2js.<int>*/ /*cfe:nnbd.<int!>*/ (
      /*cfe|dart2js.int*/ /*cfe:nnbd.int!*/ 42);
}

// -----------------------------------------------------------------------------

main() {}
