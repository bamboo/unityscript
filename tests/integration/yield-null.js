/*
before
after
*/

function generator() {
  print("before");
  yield null;
  print("after");
}

for (var e in generator()) {
  if (e != null)
    throw "expected null";
}
