// fuse_unit_test.dart -- translated Z80 unit tests from FUSE Z80 emulator
// 
// The FUSE emulator contains a large unit test suite of over 1,300 tests,
// which cover both documented and undocumented opcodes:
//   http://fuse-emulator.sourceforge.net/ 

// Run tests with 
//   pub run test test/fuse_unit_test.dart -x undocumented --no-color > test/results.txt

import 'package:test/test.dart';
import 'package:spectrum/spectrum.dart';

Memory memory = new Memory(false);
Z80 z80 = new Z80(memory, startAddress: 0xA000);

void poke(int addr, int val) => memory.writeByte(addr, val);
int peek(int addr) => memory.readByte(addr);

void loadRegisters(int af, int bc, int de, int hl, int af_, int bc_, int de_,
    int hl_, int ix, int iy, int sp, int pc) {
  z80.af = af;
  z80.bc = bc;
  z80.de = de;
  z80.hl = hl;
  z80.a_ = highByte(af_);
  z80.f_ = lowByte(af_);
  z80.b_ = highByte(bc_);
  z80.c_ = lowByte(bc_);
  z80.d_ = highByte(de_);
  z80.e_ = lowByte(de_);
  z80.h_ = highByte(hl_);
  z80.l_ = lowByte(hl_);
  z80.ix = ix;
  z80.iy = iy;
  z80.sp = sp;
  z80.pc = pc;
}

void checkRegisters(int af, int bc, int de, int hl, int af_, int bc_, int de_,
    int hl_, int ix, int iy, int sp, int pc) {
  expect(z80.af, equals(af), reason: "Register AF mismatch");
  expect(z80.bc, equals(bc), reason: "Register BC mismatch");
  expect(z80.de, equals(de), reason: "Register DE mismatch");
  expect(z80.hl, equals(hl), reason: "Register HL mismatch");
  expect(z80.af_, equals(af_), reason: "Register AF' mismatch");
  expect(z80.bc_, equals(bc_), reason: "Register BC' mismatch");
  expect(z80.de_, equals(de_), reason: "Register DE' mismatch");
  expect(z80.hl_, equals(hl_), reason: "Register HL' mismatch");
  expect(z80.ix, equals(ix), reason: "Register IX mismatch");
  expect(z80.iy, equals(iy), reason: "Register IY mismatch");
  expect(z80.sp, equals(sp), reason: "Register SP mismatch");
  expect(z80.pc, equals(pc), reason: "Register PC mismatch");
}

void checkSpecialRegisters(int i, int r, bool iff1, bool iff2, int tStates) {
  expect(z80.i, equals(i));

  // TODO: r is magic and we haven't done magic yet
  // expect(z80.r, equals(r));

  expect(z80.iff1, equals(iff1));
  expect(z80.iff2, equals(iff2));
  expect(z80.tStates, equals(tStates));
}

main() {
  setUp(() {
    z80.reset();
    memory.reset();
  });
  tearDown(() {});


  // Test instruction 00
  test('00', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x00);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 01
  test('01', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x01);
    poke(0x0001, 0x12);
    poke(0x0002, 0x34);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x3412, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction 02
  test('02', () {
    // Set up machine initial state
    loadRegisters(0x5600, 0x0001, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x02);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5600, 0x0001, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
    expect(peek(1), equals(0x56));
  });


  // Test instruction 02_1
  test('02_1', () {
    // Set up machine initial state
    loadRegisters(0x1300, 0x6b65, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x02);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1300, 0x6b65, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
    expect(peek(27493), equals(0x13));
  });


  // Test instruction 03
  test('03', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x789a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x03);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x789b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 6);
  });


  // Test instruction 04
  test('04', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0xff00, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x04);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0050, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 05
  test('05', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x05);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x00ba, 0xff00, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 06
  test('06', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x06);
    poke(0x0001, 0xbc);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0xbc00, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction 07
  test('07', () {
    // Set up machine initial state
    loadRegisters(0x8800, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x07);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1101, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 08
  test('08', () {
    // Set up machine initial state
    loadRegisters(0xdef0, 0x0000, 0x0000, 0x0000, 0x1234, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x08);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1234, 0x0000, 0x0000, 0x0000, 0xdef0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 09
  test('09', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x5678, 0x0000, 0x9abc, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x09);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0030, 0x5678, 0x0000, 0xf134, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
  });


  // Test instruction 0a
  test('0a', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0001, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x0a);
    poke(0x0001, 0xde);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xde00, 0x0001, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction 0a_1
  test('0a_1', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x1234, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x0a);
    poke(0x1234, 0x56);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5600, 0x1234, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction 0b
  test('0b', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x0b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0xffff, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 6);
  });


  // Test instruction 0c
  test('0c', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x007f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x0c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0094, 0x0080, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 0d
  test('0d', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0080, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x0d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x003e, 0x007f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 0e
  test('0e', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x0e);
    poke(0x0001, 0xf0);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x00f0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction 0f
  test('0f', () {
    // Set up machine initial state
    loadRegisters(0x4100, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x0f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa021, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 10
  test('10', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0800, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x00);
    poke(0x0001, 0x10);
    poke(0x0002, 0xfd);
    poke(0x0003, 0x0c);

    // Execute machine for tState cycles
    while(z80.tStates < 132) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0001, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x11, false, false, 135);
  });


  // Test instruction 11
  test('11', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x11);
    poke(0x0001, 0x9a);
    poke(0x0002, 0xbc);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0xbc9a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction 12
  test('12', () {
    // Set up machine initial state
    loadRegisters(0x5600, 0x0000, 0x8000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x12);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5600, 0x0000, 0x8000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
    expect(peek(32768), equals(0x56));
  });


  // Test instruction 13
  test('13', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0xdef0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x13);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0xdef1, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 6);
  });


  // Test instruction 14
  test('14', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x2700, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x14);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0028, 0x0000, 0x2800, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 15
  test('15', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x1000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x15);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x001a, 0x0000, 0x0f00, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 16
  test('16', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x16);
    poke(0x0001, 0x12);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x1200, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction 17
  test('17', () {
    // Set up machine initial state
    loadRegisters(0x0801, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x17);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1100, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 18
  test('18', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x18);
    poke(0x0001, 0x40);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0042);
    checkSpecialRegisters(0x00, 0x01, false, false, 12);
  });


  // Test instruction 19
  test('19', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x3456, 0x789a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x19);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0028, 0x0000, 0x3456, 0xacf0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
  });


  // Test instruction 1a
  test('1a', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x8000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x1a);
    poke(0x8000, 0x13);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1300, 0x0000, 0x8000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction 1b
  test('1b', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0xe5d4, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x1b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0xe5d3, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 6);
  });


  // Test instruction 1c
  test('1c', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x00aa, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x1c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x00a8, 0x0000, 0x00ab, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 1d
  test('1d', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x00aa, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x1d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x00aa, 0x0000, 0x00a9, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 1e
  test('1e', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x1e);
    poke(0x0001, 0xef);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x00ef, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction 1f
  test('1f', () {
    // Set up machine initial state
    loadRegisters(0x01c4, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x1f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x00c5, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 20_1
  test('20_1', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x20);
    poke(0x0001, 0x40);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0042);
    checkSpecialRegisters(0x00, 0x01, false, false, 12);
  });


  // Test instruction 20_2
  test('20_2', () {
    // Set up machine initial state
    loadRegisters(0x0040, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x20);
    poke(0x0001, 0x40);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0040, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction 21
  test('21', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x21);
    poke(0x0001, 0x28);
    poke(0x0002, 0xed);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0xed28, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction 22
  test('22', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0xc64c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x22);
    poke(0x0001, 0xb0);
    poke(0x0002, 0xc3);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0xc64c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x01, false, false, 16);
    expect(peek(50096), equals(0x4c));
    expect(peek(50097), equals(0xc6));
  });


  // Test instruction 23
  test('23', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x9c4e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x23);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0x9c4f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 6);
  });


  // Test instruction 24
  test('24', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x7200, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x24);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0020, 0x0000, 0x0000, 0x7300, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 25
  test('25', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0xa500, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x25);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x00a2, 0x0000, 0x0000, 0xa400, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 26
  test('26', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x26);
    poke(0x0001, 0x3a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0x3a00, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction 27_1
  test('27_1', () {
    // Set up machine initial state
    loadRegisters(0x9a02, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x27);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3423, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 27
  test('27', () {
    // Set up machine initial state
    loadRegisters(0x1f00, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x27);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2530, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 28_1
  test('28_1', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x28);
    poke(0x0001, 0x8e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction 28_2
  test('28_2', () {
    // Set up machine initial state
    loadRegisters(0x0040, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x28);
    poke(0x0001, 0x8e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0040, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xff90);
    checkSpecialRegisters(0x00, 0x01, false, false, 12);
  });


  // Test instruction 29
  test('29', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0xcdfa, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x29);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0019, 0x0000, 0x0000, 0x9bf4, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
  });


  // Test instruction 2a
  test('2a', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x2a);
    poke(0x0001, 0x45);
    poke(0x0002, 0xac);
    poke(0xac45, 0xc4);
    poke(0xac46, 0xde);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0xdec4, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x01, false, false, 16);
  });


  // Test instruction 2b
  test('2b', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x9e66, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x2b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0x9e65, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 6);
  });


  // Test instruction 2c
  test('2c', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0026, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x2c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0020, 0x0000, 0x0000, 0x0027, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 2d
  test('2d', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0032, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x2d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0022, 0x0000, 0x0000, 0x0031, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 2e
  test('2e', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x2e);
    poke(0x0001, 0x18);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0x0018, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction 2f
  test('2f', () {
    // Set up machine initial state
    loadRegisters(0x8900, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x2f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7632, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 30_1
  test('30_1', () {
    // Set up machine initial state
    loadRegisters(0x0036, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x30);
    poke(0x0001, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0036, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0052);
    checkSpecialRegisters(0x00, 0x01, false, false, 12);
  });


  // Test instruction 30_2
  test('30_2', () {
    // Set up machine initial state
    loadRegisters(0x0037, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x30);
    poke(0x0001, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0037, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction 31
  test('31', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x31);
    poke(0x0001, 0xd4);
    poke(0x0002, 0x61);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x61d4, 0x0003);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction 32
  test('32', () {
    // Set up machine initial state
    loadRegisters(0x0e00, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x32);
    poke(0x0001, 0xac);
    poke(0x0002, 0xad);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0e00, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x01, false, false, 13);
    expect(peek(44460), equals(0x0e));
  });


  // Test instruction 32_1
  test('32_1', () {
    // Set up machine initial state
    loadRegisters(0x5600, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x32);
    poke(0x0001, 0x34);
    poke(0x0002, 0x12);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5600, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x01, false, false, 13);
    expect(peek(4660), equals(0x56));
  });


  // Test instruction 33
  test('33', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xa55a, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x33);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xa55b, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 6);
  });


  // Test instruction 34
  test('34', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0xfe1d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x34);
    poke(0xfe1d, 0xfd);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x00a8, 0x0000, 0x0000, 0xfe1d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
    expect(peek(65053), equals(0xfe));
  });


  // Test instruction 35
  test('35', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x470c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x35);
    poke(0x470c, 0x82);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0082, 0x0000, 0x0000, 0x470c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
    expect(peek(18188), equals(0x81));
  });


  // Test instruction 36
  test('36', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x7d29, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x36);
    poke(0x0001, 0x7c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0x7d29, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
    expect(peek(32041), equals(0x7c));
  });


  // Test instruction 37_1
  test('37_1', () {
    // Set up machine initial state
    loadRegisters(0x00ff, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x37);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x00c5, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 37_2
  test('37_2', () {
    // Set up machine initial state
    loadRegisters(0xff00, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x37);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xff29, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 37_3
  test('37_3', () {
    // Set up machine initial state
    loadRegisters(0xffff, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x37);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xffed, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 37
  test('37', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x37);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0001, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 38_1
  test('38_1', () {
    // Set up machine initial state
    loadRegisters(0x00b2, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x38);
    poke(0x0001, 0x66);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x00b2, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction 38_2
  test('38_2', () {
    // Set up machine initial state
    loadRegisters(0x00b3, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x38);
    poke(0x0001, 0x66);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x00b3, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0068);
    checkSpecialRegisters(0x00, 0x01, false, false, 12);
  });


  // Test instruction 39
  test('39', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x1aef, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xc534, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x39);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0030, 0x0000, 0x0000, 0xe023, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xc534, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
  });


  // Test instruction 3a
  test('3a', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x3a);
    poke(0x0001, 0x52);
    poke(0x0002, 0x99);
    poke(0x9952, 0x28);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2800, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x01, false, false, 13);
  });


  // Test instruction 3b
  test('3b', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x9d36, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x3b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x9d35, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 6);
  });


  // Test instruction 3c
  test('3c', () {
    // Set up machine initial state
    loadRegisters(0xcf00, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x3c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd090, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 3d
  test('3d', () {
    // Set up machine initial state
    loadRegisters(0xea00, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x3d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe9aa, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 3e
  test('3e', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x3e);
    poke(0x0001, 0xd6);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd600, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction 3f
  test('3f', () {
    // Set up machine initial state
    loadRegisters(0x005b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x3f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0050, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 40
  test('40', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x40);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 41
  test('41', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x41);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0x9898, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 42
  test('42', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x42);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0x9098, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 43
  test('43', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x43);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xd898, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 44
  test('44', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x44);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xa198, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 45
  test('45', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x45);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0x6998, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 46
  test('46', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x46);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0x5098, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction 47
  test('47', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x47);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0x0298, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 48
  test('48', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x48);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcfcf, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 49
  test('49', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x49);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 4a
  test('4a', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x4a);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf90, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 4b
  test('4b', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x4b);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcfd8, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 4c
  test('4c', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x4c);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcfa1, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  }, tags: 'undocumented');


  // Test instruction 4d
  test('4d', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x4d);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf69, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 4e
  test('4e', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x4e);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf50, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  }, tags: 'undocumented');


  // Test instruction 4f
  test('4f', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x4f);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf02, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 50
  test('50', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x50);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0xcfd8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 51
  test('51', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x51);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x98d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 52
  test('52', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x52);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 53
  test('53', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x53);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0xd8d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 54
  test('54', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x54);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0xa1d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  }, tags: 'undocumented');


  // Test instruction 55
  test('55', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x55);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x69d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 56
  test('56', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x56);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x50d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction 57
  test('57', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x57);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x02d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 58
  test('58', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x58);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90cf, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 59
  test('59', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x59);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x9098, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 5a
  test('5a', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x5a);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x9090, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 5b
  test('5b', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x5b);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 5c
  test('5c', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x5c);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90a1, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  }, tags: 'undocumented');


  // Test instruction 5d
  test('5d', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x5d);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x9069, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 5e
  test('5e', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x5e);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x9050, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction 5f
  test('5f', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x5f);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x9002, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 60
  test('60', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x60);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90d8, 0xcf69, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 61
  test('61', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x61);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90d8, 0x9869, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 62
  test('62', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x62);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90d8, 0x9069, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 63
  test('63', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x63);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90d8, 0xd869, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  }, tags: 'undocumented');


  // Test instruction 64
  test('64', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x64);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  }, tags: 'undocumented');


  // Test instruction 65
  test('65', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x65);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90d8, 0x6969, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 66
  test('66', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x66);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90d8, 0x5069, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction 67
  test('67', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x67);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90d8, 0x0269, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 68
  test('68', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x68);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90d8, 0xa1cf, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 69
  test('69', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x69);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90d8, 0xa198, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 6a
  test('6a', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x6a);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90d8, 0xa190, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 6b
  test('6b', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x6b);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90d8, 0xa1d8, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  }, tags: 'undocumented');


  // Test instruction 6c
  test('6c', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x6c);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90d8, 0xa1a1, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  }, tags: 'undocumented');


  // Test instruction 6d
  test('6d', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x6d);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 6e
  test('6e', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x6e);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90d8, 0xa150, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  }, tags: 'undocumented');


  // Test instruction 6f
  test('6f', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x6f);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90d8, 0xa102, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 70
  test('70', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x70);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
    expect(peek(41321), equals(0xcf));
  }, tags: 'undocumented');


  // Test instruction 71
  test('71', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x71);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
    expect(peek(41321), equals(0x98));
  }, tags: 'undocumented');


  // Test instruction 72
  test('72', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x72);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
    expect(peek(41321), equals(0x90));
  });


  // Test instruction 73
  test('73', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x73);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
    expect(peek(41321), equals(0xd8));
  });


  // Test instruction 74
  test('74', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x74);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
    expect(peek(41321), equals(0xa1));
  }, tags: 'undocumented');


  // Test instruction 75
  test('75', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x75);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
    expect(peek(41321), equals(0x69));
  });


  // Test instruction 76
  test('76', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x76);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 77
  test('77', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x77);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
    expect(peek(41321), equals(0x02));
  });


  // Test instruction 78
  test('78', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x78);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xcf00, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 79
  test('79', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x79);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9800, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 7a
  test('7a', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x7a);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9000, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 7b
  test('7b', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x7b);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd800, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 7c
  test('7c', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x7c);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa100, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  }, tags: 'undocumented');


  // Test instruction 7d
  test('7d', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x7d);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6900, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 7e
  test('7e', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x7e);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5000, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction 7f
  test('7f', () {
    // Set up machine initial state
    loadRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x7f);
    poke(0xa169, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0xcf98, 0x90d8, 0xa169, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 80
  test('80', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x80);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0411, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 81
  test('81', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x81);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3031, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 82
  test('82', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x82);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1501, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 83
  test('83', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x83);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0211, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 84
  test('84', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x84);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd191, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 85
  test('85', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x85);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9b89, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 86
  test('86', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x86);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3e29, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction 87
  test('87', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x87);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xeaa9, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 88
  test('88', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x88);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0411, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 89
  test('89', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x89);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3031, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 8a
  test('8a', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x8a);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1501, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 8b
  test('8b', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x8b);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0211, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 8c
  test('8c', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x8c);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd191, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 8d
  test('8d', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x8d);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9b89, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 8e
  test('8e', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x8e);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3e29, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction 8f
  test('8f', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x8f);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xeaa9, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 90
  test('90', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x90);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe6b2, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 91
  test('91', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x91);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xbaba, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 92
  test('92', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x92);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd582, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 93
  test('93', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x93);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe8ba, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 94
  test('94', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x94);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x191a, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 95
  test('95', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x95);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4f1a, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 96
  test('96', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x96);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xacba, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction 97
  test('97', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x97);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0042, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 98
  test('98', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x98);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe6b2, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 99
  test('99', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x99);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xbaba, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 9a
  test('9a', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x9a);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd582, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 9b
  test('9b', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x9b);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe8ba, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 9c
  test('9c', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x9c);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x191a, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 9d
  test('9d', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x9d);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4f1a, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction 9e
  test('9e', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x9e);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xacba, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction 9f
  test('9f', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0x9f);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0042, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction a0
  test('a0', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xa0);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0514, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction a1
  test('a1', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xa1);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3130, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction a2
  test('a2', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xa2);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2030, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction a3
  test('a3', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xa3);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0514, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction a4
  test('a4', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xa4);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd494, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction a5
  test('a5', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xa5);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa4b0, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction a6
  test('a6', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xa6);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4114, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction a7
  test('a7', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xa7);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf5b4, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction a8
  test('a8', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xa8);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xfaac, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction a9
  test('a9', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xa9);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xce88, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction aa
  test('aa', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xaa);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd580, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction ab
  test('ab', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xab);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf8a8, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction ac
  test('ac', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xac);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2928, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction ad
  test('ad', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xad);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5304, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction ae
  test('ae', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xae);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xbca8, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction af
  test('af', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xaf);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0044, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction b0
  test('b0', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xb0);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xffac, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction b1
  test('b1', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xb1);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xffac, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction b2
  test('b2', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xb2);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf5a4, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction b3
  test('b3', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xb3);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xfda8, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction b4
  test('b4', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xb4);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xfda8, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction b5
  test('b5', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xb5);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf7a0, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction b6
  test('b6', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xb6);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xfda8, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction b7
  test('b7', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xb7);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf5a4, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction b8
  test('b8', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xb8);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf59a, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction b9
  test('b9', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xb9);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf5ba, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction ba
  test('ba', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xba);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf5a2, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction bb
  test('bb', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xbb);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf59a, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction bc
  test('bc', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xbc);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf51a, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction bd
  test('bd', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xbd);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf532, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction be
  test('be', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xbe);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf59a, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction bf
  test('bf', () {
    // Set up machine initial state
    loadRegisters(0xf500, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xbf);
    poke(0xdca6, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf562, 0x0f3b, 0x200d, 0xdca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction c0_1
  test('c0_1', () {
    // Set up machine initial state
    loadRegisters(0x0098, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f7, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xc0);
    poke(0x43f7, 0xe9);
    poke(0x43f8, 0xaf);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0098, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f9, 0xafe9);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
  });


  // Test instruction c0_2
  test('c0_2', () {
    // Set up machine initial state
    loadRegisters(0x00d8, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f7, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xc0);
    poke(0x43f7, 0xe9);
    poke(0x43f8, 0xaf);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x00d8, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f7, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 5);
  });


  // Test instruction c1
  test('c1', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x4143, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xc1);
    poke(0x4143, 0xce);
    poke(0x4144, 0xe8);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0xe8ce, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x4145, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction c2_1
  test('c2_1', () {
    // Set up machine initial state
    loadRegisters(0x0087, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xc2);
    poke(0x0001, 0x1b);
    poke(0x0002, 0xe1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0087, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xe11b);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction c2_2
  test('c2_2', () {
    // Set up machine initial state
    loadRegisters(0x00c7, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xc2);
    poke(0x0001, 0x1b);
    poke(0x0002, 0xe1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x00c7, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction c3
  test('c3', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xc3);
    poke(0x0001, 0xed);
    poke(0x0002, 0x7c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x7ced);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction c4_1
  test('c4_1', () {
    // Set up machine initial state
    loadRegisters(0x000e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5698, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xc4);
    poke(0x0001, 0x61);
    poke(0x0002, 0x9c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x000e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5696, 0x9c61);
    checkSpecialRegisters(0x00, 0x01, false, false, 17);
    expect(peek(22166), equals(0x03));
    expect(peek(22167), equals(0x00));
  });


  // Test instruction c4_2
  test('c4_2', () {
    // Set up machine initial state
    loadRegisters(0x004e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5698, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xc4);
    poke(0x0001, 0x61);
    poke(0x0002, 0x9c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x004e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5698, 0x0003);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction c5
  test('c5', () {
    // Set up machine initial state
    loadRegisters(0x53e3, 0x1459, 0x775f, 0x1a2f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xec12, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xc5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x53e3, 0x1459, 0x775f, 0x1a2f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xec10, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
    expect(peek(60432), equals(0x59));
    expect(peek(60433), equals(0x14));
  });


  // Test instruction c6
  test('c6', () {
    // Set up machine initial state
    loadRegisters(0xca00, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xc6);
    poke(0x0001, 0x6f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3939, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction c7
  test('c7', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5507, 0x6d33);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x6d33, 0xc7);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5505, 0x0000);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
    expect(peek(21765), equals(0x34));
    expect(peek(21766), equals(0x6d));
  });


  // Test instruction c8_1
  test('c8_1', () {
    // Set up machine initial state
    loadRegisters(0x0098, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f7, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xc8);
    poke(0x43f7, 0xe9);
    poke(0x43f8, 0xaf);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0098, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f7, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 5);
  });


  // Test instruction c8_2
  test('c8_2', () {
    // Set up machine initial state
    loadRegisters(0x00d8, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f7, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xc8);
    poke(0x43f7, 0xe9);
    poke(0x43f8, 0xaf);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x00d8, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f9, 0xafe9);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
  });


  // Test instruction c9
  test('c9', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x887e, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xc9);
    poke(0x887e, 0x36);
    poke(0x887f, 0x11);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x8880, 0x1136);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction ca_1
  test('ca_1', () {
    // Set up machine initial state
    loadRegisters(0x0087, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xca);
    poke(0x0001, 0x1b);
    poke(0x0002, 0xe1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0087, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction ca_2
  test('ca_2', () {
    // Set up machine initial state
    loadRegisters(0x00c7, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xca);
    poke(0x0001, 0x1b);
    poke(0x0002, 0xe1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x00c7, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xe11b);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction cb00
  test('cb00', () {
    // Set up machine initial state
    loadRegisters(0xda00, 0xe479, 0x552e, 0xa806, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x00);
    poke(0xa806, 0x76);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xda8d, 0xc979, 0x552e, 0xa806, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb01
  test('cb01', () {
    // Set up machine initial state
    loadRegisters(0x1000, 0xb379, 0xb480, 0xef65, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x01);
    poke(0xef65, 0xfb);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x10a0, 0xb3f2, 0xb480, 0xef65, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb02
  test('cb02', () {
    // Set up machine initial state
    loadRegisters(0x2e00, 0x9adf, 0xae6e, 0xa7f2, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x02);
    poke(0xa7f2, 0x4a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2e09, 0x9adf, 0x5d6e, 0xa7f2, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb03
  test('cb03', () {
    // Set up machine initial state
    loadRegisters(0x6800, 0x9995, 0xde3f, 0xca71, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x03);
    poke(0xca71, 0xe7);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x682c, 0x9995, 0xde7e, 0xca71, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb04
  test('cb04', () {
    // Set up machine initial state
    loadRegisters(0x8c00, 0xbeea, 0x0ce4, 0x67b0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x04);
    poke(0x67b0, 0xcd);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8c88, 0xbeea, 0x0ce4, 0xceb0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb05
  test('cb05', () {
    // Set up machine initial state
    loadRegisters(0x3600, 0xe19f, 0x78c9, 0xcb32, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x05);
    poke(0xcb32, 0x1b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3620, 0xe19f, 0x78c9, 0xcb64, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb06
  test('cb06', () {
    // Set up machine initial state
    loadRegisters(0x8a00, 0xdb02, 0x8fb1, 0x5b04, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x06);
    poke(0x5b04, 0xd4);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8aad, 0xdb02, 0x8fb1, 0x5b04, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
    expect(peek(23300), equals(0xa9));
  });


  // Test instruction cb07
  test('cb07', () {
    // Set up machine initial state
    loadRegisters(0x6d00, 0x19cf, 0x7259, 0xdcaa, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x07);
    poke(0xdcaa, 0x8d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xda88, 0x19cf, 0x7259, 0xdcaa, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb08
  test('cb08', () {
    // Set up machine initial state
    loadRegisters(0x8000, 0xcdb5, 0x818e, 0x2ee2, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x08);
    poke(0x2ee2, 0x53);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x80a1, 0xe6b5, 0x818e, 0x2ee2, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb09
  test('cb09', () {
    // Set up machine initial state
    loadRegisters(0x1800, 0x125c, 0xdd97, 0x59c6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x09);
    poke(0x59c6, 0x9e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x182c, 0x122e, 0xdd97, 0x59c6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb0a
  test('cb0a', () {
    // Set up machine initial state
    loadRegisters(0x1200, 0x3ba1, 0x7724, 0x63ad, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x0a);
    poke(0x63ad, 0x96);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x12ad, 0x3ba1, 0xbb24, 0x63ad, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb0b
  test('cb0b', () {
    // Set up machine initial state
    loadRegisters(0x7600, 0x2abf, 0xb626, 0x0289, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x0b);
    poke(0x0289, 0x37);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7600, 0x2abf, 0xb613, 0x0289, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb0c
  test('cb0c', () {
    // Set up machine initial state
    loadRegisters(0x0e00, 0x6fc5, 0x2f12, 0x34d9, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x0c);
    poke(0x34d9, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0e08, 0x6fc5, 0x2f12, 0x1ad9, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb0d
  test('cb0d', () {
    // Set up machine initial state
    loadRegisters(0x6300, 0x95a3, 0xfcd2, 0x519a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x0d);
    poke(0x519a, 0x7a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x630c, 0x95a3, 0xfcd2, 0x514d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb0e
  test('cb0e', () {
    // Set up machine initial state
    loadRegisters(0xfc00, 0xadf9, 0x4925, 0x543e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x0e);
    poke(0x543e, 0xd2);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xfc2c, 0xadf9, 0x4925, 0x543e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
    expect(peek(21566), equals(0x69));
  });


  // Test instruction cb0f
  test('cb0f', () {
    // Set up machine initial state
    loadRegisters(0xc300, 0x18f3, 0x41b8, 0x070b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x0f);
    poke(0x070b, 0x86);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe1a5, 0x18f3, 0x41b8, 0x070b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb10
  test('cb10', () {
    // Set up machine initial state
    loadRegisters(0xf800, 0xdc25, 0x33b3, 0x0d74, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x10);
    poke(0x0d74, 0x3d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf8ad, 0xb825, 0x33b3, 0x0d74, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb11
  test('cb11', () {
    // Set up machine initial state
    loadRegisters(0x6500, 0xe25c, 0x4b8a, 0xed42, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x11);
    poke(0xed42, 0xb7);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x65ac, 0xe2b8, 0x4b8a, 0xed42, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb12
  test('cb12', () {
    // Set up machine initial state
    loadRegisters(0x7700, 0x1384, 0x0f50, 0x29c6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x12);
    poke(0x29c6, 0x88);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x770c, 0x1384, 0x1e50, 0x29c6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb13
  test('cb13', () {
    // Set up machine initial state
    loadRegisters(0xce00, 0x9f17, 0xe128, 0x3ed7, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x13);
    poke(0x3ed7, 0xea);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xce04, 0x9f17, 0xe150, 0x3ed7, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb14
  test('cb14', () {
    // Set up machine initial state
    loadRegisters(0xb200, 0x541a, 0x60c7, 0x7c9a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x14);
    poke(0x7c9a, 0x0f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb2a8, 0x541a, 0x60c7, 0xf89a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb15
  test('cb15', () {
    // Set up machine initial state
    loadRegisters(0x2d00, 0xc1df, 0x6eab, 0x03e2, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x15);
    poke(0x03e2, 0xbc);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2d81, 0xc1df, 0x6eab, 0x03c4, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb16
  test('cb16', () {
    // Set up machine initial state
    loadRegisters(0x3600, 0x3b53, 0x1a4a, 0x684e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x16);
    poke(0x684e, 0xc3);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3681, 0x3b53, 0x1a4a, 0x684e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
    expect(peek(26702), equals(0x86));
  });


  // Test instruction cb17
  test('cb17', () {
    // Set up machine initial state
    loadRegisters(0x5400, 0xd090, 0xf60d, 0x0fa2, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x17);
    poke(0x0fa2, 0x23);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa8a8, 0xd090, 0xf60d, 0x0fa2, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb18
  test('cb18', () {
    // Set up machine initial state
    loadRegisters(0x8600, 0xc658, 0x755f, 0x9596, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x18);
    poke(0x9596, 0xb6);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8624, 0x6358, 0x755f, 0x9596, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb19
  test('cb19', () {
    // Set up machine initial state
    loadRegisters(0x9600, 0xbeb3, 0x7c22, 0x71c8, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x19);
    poke(0x71c8, 0x85);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x960d, 0xbe59, 0x7c22, 0x71c8, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb1a
  test('cb1a', () {
    // Set up machine initial state
    loadRegisters(0x3900, 0x882f, 0x543b, 0x5279, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x1a);
    poke(0x5279, 0x26);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3928, 0x882f, 0x2a3b, 0x5279, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb1b
  test('cb1b', () {
    // Set up machine initial state
    loadRegisters(0x9e00, 0xb338, 0x876c, 0xe8b4, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x1b);
    poke(0xe8b4, 0xb9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9e24, 0xb338, 0x8736, 0xe8b4, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb1c
  test('cb1c', () {
    // Set up machine initial state
    loadRegisters(0x4b00, 0xb555, 0x238f, 0x311d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x1c);
    poke(0x311d, 0x11);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4b0d, 0xb555, 0x238f, 0x181d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb1d
  test('cb1d', () {
    // Set up machine initial state
    loadRegisters(0x2100, 0x3d7e, 0x5e39, 0xe451, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x1d);
    poke(0xe451, 0x47);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x212d, 0x3d7e, 0x5e39, 0xe428, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb1e
  test('cb1e', () {
    // Set up machine initial state
    loadRegisters(0x5e00, 0x66b9, 0x80dc, 0x00ef, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x1e);
    poke(0x00ef, 0x91);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5e0d, 0x66b9, 0x80dc, 0x00ef, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
    expect(peek(239), equals(0x48));
  });


  // Test instruction cb1f
  test('cb1f', () {
    // Set up machine initial state
    loadRegisters(0xed00, 0xb838, 0x8e18, 0xace7, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x1f);
    poke(0xace7, 0x82);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7621, 0xb838, 0x8e18, 0xace7, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb20
  test('cb20', () {
    // Set up machine initial state
    loadRegisters(0xc700, 0x0497, 0xd72b, 0xccb6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x20);
    poke(0xccb6, 0x1a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc708, 0x0897, 0xd72b, 0xccb6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb21
  test('cb21', () {
    // Set up machine initial state
    loadRegisters(0x2200, 0x5cf4, 0x938e, 0x37a8, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x21);
    poke(0x37a8, 0xdd);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x22ad, 0x5ce8, 0x938e, 0x37a8, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb22
  test('cb22', () {
    // Set up machine initial state
    loadRegisters(0x8500, 0x0950, 0xe7e8, 0x0641, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x22);
    poke(0x0641, 0x4d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8589, 0x0950, 0xcee8, 0x0641, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb23
  test('cb23', () {
    // Set up machine initial state
    loadRegisters(0x2100, 0x2a7c, 0x37d0, 0xaa59, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x23);
    poke(0xaa59, 0xc1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x21a5, 0x2a7c, 0x37a0, 0xaa59, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb24
  test('cb24', () {
    // Set up machine initial state
    loadRegisters(0xfb00, 0xb9de, 0x7014, 0x84b6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x24);
    poke(0x84b6, 0x80);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xfb09, 0xb9de, 0x7014, 0x08b6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb25
  test('cb25', () {
    // Set up machine initial state
    loadRegisters(0x1500, 0x6bbc, 0x894e, 0x85bc, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x25);
    poke(0x85bc, 0xef);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x152d, 0x6bbc, 0x894e, 0x8578, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb26
  test('cb26', () {
    // Set up machine initial state
    loadRegisters(0x0a00, 0x372e, 0xe315, 0x283a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x26);
    poke(0x283a, 0xee);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0a89, 0x372e, 0xe315, 0x283a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
    expect(peek(10298), equals(0xdc));
  });


  // Test instruction cb27
  test('cb27', () {
    // Set up machine initial state
    loadRegisters(0xbf00, 0xbdba, 0x67ab, 0x5ea2, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x27);
    poke(0x5ea2, 0xbd);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7e2d, 0xbdba, 0x67ab, 0x5ea2, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb28
  test('cb28', () {
    // Set up machine initial state
    loadRegisters(0xc000, 0x0435, 0x3e0f, 0x021b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x28);
    poke(0x021b, 0x90);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc000, 0x0235, 0x3e0f, 0x021b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb29
  test('cb29', () {
    // Set up machine initial state
    loadRegisters(0x0600, 0xf142, 0x6ada, 0xc306, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x29);
    poke(0xc306, 0x5c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0624, 0xf121, 0x6ada, 0xc306, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb2a
  test('cb2a', () {
    // Set up machine initial state
    loadRegisters(0x3000, 0xec3a, 0x7f7d, 0x3473, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x2a);
    poke(0x3473, 0x34);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x302d, 0xec3a, 0x3f7d, 0x3473, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb2b
  test('cb2b', () {
    // Set up machine initial state
    loadRegisters(0xe000, 0xccf0, 0xbbda, 0xb78a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x2b);
    poke(0xb78a, 0xab);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe0ac, 0xccf0, 0xbbed, 0xb78a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb2c
  test('cb2c', () {
    // Set up machine initial state
    loadRegisters(0x5b00, 0x25c0, 0x996d, 0x1e7b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x2c);
    poke(0x1e7b, 0x2c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5b0c, 0x25c0, 0x996d, 0x0f7b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb2d
  test('cb2d', () {
    // Set up machine initial state
    loadRegisters(0x5e00, 0xc51b, 0x58e3, 0x78ea, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x2d);
    poke(0x78ea, 0x85);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5ea4, 0xc51b, 0x58e3, 0x78f5, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb2e
  test('cb2e', () {
    // Set up machine initial state
    loadRegisters(0x3900, 0xa2cd, 0x0629, 0x24bf, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x2e);
    poke(0x24bf, 0xb5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3989, 0xa2cd, 0x0629, 0x24bf, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
    expect(peek(9407), equals(0xda));
  });


  // Test instruction cb2f
  test('cb2f', () {
    // Set up machine initial state
    loadRegisters(0xaa00, 0xa194, 0xd0e3, 0x5c65, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x2f);
    poke(0x5c65, 0xc9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd580, 0xa194, 0xd0e3, 0x5c65, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb30
  test('cb30', () {
    // Set up machine initial state
    loadRegisters(0xcd00, 0x7a81, 0xd67b, 0x656b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x30);
    poke(0x656b, 0x32);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xcda4, 0xf581, 0xd67b, 0x656b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction cb31
  test('cb31', () {
    // Set up machine initial state
    loadRegisters(0x2800, 0xe7fa, 0x6d8c, 0x75a4, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x31);
    poke(0x75a4, 0x0c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x28a5, 0xe7f5, 0x6d8c, 0x75a4, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction cb32
  test('cb32', () {
    // Set up machine initial state
    loadRegisters(0x1300, 0x3f36, 0xf608, 0x5e56, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x32);
    poke(0x5e56, 0x8d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x13ad, 0x3f36, 0xed08, 0x5e56, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction cb33
  test('cb33', () {
    // Set up machine initial state
    loadRegisters(0xd500, 0x9720, 0x7644, 0x038f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x33);
    poke(0x038f, 0xba);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd588, 0x9720, 0x7689, 0x038f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction cb34
  test('cb34', () {
    // Set up machine initial state
    loadRegisters(0x1200, 0x77f6, 0x0206, 0xfb38, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x34);
    poke(0xfb38, 0x07);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x12a1, 0x77f6, 0x0206, 0xf738, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction cb35
  test('cb35', () {
    // Set up machine initial state
    loadRegisters(0x3c00, 0xfd68, 0xea91, 0x7861, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x35);
    poke(0x7861, 0x72);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3c84, 0xfd68, 0xea91, 0x78c3, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction cb36
  test('cb36', () {
    // Set up machine initial state
    loadRegisters(0x8a00, 0x1185, 0x1dde, 0x6d38, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x36);
    poke(0x6d38, 0xf1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8aa1, 0x1185, 0x1dde, 0x6d38, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
    expect(peek(27960), equals(0xe3));
  }, tags: 'undocumented');


  // Test instruction cb37
  test('cb37', () {
    // Set up machine initial state
    loadRegisters(0x4300, 0xd7bc, 0x9133, 0x6e56, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x37);
    poke(0x6e56, 0xf8);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8784, 0xd7bc, 0x9133, 0x6e56, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction cb38
  test('cb38', () {
    // Set up machine initial state
    loadRegisters(0xdf00, 0x7c1b, 0x9f9f, 0x4ff2, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x38);
    poke(0x4ff2, 0xaa);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xdf28, 0x3e1b, 0x9f9f, 0x4ff2, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb39
  test('cb39', () {
    // Set up machine initial state
    loadRegisters(0x6600, 0xb702, 0x14f5, 0x3c17, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x39);
    poke(0x3c17, 0x61);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6600, 0xb701, 0x14f5, 0x3c17, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb3a
  test('cb3a', () {
    // Set up machine initial state
    loadRegisters(0xd100, 0x5c5f, 0xe42e, 0xf1b1, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x3a);
    poke(0xf1b1, 0x6e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd124, 0x5c5f, 0x722e, 0xf1b1, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb3b
  test('cb3b', () {
    // Set up machine initial state
    loadRegisters(0xb200, 0x38c8, 0xa560, 0x7419, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x3b);
    poke(0x7419, 0x11);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb224, 0x38c8, 0xa530, 0x7419, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb3c
  test('cb3c', () {
    // Set up machine initial state
    loadRegisters(0x7800, 0xcfae, 0x66d8, 0x2ad8, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x3c);
    poke(0x2ad8, 0x8d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7800, 0xcfae, 0x66d8, 0x15d8, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb3d
  test('cb3d', () {
    // Set up machine initial state
    loadRegisters(0xe600, 0xdcda, 0x06aa, 0x46cd, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x3d);
    poke(0x46cd, 0xf9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe625, 0xdcda, 0x06aa, 0x4666, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb3e
  test('cb3e', () {
    // Set up machine initial state
    loadRegisters(0xa900, 0x6a34, 0xe8d0, 0xa96c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x3e);
    poke(0xa96c, 0xa0);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa904, 0x6a34, 0xe8d0, 0xa96c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
    expect(peek(43372), equals(0x50));
  });


  // Test instruction cb3f
  test('cb3f', () {
    // Set up machine initial state
    loadRegisters(0xf100, 0xceea, 0x721e, 0x77f0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x3f);
    poke(0x77f0, 0x7c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x782d, 0xceea, 0x721e, 0x77f0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb40
  test('cb40', () {
    // Set up machine initial state
    loadRegisters(0x9e00, 0xbcb2, 0xefaa, 0x505f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x40);
    poke(0x505f, 0x59);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9e7c, 0xbcb2, 0xefaa, 0x505f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb41
  test('cb41', () {
    // Set up machine initial state
    loadRegisters(0x9e00, 0x1b43, 0x954e, 0x7be9, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x41);
    poke(0x7be9, 0xf7);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9e10, 0x1b43, 0x954e, 0x7be9, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb42
  test('cb42', () {
    // Set up machine initial state
    loadRegisters(0xf200, 0xdd12, 0x7d4f, 0x551f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x42);
    poke(0x551f, 0xc9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf238, 0xdd12, 0x7d4f, 0x551f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb43
  test('cb43', () {
    // Set up machine initial state
    loadRegisters(0xad00, 0xc3b3, 0xf1d0, 0xbab4, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x43);
    poke(0xbab4, 0x76);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xad54, 0xc3b3, 0xf1d0, 0xbab4, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb44
  test('cb44', () {
    // Set up machine initial state
    loadRegisters(0xb700, 0xc829, 0x27e3, 0x5b92, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x44);
    poke(0x5b92, 0x78);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb718, 0xc829, 0x27e3, 0x5b92, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb45
  test('cb45', () {
    // Set up machine initial state
    loadRegisters(0x7700, 0x68ee, 0x0c77, 0x409b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x45);
    poke(0x409b, 0x64);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7718, 0x68ee, 0x0c77, 0x409b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb46
  test('cb46', () {
    // Set up machine initial state
    loadRegisters(0x7200, 0x7ae3, 0xa11e, 0x6131, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x46);
    poke(0x6131, 0xd5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7210, 0x7ae3, 0xa11e, 0x6131, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 12);
  });


  // Test instruction cb46_1
  test('cb46_1', () {
    // Set up machine initial state
    loadRegisters(0x7200, 0x7ae3, 0xa11e, 0x6131, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x46);
    poke(0x6131, 0xd5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7210, 0x7ae3, 0xa11e, 0x6131, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 12);
  });


  // Test instruction cb46_2
  test('cb46_2', () {
    // Set up machine initial state
    loadRegisters(0x7200, 0x7ae3, 0xa11e, 0x6131, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x46);
    poke(0x6131, 0xd5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7238, 0x7ae3, 0xa11e, 0x6131, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 12);
  });


  // Test instruction cb46_3
  test('cb46_3', () {
    // Set up machine initial state
    loadRegisters(0x7200, 0x7ae3, 0xa11e, 0x6131, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x46);
    poke(0x6131, 0xd5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7238, 0x7ae3, 0xa11e, 0x6131, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 12);
  });


  // Test instruction cb46_4
  test('cb46_4', () {
    // Set up machine initial state
    loadRegisters(0x7200, 0x7ae3, 0xa11e, 0x6131, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x46);
    poke(0x6131, 0xd5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7218, 0x7ae3, 0xa11e, 0x6131, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 12);
  });


  // Test instruction cb46_5
  test('cb46_5', () {
    // Set up machine initial state
    loadRegisters(0x7200, 0x7ae3, 0xa11e, 0x6131, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x46);
    poke(0x6131, 0xd5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7230, 0x7ae3, 0xa11e, 0x6131, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 12);
  });


  // Test instruction cb47_1
  test('cb47_1', () {
    // Set up machine initial state
    loadRegisters(0xff00, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x47);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xff38, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb47
  test('cb47', () {
    // Set up machine initial state
    loadRegisters(0x1000, 0xd8ca, 0xe2c4, 0x8a8c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x47);
    poke(0x8a8c, 0x0e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1054, 0xd8ca, 0xe2c4, 0x8a8c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb48
  test('cb48', () {
    // Set up machine initial state
    loadRegisters(0xa900, 0x6264, 0xe833, 0x6de0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x48);
    poke(0x6de0, 0x8c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa930, 0x6264, 0xe833, 0x6de0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb49
  test('cb49', () {
    // Set up machine initial state
    loadRegisters(0x6c00, 0xd0f7, 0x1db7, 0xa040, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x49);
    poke(0xa040, 0x5f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6c30, 0xd0f7, 0x1db7, 0xa040, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb4a
  test('cb4a', () {
    // Set up machine initial state
    loadRegisters(0x4f00, 0xf04c, 0x5b29, 0x77a4, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x4a);
    poke(0x77a4, 0x96);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4f18, 0xf04c, 0x5b29, 0x77a4, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb4b
  test('cb4b', () {
    // Set up machine initial state
    loadRegisters(0x5500, 0x9848, 0x095f, 0x40ca, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x4b);
    poke(0x40ca, 0x8a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5518, 0x9848, 0x095f, 0x40ca, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb4c
  test('cb4c', () {
    // Set up machine initial state
    loadRegisters(0x8800, 0x0521, 0xbf31, 0x6d5d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x4c);
    poke(0x6d5d, 0xe7);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x887c, 0x0521, 0xbf31, 0x6d5d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb4d
  test('cb4d', () {
    // Set up machine initial state
    loadRegisters(0xf900, 0x27d0, 0x0f7e, 0x158d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x4d);
    poke(0x158d, 0xe0);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf95c, 0x27d0, 0x0f7e, 0x158d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb4e
  test('cb4e', () {
    // Set up machine initial state
    loadRegisters(0x2600, 0x9207, 0x459a, 0xada3, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x4e);
    poke(0xada3, 0x5b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2610, 0x9207, 0x459a, 0xada3, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 12);
  });


  // Test instruction cb4f_1
  test('cb4f_1', () {
    // Set up machine initial state
    loadRegisters(0xff00, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x4f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xff38, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb4f
  test('cb4f', () {
    // Set up machine initial state
    loadRegisters(0x1700, 0x2dc1, 0xaca2, 0x0bcc, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x4f);
    poke(0x0bcc, 0xa3);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1710, 0x2dc1, 0xaca2, 0x0bcc, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb50
  test('cb50', () {
    // Set up machine initial state
    loadRegisters(0x2300, 0x2749, 0x1012, 0x84d2, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x50);
    poke(0x84d2, 0x6a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2330, 0x2749, 0x1012, 0x84d2, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb51
  test('cb51', () {
    // Set up machine initial state
    loadRegisters(0x2200, 0xb7db, 0xe19d, 0xaafc, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x51);
    poke(0xaafc, 0xa6);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x225c, 0xb7db, 0xe19d, 0xaafc, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb52
  test('cb52', () {
    // Set up machine initial state
    loadRegisters(0x8b00, 0xff7a, 0xb0ff, 0xac44, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x52);
    poke(0xac44, 0x00);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8b74, 0xff7a, 0xb0ff, 0xac44, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb53
  test('cb53', () {
    // Set up machine initial state
    loadRegisters(0x6000, 0x31a1, 0xa4f4, 0x7c75, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x53);
    poke(0x7c75, 0xab);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6030, 0x31a1, 0xa4f4, 0x7c75, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb54
  test('cb54', () {
    // Set up machine initial state
    loadRegisters(0x3800, 0x7ccc, 0x89cc, 0x1999, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x54);
    poke(0x1999, 0x98);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x385c, 0x7ccc, 0x89cc, 0x1999, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb55
  test('cb55', () {
    // Set up machine initial state
    loadRegisters(0xf900, 0x1f79, 0x19cd, 0xfb4b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x55);
    poke(0xfb4b, 0x0b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf95c, 0x1f79, 0x19cd, 0xfb4b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb56
  test('cb56', () {
    // Set up machine initial state
    loadRegisters(0x1500, 0x2bfe, 0xe3b5, 0xbbf9, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x56);
    poke(0xbbf9, 0x10);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1554, 0x2bfe, 0xe3b5, 0xbbf9, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 12);
  });


  // Test instruction cb57_1
  test('cb57_1', () {
    // Set up machine initial state
    loadRegisters(0xff00, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x57);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xff38, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb57
  test('cb57', () {
    // Set up machine initial state
    loadRegisters(0x6600, 0xaf32, 0x532a, 0xda50, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x57);
    poke(0xda50, 0x30);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6630, 0xaf32, 0x532a, 0xda50, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb58
  test('cb58', () {
    // Set up machine initial state
    loadRegisters(0x5000, 0x1aee, 0x2e47, 0x1479, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x58);
    poke(0x1479, 0xa0);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5018, 0x1aee, 0x2e47, 0x1479, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb59
  test('cb59', () {
    // Set up machine initial state
    loadRegisters(0x7200, 0x5e68, 0xff28, 0x2075, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x59);
    poke(0x2075, 0xc1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7238, 0x5e68, 0xff28, 0x2075, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb5a
  test('cb5a', () {
    // Set up machine initial state
    loadRegisters(0xeb00, 0xfea7, 0x17d1, 0xd99b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x5a);
    poke(0xd99b, 0xe8);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xeb54, 0xfea7, 0x17d1, 0xd99b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb5b
  test('cb5b', () {
    // Set up machine initial state
    loadRegisters(0x6b00, 0x6f2c, 0x3fe3, 0x1691, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x5b);
    poke(0x1691, 0xc7);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6b74, 0x6f2c, 0x3fe3, 0x1691, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb5c
  test('cb5c', () {
    // Set up machine initial state
    loadRegisters(0x3300, 0xa7e7, 0x2077, 0x13e9, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x5c);
    poke(0x13e9, 0xae);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3354, 0xa7e7, 0x2077, 0x13e9, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb5d
  test('cb5d', () {
    // Set up machine initial state
    loadRegisters(0xc100, 0xafcc, 0xc8b1, 0xee49, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x5d);
    poke(0xee49, 0xa6);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc118, 0xafcc, 0xc8b1, 0xee49, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb5e
  test('cb5e', () {
    // Set up machine initial state
    loadRegisters(0x3000, 0xad43, 0x16c1, 0x349a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x5e);
    poke(0x349a, 0x3c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3010, 0xad43, 0x16c1, 0x349a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 12);
  });


  // Test instruction cb5f_1
  test('cb5f_1', () {
    // Set up machine initial state
    loadRegisters(0xff00, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x5f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xff38, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb5f
  test('cb5f', () {
    // Set up machine initial state
    loadRegisters(0x8c00, 0x1b67, 0x2314, 0x6133, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x5f);
    poke(0x6133, 0x90);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8c18, 0x1b67, 0x2314, 0x6133, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb60
  test('cb60', () {
    // Set up machine initial state
    loadRegisters(0x9900, 0x34b5, 0x0fd8, 0x5273, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x60);
    poke(0x5273, 0x0a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9930, 0x34b5, 0x0fd8, 0x5273, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb61
  test('cb61', () {
    // Set up machine initial state
    loadRegisters(0xd100, 0x219f, 0x3bb4, 0x7c44, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x61);
    poke(0x7c44, 0x77);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd118, 0x219f, 0x3bb4, 0x7c44, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb62
  test('cb62', () {
    // Set up machine initial state
    loadRegisters(0xaf00, 0xbdf8, 0xc536, 0x8cc5, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x62);
    poke(0x8cc5, 0xaf);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xaf54, 0xbdf8, 0xc536, 0x8cc5, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb63
  test('cb63', () {
    // Set up machine initial state
    loadRegisters(0x2a00, 0x5e16, 0xf627, 0x84ca, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x63);
    poke(0x84ca, 0xe6);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2a74, 0x5e16, 0xf627, 0x84ca, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb64
  test('cb64', () {
    // Set up machine initial state
    loadRegisters(0xa900, 0xa365, 0xc00b, 0xea94, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x64);
    poke(0xea94, 0x0c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa97c, 0xa365, 0xc00b, 0xea94, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb65
  test('cb65', () {
    // Set up machine initial state
    loadRegisters(0x1800, 0x8d58, 0x4256, 0x427a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x65);
    poke(0x427a, 0xee);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1838, 0x8d58, 0x4256, 0x427a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb66
  test('cb66', () {
    // Set up machine initial state
    loadRegisters(0x4c00, 0x3ef7, 0xe544, 0xa44f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x66);
    poke(0xa44f, 0xd2);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4c10, 0x3ef7, 0xe544, 0xa44f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 12);
  });


  // Test instruction cb67_1
  test('cb67_1', () {
    // Set up machine initial state
    loadRegisters(0xff00, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x67);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xff38, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb67
  test('cb67', () {
    // Set up machine initial state
    loadRegisters(0x8600, 0x5e92, 0x2986, 0x394d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x67);
    poke(0x394d, 0x10);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8654, 0x5e92, 0x2986, 0x394d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb68
  test('cb68', () {
    // Set up machine initial state
    loadRegisters(0xd700, 0x0f6a, 0x18a6, 0xddd2, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x68);
    poke(0xddd2, 0x16);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd75c, 0x0f6a, 0x18a6, 0xddd2, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb69
  test('cb69', () {
    // Set up machine initial state
    loadRegisters(0xda00, 0x691b, 0x7c79, 0x1dba, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x69);
    poke(0x1dba, 0x8a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xda5c, 0x691b, 0x7c79, 0x1dba, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb6a
  test('cb6a', () {
    // Set up machine initial state
    loadRegisters(0x2200, 0x13e8, 0x86d4, 0x4e09, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x6a);
    poke(0x4e09, 0xd5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2254, 0x13e8, 0x86d4, 0x4e09, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb6b
  test('cb6b', () {
    // Set up machine initial state
    loadRegisters(0xaf00, 0x5123, 0x7635, 0x1ca9, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x6b);
    poke(0x1ca9, 0x86);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xaf30, 0x5123, 0x7635, 0x1ca9, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb6c
  test('cb6c', () {
    // Set up machine initial state
    loadRegisters(0x4300, 0xfaa6, 0xabc2, 0x5605, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x6c);
    poke(0x5605, 0x2b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4354, 0xfaa6, 0xabc2, 0x5605, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb6d
  test('cb6d', () {
    // Set up machine initial state
    loadRegisters(0x7f00, 0xf099, 0xd435, 0xd9ad, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x6d);
    poke(0xd9ad, 0x4e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7f38, 0xf099, 0xd435, 0xd9ad, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb6e
  test('cb6e', () {
    // Set up machine initial state
    loadRegisters(0x4a00, 0x08c9, 0x8177, 0xd8ba, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x6e);
    poke(0xd8ba, 0x31);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4a10, 0x08c9, 0x8177, 0xd8ba, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 12);
  });


  // Test instruction cb6f_1
  test('cb6f_1', () {
    // Set up machine initial state
    loadRegisters(0xff00, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x6f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xff38, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb6f
  test('cb6f', () {
    // Set up machine initial state
    loadRegisters(0xa100, 0x8c80, 0x4678, 0x4d34, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x6f);
    poke(0x4d34, 0x78);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa130, 0x8c80, 0x4678, 0x4d34, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb70
  test('cb70', () {
    // Set up machine initial state
    loadRegisters(0x1900, 0x958a, 0x5dab, 0xf913, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x70);
    poke(0xf913, 0xcf);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1954, 0x958a, 0x5dab, 0xf913, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb71
  test('cb71', () {
    // Set up machine initial state
    loadRegisters(0x3d00, 0x095e, 0xd6df, 0x42fe, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x71);
    poke(0x42fe, 0x24);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3d18, 0x095e, 0xd6df, 0x42fe, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb72
  test('cb72', () {
    // Set up machine initial state
    loadRegisters(0xa500, 0xc0bf, 0x4c8d, 0xad11, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x72);
    poke(0xad11, 0x3b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa518, 0xc0bf, 0x4c8d, 0xad11, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb73
  test('cb73', () {
    // Set up machine initial state
    loadRegisters(0xf200, 0x49a6, 0xb279, 0x2ecc, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x73);
    poke(0x2ecc, 0xe0);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf238, 0x49a6, 0xb279, 0x2ecc, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb74
  test('cb74', () {
    // Set up machine initial state
    loadRegisters(0x0500, 0x445e, 0x05e9, 0x983d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x74);
    poke(0x983d, 0xfa);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x055c, 0x445e, 0x05e9, 0x983d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb75
  test('cb75', () {
    // Set up machine initial state
    loadRegisters(0x6b00, 0x83c6, 0x635a, 0xd18d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x75);
    poke(0xd18d, 0x11);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6b5c, 0x83c6, 0x635a, 0xd18d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb76
  test('cb76', () {
    // Set up machine initial state
    loadRegisters(0xf800, 0x3057, 0x3629, 0xbc71, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x76);
    poke(0xbc71, 0x18);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf854, 0x3057, 0x3629, 0xbc71, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 12);
  });


  // Test instruction cb77_1
  test('cb77_1', () {
    // Set up machine initial state
    loadRegisters(0xff00, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x77);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xff38, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb77
  test('cb77', () {
    // Set up machine initial state
    loadRegisters(0x9200, 0xd6f8, 0x5100, 0x736d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x77);
    poke(0x736d, 0x36);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9254, 0xd6f8, 0x5100, 0x736d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb78
  test('cb78', () {
    // Set up machine initial state
    loadRegisters(0x7200, 0x1cf8, 0x8d2b, 0xc76a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x78);
    poke(0xc76a, 0x1f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x725c, 0x1cf8, 0x8d2b, 0xc76a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb79
  test('cb79', () {
    // Set up machine initial state
    loadRegisters(0xa800, 0x809e, 0x1124, 0x39e8, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x79);
    poke(0x39e8, 0x98);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa898, 0x809e, 0x1124, 0x39e8, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb7a
  test('cb7a', () {
    // Set up machine initial state
    loadRegisters(0x5800, 0x7d24, 0x63e1, 0xd9af, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x7a);
    poke(0xd9af, 0xed);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5874, 0x7d24, 0x63e1, 0xd9af, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb7b
  test('cb7b', () {
    // Set up machine initial state
    loadRegisters(0x0300, 0x50ab, 0x05bd, 0x6bd0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x7b);
    poke(0x6bd0, 0xa5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x03b8, 0x50ab, 0x05bd, 0x6bd0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb7c
  test('cb7c', () {
    // Set up machine initial state
    loadRegisters(0xad00, 0xf77b, 0x55ae, 0x063b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x7c);
    poke(0x063b, 0x34);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xad54, 0xf77b, 0x55ae, 0x063b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb7d
  test('cb7d', () {
    // Set up machine initial state
    loadRegisters(0x8200, 0xb792, 0x38cb, 0x5f9b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x7d);
    poke(0x5f9b, 0x97);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8298, 0xb792, 0x38cb, 0x5f9b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb7e
  test('cb7e', () {
    // Set up machine initial state
    loadRegisters(0x4200, 0x3b91, 0xf59c, 0xa25e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x7e);
    poke(0xa25e, 0xd7);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4290, 0x3b91, 0xf59c, 0xa25e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 12);
  });


  // Test instruction cb7f_1
  test('cb7f_1', () {
    // Set up machine initial state
    loadRegisters(0xff00, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x7f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xffb8, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb7f
  test('cb7f', () {
    // Set up machine initial state
    loadRegisters(0x6a00, 0x84ec, 0xcf4e, 0x185b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x7f);
    poke(0x185b, 0xf1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6a7c, 0x84ec, 0xcf4e, 0x185b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb80
  test('cb80', () {
    // Set up machine initial state
    loadRegisters(0x8f00, 0x702f, 0x17bd, 0xa706, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x80);
    poke(0xa706, 0x0a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8f00, 0x702f, 0x17bd, 0xa706, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb81
  test('cb81', () {
    // Set up machine initial state
    loadRegisters(0xae00, 0x947f, 0x7153, 0x6616, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x81);
    poke(0x6616, 0x74);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xae00, 0x947e, 0x7153, 0x6616, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb82
  test('cb82', () {
    // Set up machine initial state
    loadRegisters(0x8100, 0xbed2, 0xc719, 0x4572, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x82);
    poke(0x4572, 0x2f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8100, 0xbed2, 0xc619, 0x4572, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb83
  test('cb83', () {
    // Set up machine initial state
    loadRegisters(0xe600, 0x63a2, 0xccf7, 0xae9a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x83);
    poke(0xae9a, 0x16);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe600, 0x63a2, 0xccf6, 0xae9a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb84
  test('cb84', () {
    // Set up machine initial state
    loadRegisters(0xce00, 0xe0cc, 0xd305, 0xd6c0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x84);
    poke(0xd6c0, 0x72);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xce00, 0xe0cc, 0xd305, 0xd6c0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb85
  test('cb85', () {
    // Set up machine initial state
    loadRegisters(0xf300, 0xed79, 0x9db7, 0xdda0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x85);
    poke(0xdda0, 0x8a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf300, 0xed79, 0x9db7, 0xdda0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb86
  test('cb86', () {
    // Set up machine initial state
    loadRegisters(0x2a00, 0xb0b9, 0x9426, 0x1b48, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x86);
    poke(0x1b48, 0x62);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2a00, 0xb0b9, 0x9426, 0x1b48, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
  });


  // Test instruction cb87
  test('cb87', () {
    // Set up machine initial state
    loadRegisters(0x1100, 0x86dc, 0x1798, 0xdfc5, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x87);
    poke(0xdfc5, 0xde);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1000, 0x86dc, 0x1798, 0xdfc5, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb88
  test('cb88', () {
    // Set up machine initial state
    loadRegisters(0xe300, 0x8a21, 0xe33e, 0x674d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x88);
    poke(0x674d, 0x5f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe300, 0x8821, 0xe33e, 0x674d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb89
  test('cb89', () {
    // Set up machine initial state
    loadRegisters(0x6000, 0xd186, 0xc5b6, 0x1bd7, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x89);
    poke(0x1bd7, 0xf2);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6000, 0xd184, 0xc5b6, 0x1bd7, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb8a
  test('cb8a', () {
    // Set up machine initial state
    loadRegisters(0x3e00, 0x5fcd, 0x0b38, 0xb98e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x8a);
    poke(0xb98e, 0x2f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3e00, 0x5fcd, 0x0938, 0xb98e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb8b
  test('cb8b', () {
    // Set up machine initial state
    loadRegisters(0x6500, 0x040e, 0x103f, 0x4a07, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x8b);
    poke(0x4a07, 0x3f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6500, 0x040e, 0x103d, 0x4a07, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb8c
  test('cb8c', () {
    // Set up machine initial state
    loadRegisters(0xf800, 0x6d27, 0x9bdf, 0xdaef, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x8c);
    poke(0xdaef, 0x0c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf800, 0x6d27, 0x9bdf, 0xd8ef, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb8d
  test('cb8d', () {
    // Set up machine initial state
    loadRegisters(0x3e00, 0x5469, 0x2c28, 0xbd72, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x8d);
    poke(0xbd72, 0x13);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3e00, 0x5469, 0x2c28, 0xbd70, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb8e
  test('cb8e', () {
    // Set up machine initial state
    loadRegisters(0x1f00, 0x140b, 0xb492, 0x63a7, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x8e);
    poke(0x63a7, 0xd4);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1f00, 0x140b, 0xb492, 0x63a7, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
  });


  // Test instruction cb8f
  test('cb8f', () {
    // Set up machine initial state
    loadRegisters(0x2500, 0xc522, 0xca46, 0x1c1a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x8f);
    poke(0x1c1a, 0x37);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2500, 0xc522, 0xca46, 0x1c1a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb90
  test('cb90', () {
    // Set up machine initial state
    loadRegisters(0x5700, 0x595c, 0x4f0a, 0xc73c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x90);
    poke(0xc73c, 0xa2);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5700, 0x595c, 0x4f0a, 0xc73c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb91
  test('cb91', () {
    // Set up machine initial state
    loadRegisters(0x5e00, 0x8f26, 0xa735, 0x97e0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x91);
    poke(0x97e0, 0x5e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5e00, 0x8f22, 0xa735, 0x97e0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb92
  test('cb92', () {
    // Set up machine initial state
    loadRegisters(0x3300, 0x7d9f, 0x87d0, 0x83d0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x92);
    poke(0x83d0, 0x2b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3300, 0x7d9f, 0x83d0, 0x83d0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb93
  test('cb93', () {
    // Set up machine initial state
    loadRegisters(0xc200, 0x4e05, 0xb3f8, 0x2234, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x93);
    poke(0x2234, 0xa0);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc200, 0x4e05, 0xb3f8, 0x2234, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb94
  test('cb94', () {
    // Set up machine initial state
    loadRegisters(0xee00, 0x8f4b, 0x2831, 0xd6a6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x94);
    poke(0xd6a6, 0xd0);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xee00, 0x8f4b, 0x2831, 0xd2a6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb95
  test('cb95', () {
    // Set up machine initial state
    loadRegisters(0x3c00, 0x6af2, 0xb25d, 0x36ff, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x95);
    poke(0x36ff, 0xcd);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3c00, 0x6af2, 0xb25d, 0x36fb, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb96
  test('cb96', () {
    // Set up machine initial state
    loadRegisters(0x7600, 0xb027, 0xd0a5, 0x3324, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x96);
    poke(0x3324, 0x21);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7600, 0xb027, 0xd0a5, 0x3324, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
  });


  // Test instruction cb97
  test('cb97', () {
    // Set up machine initial state
    loadRegisters(0x1600, 0xad09, 0x7902, 0x97bc, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x97);
    poke(0x97bc, 0x75);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1200, 0xad09, 0x7902, 0x97bc, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb98
  test('cb98', () {
    // Set up machine initial state
    loadRegisters(0x3400, 0xb61c, 0x771d, 0x5d5e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x98);
    poke(0x5d5e, 0xa4);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3400, 0xb61c, 0x771d, 0x5d5e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb99
  test('cb99', () {
    // Set up machine initial state
    loadRegisters(0x5100, 0x65be, 0x1359, 0x8bec, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x99);
    poke(0x8bec, 0x0b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5100, 0x65b6, 0x1359, 0x8bec, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb9a
  test('cb9a', () {
    // Set up machine initial state
    loadRegisters(0x6400, 0x976d, 0x4c25, 0xdcb2, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x9a);
    poke(0xdcb2, 0x09);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6400, 0x976d, 0x4425, 0xdcb2, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb9b
  test('cb9b', () {
    // Set up machine initial state
    loadRegisters(0xa100, 0xb58a, 0xd264, 0x2bd6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x9b);
    poke(0x2bd6, 0xd3);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa100, 0xb58a, 0xd264, 0x2bd6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb9c
  test('cb9c', () {
    // Set up machine initial state
    loadRegisters(0xd800, 0x63d6, 0xac7b, 0xc7a0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x9c);
    poke(0xc7a0, 0x75);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd800, 0x63d6, 0xac7b, 0xc7a0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb9d
  test('cb9d', () {
    // Set up machine initial state
    loadRegisters(0x0d00, 0xd840, 0x0810, 0x0800, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x9d);
    poke(0x0800, 0xcd);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0d00, 0xd840, 0x0810, 0x0800, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cb9e
  test('cb9e', () {
    // Set up machine initial state
    loadRegisters(0x3b00, 0xebbf, 0x9434, 0x3a65, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x9e);
    poke(0x3a65, 0x2a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3b00, 0xebbf, 0x9434, 0x3a65, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
    expect(peek(14949), equals(0x22));
  });


  // Test instruction cb9f
  test('cb9f', () {
    // Set up machine initial state
    loadRegisters(0xb200, 0xd1de, 0xf991, 0x72f6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0x9f);
    poke(0x72f6, 0x72);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb200, 0xd1de, 0xf991, 0x72f6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cba0
  test('cba0', () {
    // Set up machine initial state
    loadRegisters(0xfa00, 0xd669, 0x71e1, 0xc80d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xa0);
    poke(0xc80d, 0xc0);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xfa00, 0xc669, 0x71e1, 0xc80d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cba1
  test('cba1', () {
    // Set up machine initial state
    loadRegisters(0x8200, 0x75e4, 0xa0de, 0xd0ba, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xa1);
    poke(0xd0ba, 0xbd);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8200, 0x75e4, 0xa0de, 0xd0ba, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cba2
  test('cba2', () {
    // Set up machine initial state
    loadRegisters(0xdd00, 0x2b0d, 0x5554, 0x6fc0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xa2);
    poke(0x6fc0, 0x61);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xdd00, 0x2b0d, 0x4554, 0x6fc0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cba3
  test('cba3', () {
    // Set up machine initial state
    loadRegisters(0x2200, 0x2f0d, 0x4d2c, 0x6666, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xa3);
    poke(0x6666, 0x8e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2200, 0x2f0d, 0x4d2c, 0x6666, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cba4
  test('cba4', () {
    // Set up machine initial state
    loadRegisters(0xd600, 0xd8ed, 0x9cd4, 0x8bb1, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xa4);
    poke(0x8bb1, 0xbb);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd600, 0xd8ed, 0x9cd4, 0x8bb1, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cba5
  test('cba5', () {
    // Set up machine initial state
    loadRegisters(0xb400, 0xb393, 0x3e42, 0x88ca, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xa5);
    poke(0x88ca, 0x4f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb400, 0xb393, 0x3e42, 0x88ca, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cba6
  test('cba6', () {
    // Set up machine initial state
    loadRegisters(0x0a00, 0x4c34, 0xf5a7, 0xe70d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xa6);
    poke(0xe70d, 0x27);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0a00, 0x4c34, 0xf5a7, 0xe70d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
  });


  // Test instruction cba7
  test('cba7', () {
    // Set up machine initial state
    loadRegisters(0x4500, 0xaf61, 0x569a, 0xc77b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xa7);
    poke(0xc77b, 0xff);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4500, 0xaf61, 0x569a, 0xc77b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cba8
  test('cba8', () {
    // Set up machine initial state
    loadRegisters(0x6400, 0xf269, 0xbae4, 0xc9e7, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xa8);
    poke(0xc9e7, 0x46);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6400, 0xd269, 0xbae4, 0xc9e7, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cba9
  test('cba9', () {
    // Set up machine initial state
    loadRegisters(0xe400, 0x7ad4, 0xbf0a, 0xce0b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xa9);
    poke(0xce0b, 0x39);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe400, 0x7ad4, 0xbf0a, 0xce0b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbaa
  test('cbaa', () {
    // Set up machine initial state
    loadRegisters(0xcd00, 0xd249, 0x4159, 0xfed5, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xaa);
    poke(0xfed5, 0xb0);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xcd00, 0xd249, 0x4159, 0xfed5, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbab
  test('cbab', () {
    // Set up machine initial state
    loadRegisters(0xac00, 0x939a, 0x5d9b, 0x0812, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xab);
    poke(0x0812, 0xf2);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xac00, 0x939a, 0x5d9b, 0x0812, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbac
  test('cbac', () {
    // Set up machine initial state
    loadRegisters(0x2400, 0x8a7d, 0x2cac, 0xffaa, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xac);
    poke(0xffaa, 0x09);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2400, 0x8a7d, 0x2cac, 0xdfaa, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbad
  test('cbad', () {
    // Set up machine initial state
    loadRegisters(0x6f00, 0x5ffb, 0x2360, 0xae15, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xad);
    poke(0xae15, 0x30);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6f00, 0x5ffb, 0x2360, 0xae15, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbae
  test('cbae', () {
    // Set up machine initial state
    loadRegisters(0x5a00, 0xaa17, 0x12f3, 0x190e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xae);
    poke(0x190e, 0x66);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5a00, 0xaa17, 0x12f3, 0x190e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
    expect(peek(6414), equals(0x46));
  });


  // Test instruction cbaf
  test('cbaf', () {
    // Set up machine initial state
    loadRegisters(0xfc00, 0xbb3f, 0x8bb6, 0x5877, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xaf);
    poke(0x5877, 0x62);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xdc00, 0xbb3f, 0x8bb6, 0x5877, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbb0
  test('cbb0', () {
    // Set up machine initial state
    loadRegisters(0xb900, 0x7a79, 0x1aaa, 0xc3ba, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xb0);
    poke(0xc3ba, 0x4c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb900, 0x3a79, 0x1aaa, 0xc3ba, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbb1
  test('cbb1', () {
    // Set up machine initial state
    loadRegisters(0x4900, 0x63e4, 0xa544, 0x1190, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xb1);
    poke(0x1190, 0xe3);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4900, 0x63a4, 0xa544, 0x1190, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbb2
  test('cbb2', () {
    // Set up machine initial state
    loadRegisters(0x4d00, 0x2b03, 0x6b23, 0x6ff5, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xb2);
    poke(0x6ff5, 0x04);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4d00, 0x2b03, 0x2b23, 0x6ff5, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbb3
  test('cbb3', () {
    // Set up machine initial state
    loadRegisters(0x8700, 0x857a, 0xe98b, 0x5cb1, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xb3);
    poke(0x5cb1, 0x43);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8700, 0x857a, 0xe98b, 0x5cb1, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbb4
  test('cbb4', () {
    // Set up machine initial state
    loadRegisters(0x2b00, 0xb73e, 0x79c9, 0xe1bb, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xb4);
    poke(0xe1bb, 0x78);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2b00, 0xb73e, 0x79c9, 0xa1bb, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbb5
  test('cbb5', () {
    // Set up machine initial state
    loadRegisters(0x9b00, 0xd879, 0x2ec9, 0x4bba, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xb5);
    poke(0x4bba, 0x70);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9b00, 0xd879, 0x2ec9, 0x4bba, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbb6
  test('cbb6', () {
    // Set up machine initial state
    loadRegisters(0x8600, 0x89bf, 0xde4a, 0x4fab, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xb6);
    poke(0x4fab, 0xa5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8600, 0x89bf, 0xde4a, 0x4fab, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
  });


  // Test instruction cbb7
  test('cbb7', () {
    // Set up machine initial state
    loadRegisters(0x2200, 0xfb8a, 0x3d6e, 0xd4a2, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xb7);
    poke(0xd4a2, 0xf2);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2200, 0xfb8a, 0x3d6e, 0xd4a2, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbb8
  test('cbb8', () {
    // Set up machine initial state
    loadRegisters(0xd000, 0x37c6, 0x225a, 0xd249, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xb8);
    poke(0xd249, 0xc4);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd000, 0x37c6, 0x225a, 0xd249, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbb9
  test('cbb9', () {
    // Set up machine initial state
    loadRegisters(0xa500, 0x1b4a, 0xd584, 0x5dee, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xb9);
    poke(0x5dee, 0xcc);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa500, 0x1b4a, 0xd584, 0x5dee, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbba
  test('cbba', () {
    // Set up machine initial state
    loadRegisters(0x6300, 0xa5fe, 0xf42b, 0x34c9, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xba);
    poke(0x34c9, 0xbc);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6300, 0xa5fe, 0x742b, 0x34c9, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbbb
  test('cbbb', () {
    // Set up machine initial state
    loadRegisters(0x1200, 0xf661, 0xaa4f, 0xcb30, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xbb);
    poke(0xcb30, 0xf4);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1200, 0xf661, 0xaa4f, 0xcb30, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbbc
  test('cbbc', () {
    // Set up machine initial state
    loadRegisters(0x9800, 0xadc3, 0x0b29, 0x7b6e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xbc);
    poke(0x7b6e, 0x45);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9800, 0xadc3, 0x0b29, 0x7b6e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbbd
  test('cbbd', () {
    // Set up machine initial state
    loadRegisters(0xd600, 0xa6e1, 0x8813, 0x10b8, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xbd);
    poke(0x10b8, 0x35);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd600, 0xa6e1, 0x8813, 0x1038, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbbe
  test('cbbe', () {
    // Set up machine initial state
    loadRegisters(0xca00, 0xff64, 0x1218, 0x77d5, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xbe);
    poke(0x77d5, 0xea);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xca00, 0xff64, 0x1218, 0x77d5, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
    expect(peek(30677), equals(0x6a));
  });


  // Test instruction cbbf
  test('cbbf', () {
    // Set up machine initial state
    loadRegisters(0x6800, 0x4845, 0x690a, 0x15de, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xbf);
    poke(0x15de, 0x1d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6800, 0x4845, 0x690a, 0x15de, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbc0
  test('cbc0', () {
    // Set up machine initial state
    loadRegisters(0xe300, 0xef71, 0xbffb, 0xb3a1, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xc0);
    poke(0xb3a1, 0x5c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe300, 0xef71, 0xbffb, 0xb3a1, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbc1
  test('cbc1', () {
    // Set up machine initial state
    loadRegisters(0x3200, 0x32a1, 0x59ab, 0x3343, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xc1);
    poke(0x3343, 0xaa);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3200, 0x32a1, 0x59ab, 0x3343, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbc2
  test('cbc2', () {
    // Set up machine initial state
    loadRegisters(0xc700, 0xb159, 0xc023, 0xe1f3, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xc2);
    poke(0xe1f3, 0x14);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc700, 0xb159, 0xc123, 0xe1f3, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbc3
  test('cbc3', () {
    // Set up machine initial state
    loadRegisters(0x0400, 0xb463, 0xc211, 0x8f3a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xc3);
    poke(0x8f3a, 0x81);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0400, 0xb463, 0xc211, 0x8f3a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbc4
  test('cbc4', () {
    // Set up machine initial state
    loadRegisters(0x7e00, 0x545a, 0x6ecf, 0x5876, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xc4);
    poke(0x5876, 0x9d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7e00, 0x545a, 0x6ecf, 0x5976, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbc5
  test('cbc5', () {
    // Set up machine initial state
    loadRegisters(0x4000, 0xc617, 0x079c, 0x4107, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xc5);
    poke(0x4107, 0xcc);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4000, 0xc617, 0x079c, 0x4107, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbc6
  test('cbc6', () {
    // Set up machine initial state
    loadRegisters(0xb800, 0x0373, 0xb807, 0xf0be, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xc6);
    poke(0xf0be, 0x9c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb800, 0x0373, 0xb807, 0xf0be, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
    expect(peek(61630), equals(0x9d));
  });


  // Test instruction cbc7
  test('cbc7', () {
    // Set up machine initial state
    loadRegisters(0x7700, 0x3681, 0x9b55, 0x583f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xc7);
    poke(0x583f, 0x58);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7700, 0x3681, 0x9b55, 0x583f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbc8
  test('cbc8', () {
    // Set up machine initial state
    loadRegisters(0x7d00, 0xa772, 0x8682, 0x7cf3, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xc8);
    poke(0x7cf3, 0x75);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7d00, 0xa772, 0x8682, 0x7cf3, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbc9
  test('cbc9', () {
    // Set up machine initial state
    loadRegisters(0x0b00, 0x67ee, 0x30e0, 0x72db, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xc9);
    poke(0x72db, 0x87);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0b00, 0x67ee, 0x30e0, 0x72db, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbca
  test('cbca', () {
    // Set up machine initial state
    loadRegisters(0x9c00, 0x9517, 0xcfbb, 0xfbc7, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xca);
    poke(0xfbc7, 0x1a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9c00, 0x9517, 0xcfbb, 0xfbc7, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbcb
  test('cbcb', () {
    // Set up machine initial state
    loadRegisters(0xe800, 0x0f3d, 0x336f, 0xf70d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xcb);
    poke(0xf70d, 0xa1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe800, 0x0f3d, 0x336f, 0xf70d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbcc
  test('cbcc', () {
    // Set up machine initial state
    loadRegisters(0xfb00, 0x7981, 0x0bbb, 0x18fd, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xcc);
    poke(0x18fd, 0xfe);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xfb00, 0x7981, 0x0bbb, 0x1afd, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbcd
  test('cbcd', () {
    // Set up machine initial state
    loadRegisters(0x5500, 0x5e78, 0xbf34, 0x2602, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xcd);
    poke(0x2602, 0x2d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5500, 0x5e78, 0xbf34, 0x2602, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbce
  test('cbce', () {
    // Set up machine initial state
    loadRegisters(0xd500, 0xa111, 0xcb2a, 0x8ec6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xce);
    poke(0x8ec6, 0xbf);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd500, 0xa111, 0xcb2a, 0x8ec6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
  });


  // Test instruction cbcf
  test('cbcf', () {
    // Set up machine initial state
    loadRegisters(0xa200, 0x6baf, 0x98b2, 0x98a0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xcf);
    poke(0x98a0, 0xd4);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa200, 0x6baf, 0x98b2, 0x98a0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbd0
  test('cbd0', () {
    // Set up machine initial state
    loadRegisters(0x2300, 0x7bcb, 0x02e7, 0x1724, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xd0);
    poke(0x1724, 0x30);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2300, 0x7fcb, 0x02e7, 0x1724, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbd1
  test('cbd1', () {
    // Set up machine initial state
    loadRegisters(0x5300, 0x581f, 0xb775, 0x47f4, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xd1);
    poke(0x47f4, 0xc7);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5300, 0x581f, 0xb775, 0x47f4, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbd2
  test('cbd2', () {
    // Set up machine initial state
    loadRegisters(0x6900, 0xc147, 0xb79c, 0x7528, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xd2);
    poke(0x7528, 0x4f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6900, 0xc147, 0xb79c, 0x7528, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbd3
  test('cbd3', () {
    // Set up machine initial state
    loadRegisters(0xae00, 0xbbc4, 0xce52, 0x5fba, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xd3);
    poke(0x5fba, 0x3a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xae00, 0xbbc4, 0xce56, 0x5fba, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbd4
  test('cbd4', () {
    // Set up machine initial state
    loadRegisters(0xd800, 0x6e1e, 0xaf6f, 0xbf2e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xd4);
    poke(0xbf2e, 0x71);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd800, 0x6e1e, 0xaf6f, 0xbf2e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbd5
  test('cbd5', () {
    // Set up machine initial state
    loadRegisters(0x8400, 0xa19a, 0xd2fd, 0x8a77, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xd5);
    poke(0x8a77, 0x52);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8400, 0xa19a, 0xd2fd, 0x8a77, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbd6
  test('cbd6', () {
    // Set up machine initial state
    loadRegisters(0xa900, 0xf5f3, 0x2180, 0x6029, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xd6);
    poke(0x6029, 0xb7);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa900, 0xf5f3, 0x2180, 0x6029, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
  });


  // Test instruction cbd7
  test('cbd7', () {
    // Set up machine initial state
    loadRegisters(0xb100, 0xc008, 0x8425, 0x290a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xd7);
    poke(0x290a, 0x42);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb500, 0xc008, 0x8425, 0x290a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbd8
  test('cbd8', () {
    // Set up machine initial state
    loadRegisters(0x8b00, 0x09c4, 0xddf3, 0x6d7e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xd8);
    poke(0x6d7e, 0x6e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8b00, 0x09c4, 0xddf3, 0x6d7e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbd9
  test('cbd9', () {
    // Set up machine initial state
    loadRegisters(0x3e00, 0x3e36, 0x30ec, 0xefc6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xd9);
    poke(0xefc6, 0x5b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3e00, 0x3e3e, 0x30ec, 0xefc6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbda
  test('cbda', () {
    // Set up machine initial state
    loadRegisters(0xd000, 0x3e8f, 0x28fe, 0x1c87, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xda);
    poke(0x1c87, 0xb9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd000, 0x3e8f, 0x28fe, 0x1c87, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbdb
  test('cbdb', () {
    // Set up machine initial state
    loadRegisters(0x1200, 0x977a, 0x8c49, 0xbc48, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xdb);
    poke(0xbc48, 0xef);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1200, 0x977a, 0x8c49, 0xbc48, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbdc
  test('cbdc', () {
    // Set up machine initial state
    loadRegisters(0x8d00, 0x05de, 0xf8d3, 0xb125, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xdc);
    poke(0xb125, 0x0e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8d00, 0x05de, 0xf8d3, 0xb925, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbdd
  test('cbdd', () {
    // Set up machine initial state
    loadRegisters(0xc300, 0x08a9, 0x2bc8, 0x5b9f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xdd);
    poke(0x5b9f, 0x94);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc300, 0x08a9, 0x2bc8, 0x5b9f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbde
  test('cbde', () {
    // Set up machine initial state
    loadRegisters(0x1900, 0x900f, 0xd572, 0xba03, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xde);
    poke(0xba03, 0x93);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1900, 0x900f, 0xd572, 0xba03, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
    expect(peek(47619), equals(0x9b));
  });


  // Test instruction cbdf
  test('cbdf', () {
    // Set up machine initial state
    loadRegisters(0x6700, 0x2745, 0x7e3d, 0x0fa1, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xdf);
    poke(0x0fa1, 0xc5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6f00, 0x2745, 0x7e3d, 0x0fa1, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbe0
  test('cbe0', () {
    // Set up machine initial state
    loadRegisters(0x3e00, 0xd633, 0x9897, 0x3744, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xe0);
    poke(0x3744, 0x54);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3e00, 0xd633, 0x9897, 0x3744, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbe1
  test('cbe1', () {
    // Set up machine initial state
    loadRegisters(0x7d00, 0x50a6, 0x0136, 0x5334, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xe1);
    poke(0x5334, 0x85);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7d00, 0x50b6, 0x0136, 0x5334, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbe2
  test('cbe2', () {
    // Set up machine initial state
    loadRegisters(0xd400, 0x6b45, 0xa192, 0x3a4c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xe2);
    poke(0x3a4c, 0x47);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd400, 0x6b45, 0xb192, 0x3a4c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbe3
  test('cbe3', () {
    // Set up machine initial state
    loadRegisters(0x3b00, 0xd29c, 0x05e0, 0x2e78, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xe3);
    poke(0x2e78, 0x48);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3b00, 0xd29c, 0x05f0, 0x2e78, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbe4
  test('cbe4', () {
    // Set up machine initial state
    loadRegisters(0x1e00, 0x7d5e, 0x846d, 0x0978, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xe4);
    poke(0x0978, 0x84);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1e00, 0x7d5e, 0x846d, 0x1978, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbe5
  test('cbe5', () {
    // Set up machine initial state
    loadRegisters(0xca00, 0xdf0d, 0xd588, 0xb48f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xe5);
    poke(0xb48f, 0xcf);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xca00, 0xdf0d, 0xd588, 0xb49f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbe6
  test('cbe6', () {
    // Set up machine initial state
    loadRegisters(0xb300, 0x52c2, 0xdbfe, 0x9f9b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xe6);
    poke(0x9f9b, 0xf6);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb300, 0x52c2, 0xdbfe, 0x9f9b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
  });


  // Test instruction cbe7
  test('cbe7', () {
    // Set up machine initial state
    loadRegisters(0x8e00, 0xcf02, 0x67ef, 0xf2e0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xe7);
    poke(0xf2e0, 0xcf);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9e00, 0xcf02, 0x67ef, 0xf2e0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbe8
  test('cbe8', () {
    // Set up machine initial state
    loadRegisters(0x7100, 0xbb18, 0x66ec, 0x4a05, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xe8);
    poke(0x4a05, 0xe6);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7100, 0xbb18, 0x66ec, 0x4a05, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbe9
  test('cbe9', () {
    // Set up machine initial state
    loadRegisters(0x5700, 0x2897, 0x8f2f, 0xa4d0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xe9);
    poke(0xa4d0, 0xb2);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5700, 0x28b7, 0x8f2f, 0xa4d0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbea
  test('cbea', () {
    // Set up machine initial state
    loadRegisters(0xec00, 0x304a, 0x60a1, 0xf32a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xea);
    poke(0xf32a, 0x9c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xec00, 0x304a, 0x60a1, 0xf32a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbeb
  test('cbeb', () {
    // Set up machine initial state
    loadRegisters(0xf000, 0x532b, 0xa1be, 0x1a1a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xeb);
    poke(0x1a1a, 0x21);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf000, 0x532b, 0xa1be, 0x1a1a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbec
  test('cbec', () {
    // Set up machine initial state
    loadRegisters(0xf200, 0xf0f3, 0xa816, 0xba08, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xec);
    poke(0xba08, 0x82);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf200, 0xf0f3, 0xa816, 0xba08, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbed
  test('cbed', () {
    // Set up machine initial state
    loadRegisters(0x1300, 0x5127, 0xadab, 0x2dec, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xed);
    poke(0x2dec, 0xcb);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1300, 0x5127, 0xadab, 0x2dec, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbee
  test('cbee', () {
    // Set up machine initial state
    loadRegisters(0x9000, 0xb273, 0x50ae, 0xe90d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xee);
    poke(0xe90d, 0xf1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9000, 0xb273, 0x50ae, 0xe90d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
  });


  // Test instruction cbef
  test('cbef', () {
    // Set up machine initial state
    loadRegisters(0x2500, 0x4281, 0xf0d4, 0x2c39, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xef);
    poke(0x2c39, 0xc8);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2500, 0x4281, 0xf0d4, 0x2c39, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbf0
  test('cbf0', () {
    // Set up machine initial state
    loadRegisters(0xfb00, 0x5802, 0x0c27, 0x6ff5, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xf0);
    poke(0x6ff5, 0xf6);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xfb00, 0x5802, 0x0c27, 0x6ff5, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbf1
  test('cbf1', () {
    // Set up machine initial state
    loadRegisters(0x5500, 0xa103, 0x3ff5, 0x5e1c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xf1);
    poke(0x5e1c, 0x37);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5500, 0xa143, 0x3ff5, 0x5e1c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbf2
  test('cbf2', () {
    // Set up machine initial state
    loadRegisters(0xf000, 0x625a, 0xaf82, 0x9819, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xf2);
    poke(0x9819, 0xe4);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf000, 0x625a, 0xef82, 0x9819, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbf3
  test('cbf3', () {
    // Set up machine initial state
    loadRegisters(0x8600, 0xd7bd, 0x5d86, 0x263f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xf3);
    poke(0x263f, 0xa1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8600, 0xd7bd, 0x5dc6, 0x263f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbf4
  test('cbf4', () {
    // Set up machine initial state
    loadRegisters(0x9400, 0x0243, 0x9ec1, 0x75d9, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xf4);
    poke(0x75d9, 0x3f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9400, 0x0243, 0x9ec1, 0x75d9, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbf5
  test('cbf5', () {
    // Set up machine initial state
    loadRegisters(0xce00, 0x2d42, 0x5e6a, 0x47e6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xf5);
    poke(0x47e6, 0xce);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xce00, 0x2d42, 0x5e6a, 0x47e6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbf6
  test('cbf6', () {
    // Set up machine initial state
    loadRegisters(0x7b00, 0xc2d7, 0x4492, 0xa9bc, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xf6);
    poke(0xa9bc, 0xb1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7b00, 0xc2d7, 0x4492, 0xa9bc, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
    expect(peek(43452), equals(0xf1));
  });


  // Test instruction cbf7
  test('cbf7', () {
    // Set up machine initial state
    loadRegisters(0x6d00, 0xabaf, 0x5b5d, 0x188c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xf7);
    poke(0x188c, 0x6c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6d00, 0xabaf, 0x5b5d, 0x188c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbf8
  test('cbf8', () {
    // Set up machine initial state
    loadRegisters(0xc600, 0xb812, 0xa037, 0xd2b0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xf8);
    poke(0xd2b0, 0xcb);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc600, 0xb812, 0xa037, 0xd2b0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbf9
  test('cbf9', () {
    // Set up machine initial state
    loadRegisters(0xef00, 0xc5f2, 0x77a8, 0x0730, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xf9);
    poke(0x0730, 0xae);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xef00, 0xc5f2, 0x77a8, 0x0730, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbfa
  test('cbfa', () {
    // Set up machine initial state
    loadRegisters(0x8700, 0x1581, 0x63e3, 0xed03, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xfa);
    poke(0xed03, 0x27);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8700, 0x1581, 0xe3e3, 0xed03, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbfb
  test('cbfb', () {
    // Set up machine initial state
    loadRegisters(0xa300, 0x7d27, 0x97c3, 0xd1ae, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xfb);
    poke(0xd1ae, 0xf2);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa300, 0x7d27, 0x97c3, 0xd1ae, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbfc
  test('cbfc', () {
    // Set up machine initial state
    loadRegisters(0xec00, 0x060a, 0x3ef6, 0x500f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xfc);
    poke(0x500f, 0x94);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xec00, 0x060a, 0x3ef6, 0xd00f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbfd
  test('cbfd', () {
    // Set up machine initial state
    loadRegisters(0x1100, 0x231a, 0x8563, 0x28c5, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xfd);
    poke(0x28c5, 0xab);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1100, 0x231a, 0x8563, 0x28c5, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cbfe
  test('cbfe', () {
    // Set up machine initial state
    loadRegisters(0x5300, 0x4948, 0x89dd, 0x3a24, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xfe);
    poke(0x3a24, 0xc3);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5300, 0x4948, 0x89dd, 0x3a24, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
  });


  // Test instruction cbff
  test('cbff', () {
    // Set up machine initial state
    loadRegisters(0x7900, 0x799b, 0x6cf7, 0xe3f2, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcb);
    poke(0x0001, 0xff);
    poke(0xe3f2, 0x25);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf900, 0x799b, 0x6cf7, 0xe3f2, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction cc_1
  test('cc_1', () {
    // Set up machine initial state
    loadRegisters(0x004e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5698, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcc);
    poke(0x0001, 0x61);
    poke(0x0002, 0x9c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x004e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5696, 0x9c61);
    checkSpecialRegisters(0x00, 0x01, false, false, 17);
    expect(peek(22166), equals(0x03));
    expect(peek(22167), equals(0x00));
  });


  // Test instruction cc_2
  test('cc_2', () {
    // Set up machine initial state
    loadRegisters(0x000e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5698, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcc);
    poke(0x0001, 0x61);
    poke(0x0002, 0x9c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x000e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5698, 0x0003);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction cd
  test('cd', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xb07d, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xcd);
    poke(0x0001, 0x5d);
    poke(0x0002, 0x3a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xb07b, 0x3a5d);
    checkSpecialRegisters(0x00, 0x01, false, false, 17);
    expect(peek(45179), equals(0x03));
    expect(peek(45180), equals(0x00));
  });


  // Test instruction ce
  test('ce', () {
    // Set up machine initial state
    loadRegisters(0x60f5, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xce);
    poke(0x0001, 0xb2);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1301, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction cf
  test('cf', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5507, 0x6d33);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x6d33, 0xcf);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5505, 0x0008);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
    expect(peek(21765), equals(0x34));
    expect(peek(21766), equals(0x6d));
  });


  // Test instruction d0_1
  test('d0_1', () {
    // Set up machine initial state
    loadRegisters(0x0098, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f7, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xd0);
    poke(0x43f7, 0xe9);
    poke(0x43f8, 0xaf);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0098, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f9, 0xafe9);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
  });


  // Test instruction d0_2
  test('d0_2', () {
    // Set up machine initial state
    loadRegisters(0x0099, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f7, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xd0);
    poke(0x43f7, 0xe9);
    poke(0x43f8, 0xaf);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0099, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f7, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 5);
  });


  // Test instruction d1
  test('d1', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x4143, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xd1);
    poke(0x4143, 0xce);
    poke(0x4144, 0xe8);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0xe8ce, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x4145, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction d2_1
  test('d2_1', () {
    // Set up machine initial state
    loadRegisters(0x0086, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xd2);
    poke(0x0001, 0x1b);
    poke(0x0002, 0xe1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0086, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xe11b);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction d2_2
  test('d2_2', () {
    // Set up machine initial state
    loadRegisters(0x0087, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xd2);
    poke(0x0001, 0x1b);
    poke(0x0002, 0xe1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0087, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction d3_1
  test('d3_1', () {
    // Set up machine initial state
    loadRegisters(0xa200, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xd3);
    poke(0x0001, 0xed);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa200, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
  });


  // Test instruction d3_2
  test('d3_2', () {
    // Set up machine initial state
    loadRegisters(0x4200, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xd3);
    poke(0x0001, 0xec);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4200, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
  });


  // Test instruction d3_3
  test('d3_3', () {
    // Set up machine initial state
    loadRegisters(0x4200, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xd3);
    poke(0x0001, 0xed);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4200, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
  });


  // Test instruction d3_4
  test('d3_4', () {
    // Set up machine initial state
    loadRegisters(0xa200, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xd3);
    poke(0x0001, 0xff);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa200, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
  });


  // Test instruction d3
  test('d3', () {
    // Set up machine initial state
    loadRegisters(0xa200, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xd3);
    poke(0x0001, 0xec);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa200, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
  });


  // Test instruction d4_1
  test('d4_1', () {
    // Set up machine initial state
    loadRegisters(0x000e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5698, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xd4);
    poke(0x0001, 0x61);
    poke(0x0002, 0x9c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x000e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5696, 0x9c61);
    checkSpecialRegisters(0x00, 0x01, false, false, 17);
    expect(peek(22166), equals(0x03));
    expect(peek(22167), equals(0x00));
  });


  // Test instruction d4_2
  test('d4_2', () {
    // Set up machine initial state
    loadRegisters(0x000f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5698, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xd4);
    poke(0x0001, 0x61);
    poke(0x0002, 0x9c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x000f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5698, 0x0003);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction d5
  test('d5', () {
    // Set up machine initial state
    loadRegisters(0x53e3, 0x1459, 0x775f, 0x1a2f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xec12, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xd5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x53e3, 0x1459, 0x775f, 0x1a2f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xec10, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
    expect(peek(60432), equals(0x5f));
    expect(peek(60433), equals(0x77));
  });


  // Test instruction d6
  test('d6', () {
    // Set up machine initial state
    loadRegisters(0x3900, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xd6);
    poke(0x0001, 0xdf);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5a1b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction d7
  test('d7', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5507, 0x6d33);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x6d33, 0xd7);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5505, 0x0010);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
    expect(peek(21765), equals(0x34));
    expect(peek(21766), equals(0x6d));
  });


  // Test instruction d8_1
  test('d8_1', () {
    // Set up machine initial state
    loadRegisters(0x0098, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f7, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xd8);
    poke(0x43f7, 0xe9);
    poke(0x43f8, 0xaf);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0098, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f7, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 5);
  });


  // Test instruction d8_2
  test('d8_2', () {
    // Set up machine initial state
    loadRegisters(0x0099, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f7, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xd8);
    poke(0x43f7, 0xe9);
    poke(0x43f8, 0xaf);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0099, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f9, 0xafe9);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
  });


  // Test instruction d9
  test('d9', () {
    // Set up machine initial state
    loadRegisters(0x4d94, 0xe07a, 0xe35b, 0x9d64, 0x1a64, 0xc930, 0x3d01, 0x7d02, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xd9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4d94, 0xc930, 0x3d01, 0x7d02, 0x1a64, 0xe07a, 0xe35b, 0x9d64, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction da_1
  test('da_1', () {
    // Set up machine initial state
    loadRegisters(0x0087, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xda);
    poke(0x0001, 0x1b);
    poke(0x0002, 0xe1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0087, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xe11b);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction da_2
  test('da_2', () {
    // Set up machine initial state
    loadRegisters(0x0086, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xda);
    poke(0x0001, 0x1b);
    poke(0x0002, 0xe1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0086, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction db_1
  test('db_1', () {
    // Set up machine initial state
    loadRegisters(0xc100, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdb);
    poke(0x0001, 0xe3);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc100, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
  });


  // Test instruction db_2
  test('db_2', () {
    // Set up machine initial state
    loadRegisters(0x7100, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdb);
    poke(0x0001, 0xe2);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7100, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
  });


  // Test instruction db_3
  test('db_3', () {
    // Set up machine initial state
    loadRegisters(0x7100, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdb);
    poke(0x0001, 0xe3);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7100, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
  });


  // Test instruction db
  test('db', () {
    // Set up machine initial state
    loadRegisters(0xc100, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdb);
    poke(0x0001, 0xe2);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc100, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
  });


  // Test instruction dc_1
  test('dc_1', () {
    // Set up machine initial state
    loadRegisters(0x000f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5698, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdc);
    poke(0x0001, 0x61);
    poke(0x0002, 0x9c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x000f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5696, 0x9c61);
    checkSpecialRegisters(0x00, 0x01, false, false, 17);
    expect(peek(22166), equals(0x03));
    expect(peek(22167), equals(0x00));
  });


  // Test instruction dc_2
  test('dc_2', () {
    // Set up machine initial state
    loadRegisters(0x000e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5698, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdc);
    poke(0x0001, 0x61);
    poke(0x0002, 0x9c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x000e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5698, 0x0003);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction dd00
  test('dd00', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x00);
    poke(0x0002, 0x00);

    // Execute machine for tState cycles
    while(z80.tStates < 9) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x03, false, false, 12);
  });


  // Test instruction dd09
  test('dd09', () {
    // Set up machine initial state
    loadRegisters(0x0d05, 0x1426, 0x53ce, 0x41e3, 0x0000, 0x0000, 0x0000, 0x0000, 0x9ec0, 0x5c89, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x09);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0d34, 0x1426, 0x53ce, 0x41e3, 0x0000, 0x0000, 0x0000, 0x0000, 0xb2e6, 0x5c89, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
  });


  // Test instruction dd19
  test('dd19', () {
    // Set up machine initial state
    loadRegisters(0x1911, 0x0e0b, 0x2724, 0xbe62, 0x0000, 0x0000, 0x0000, 0x0000, 0x824f, 0x760b, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x19);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1928, 0x0e0b, 0x2724, 0xbe62, 0x0000, 0x0000, 0x0000, 0x0000, 0xa973, 0x760b, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
  });


  // Test instruction dd21
  test('dd21', () {
    // Set up machine initial state
    loadRegisters(0xc935, 0x4353, 0xbd22, 0x94d5, 0x0000, 0x0000, 0x0000, 0x0000, 0xdade, 0xaad6, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x21);
    poke(0x0002, 0xf2);
    poke(0x0003, 0x7c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc935, 0x4353, 0xbd22, 0x94d5, 0x0000, 0x0000, 0x0000, 0x0000, 0x7cf2, 0xaad6, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 14);
  });


  // Test instruction dd22
  test('dd22', () {
    // Set up machine initial state
    loadRegisters(0x5b1d, 0x45a1, 0x6de8, 0x39d3, 0x0000, 0x0000, 0x0000, 0x0000, 0xebe7, 0x05b0, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x22);
    poke(0x0002, 0x4f);
    poke(0x0003, 0xad);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5b1d, 0x45a1, 0x6de8, 0x39d3, 0x0000, 0x0000, 0x0000, 0x0000, 0xebe7, 0x05b0, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
    expect(peek(44367), equals(0xe7));
    expect(peek(44368), equals(0xeb));
  });


  // Test instruction dd23
  test('dd23', () {
    // Set up machine initial state
    loadRegisters(0x9095, 0xac3c, 0x4d90, 0x379b, 0x0000, 0x0000, 0x0000, 0x0000, 0xd50b, 0xa157, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x23);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9095, 0xac3c, 0x4d90, 0x379b, 0x0000, 0x0000, 0x0000, 0x0000, 0xd50c, 0xa157, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 10);
  });


  // Test instruction dd24
  test('dd24', () {
    // Set up machine initial state
    loadRegisters(0x0698, 0xdcd0, 0xa31b, 0xd527, 0x0000, 0x0000, 0x0000, 0x0000, 0x8cda, 0xb096, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x24);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0688, 0xdcd0, 0xa31b, 0xd527, 0x0000, 0x0000, 0x0000, 0x0000, 0x8dda, 0xb096, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd25
  test('dd25', () {
    // Set up machine initial state
    loadRegisters(0x5acc, 0x206b, 0xed10, 0x6eab, 0x0000, 0x0000, 0x0000, 0x0000, 0xbb3c, 0x5ebd, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x25);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5aaa, 0x206b, 0xed10, 0x6eab, 0x0000, 0x0000, 0x0000, 0x0000, 0xba3c, 0x5ebd, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd26
  test('dd26', () {
    // Set up machine initial state
    loadRegisters(0x9522, 0xede0, 0xa352, 0xadea, 0x0000, 0x0000, 0x0000, 0x0000, 0x5f40, 0x82e1, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x26);
    poke(0x0002, 0xad);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9522, 0xede0, 0xa352, 0xadea, 0x0000, 0x0000, 0x0000, 0x0000, 0xad40, 0x82e1, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 11);
  }, tags: 'undocumented');


  // Test instruction dd29
  test('dd29', () {
    // Set up machine initial state
    loadRegisters(0xac80, 0x0f0e, 0x72c8, 0x1f2a, 0x0000, 0x0000, 0x0000, 0x0000, 0x5195, 0x7d8a, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x29);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xaca0, 0x0f0e, 0x72c8, 0x1f2a, 0x0000, 0x0000, 0x0000, 0x0000, 0xa32a, 0x7d8a, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
  });


  // Test instruction dd2a
  test('dd2a', () {
    // Set up machine initial state
    loadRegisters(0x3d36, 0xb24e, 0xbdbc, 0xca4e, 0x0000, 0x0000, 0x0000, 0x0000, 0xba65, 0xe7ce, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x2a);
    poke(0x0002, 0xbc);
    poke(0x0003, 0x40);
    poke(0x40bc, 0xb5);
    poke(0x40bd, 0x30);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3d36, 0xb24e, 0xbdbc, 0xca4e, 0x0000, 0x0000, 0x0000, 0x0000, 0x30b5, 0xe7ce, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  });


  // Test instruction dd2b
  test('dd2b', () {
    // Set up machine initial state
    loadRegisters(0xad4b, 0xd5e6, 0x9377, 0xf132, 0x0000, 0x0000, 0x0000, 0x0000, 0x7a17, 0x2188, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x2b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xad4b, 0xd5e6, 0x9377, 0xf132, 0x0000, 0x0000, 0x0000, 0x0000, 0x7a16, 0x2188, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 10);
  });


  // Test instruction dd2c
  test('dd2c', () {
    // Set up machine initial state
    loadRegisters(0x8838, 0xf2f3, 0xd277, 0x9153, 0x0000, 0x0000, 0x0000, 0x0000, 0xc62f, 0xb002, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x2c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8830, 0xf2f3, 0xd277, 0x9153, 0x0000, 0x0000, 0x0000, 0x0000, 0xc630, 0xb002, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd2d
  test('dd2d', () {
    // Set up machine initial state
    loadRegisters(0x39bc, 0xb23c, 0x6e11, 0x5a49, 0x0000, 0x0000, 0x0000, 0x0000, 0x0267, 0xab03, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x2d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3922, 0xb23c, 0x6e11, 0x5a49, 0x0000, 0x0000, 0x0000, 0x0000, 0x0266, 0xab03, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd2e
  test('dd2e', () {
    // Set up machine initial state
    loadRegisters(0x9aca, 0xa04a, 0xb49f, 0xa4a6, 0x0000, 0x0000, 0x0000, 0x0000, 0xbd90, 0x38a1, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x2e);
    poke(0x0002, 0x1c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9aca, 0xa04a, 0xb49f, 0xa4a6, 0x0000, 0x0000, 0x0000, 0x0000, 0xbd1c, 0x38a1, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 11);
  }, tags: 'undocumented');


  // Test instruction dd34
  test('dd34', () {
    // Set up machine initial state
    loadRegisters(0x8304, 0xd1fc, 0xb80b, 0x8082, 0x0000, 0x0000, 0x0000, 0x0000, 0xdea9, 0x6fd8, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x34);
    poke(0x0002, 0xe6);
    poke(0xde8f, 0x57);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8308, 0xd1fc, 0xb80b, 0x8082, 0x0000, 0x0000, 0x0000, 0x0000, 0xdea9, 0x6fd8, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(56975), equals(0x58));
  });


  // Test instruction dd35
  test('dd35', () {
    // Set up machine initial state
    loadRegisters(0x8681, 0x4641, 0x1ef6, 0x10ab, 0x0000, 0x0000, 0x0000, 0x0000, 0xc733, 0x8ec4, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x35);
    poke(0x0002, 0x60);
    poke(0xc793, 0xf7);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x86a3, 0x4641, 0x1ef6, 0x10ab, 0x0000, 0x0000, 0x0000, 0x0000, 0xc733, 0x8ec4, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(51091), equals(0xf6));
  });


  // Test instruction dd36
  test('dd36', () {
    // Set up machine initial state
    loadRegisters(0x76dc, 0x2530, 0x5158, 0x877d, 0x0000, 0x0000, 0x0000, 0x0000, 0xb5c6, 0x8d3c, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x36);
    poke(0x0002, 0x35);
    poke(0x0003, 0xb5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x76dc, 0x2530, 0x5158, 0x877d, 0x0000, 0x0000, 0x0000, 0x0000, 0xb5c6, 0x8d3c, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
    expect(peek(46587), equals(0xb5));
  });


  // Test instruction dd39
  test('dd39', () {
    // Set up machine initial state
    loadRegisters(0x875b, 0xa334, 0xd79d, 0x59e4, 0x0000, 0x0000, 0x0000, 0x0000, 0xb11a, 0x4c88, 0xfa4a, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x39);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8769, 0xa334, 0xd79d, 0x59e4, 0x0000, 0x0000, 0x0000, 0x0000, 0xab64, 0x4c88, 0xfa4a, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
  });


  // Test instruction dd44
  test('dd44', () {
    // Set up machine initial state
    loadRegisters(0xb37e, 0xcbb0, 0x36e8, 0x3f45, 0x0000, 0x0000, 0x0000, 0x0000, 0x2702, 0xb3b9, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x44);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb37e, 0x27b0, 0x36e8, 0x3f45, 0x0000, 0x0000, 0x0000, 0x0000, 0x2702, 0xb3b9, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd45
  test('dd45', () {
    // Set up machine initial state
    loadRegisters(0x4e10, 0x5c6d, 0xd11d, 0x1736, 0x0000, 0x0000, 0x0000, 0x0000, 0x7298, 0x2d10, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x45);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4e10, 0x986d, 0xd11d, 0x1736, 0x0000, 0x0000, 0x0000, 0x0000, 0x7298, 0x2d10, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd46
  test('dd46', () {
    // Set up machine initial state
    loadRegisters(0xc758, 0xbf29, 0x66f2, 0x29ef, 0x0000, 0x0000, 0x0000, 0x0000, 0x5cc7, 0x407d, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x46);
    poke(0x0002, 0x68);
    poke(0x5d2f, 0x8d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc758, 0x8d29, 0x66f2, 0x29ef, 0x0000, 0x0000, 0x0000, 0x0000, 0x5cc7, 0x407d, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
  });


  // Test instruction dd4c
  test('dd4c', () {
    // Set up machine initial state
    loadRegisters(0xe15c, 0x75ec, 0x7531, 0xae9e, 0x0000, 0x0000, 0x0000, 0x0000, 0x3ed8, 0x03b7, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x4c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe15c, 0x753e, 0x7531, 0xae9e, 0x0000, 0x0000, 0x0000, 0x0000, 0x3ed8, 0x03b7, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd4d
  test('dd4d', () {
    // Set up machine initial state
    loadRegisters(0x469e, 0x7864, 0x6a5a, 0x00e2, 0x0000, 0x0000, 0x0000, 0x0000, 0xa1aa, 0x0d6f, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x4d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x469e, 0x78aa, 0x6a5a, 0x00e2, 0x0000, 0x0000, 0x0000, 0x0000, 0xa1aa, 0x0d6f, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd4e
  test('dd4e', () {
    // Set up machine initial state
    loadRegisters(0x7bf7, 0x6605, 0x8d55, 0xdef2, 0x0000, 0x0000, 0x0000, 0x0000, 0xd94b, 0x17fb, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x4e);
    poke(0x0002, 0x2e);
    poke(0xd979, 0x76);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7bf7, 0x6676, 0x8d55, 0xdef2, 0x0000, 0x0000, 0x0000, 0x0000, 0xd94b, 0x17fb, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
  });


  // Test instruction dd54
  test('dd54', () {
    // Set up machine initial state
    loadRegisters(0x8376, 0x0d13, 0xc767, 0x3119, 0x0000, 0x0000, 0x0000, 0x0000, 0x4b6d, 0x030b, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x54);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8376, 0x0d13, 0x4b67, 0x3119, 0x0000, 0x0000, 0x0000, 0x0000, 0x4b6d, 0x030b, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd55
  test('dd55', () {
    // Set up machine initial state
    loadRegisters(0xff78, 0x85e3, 0x566b, 0x8f3a, 0x0000, 0x0000, 0x0000, 0x0000, 0xd7d7, 0x4e0b, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x55);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xff78, 0x85e3, 0xd76b, 0x8f3a, 0x0000, 0x0000, 0x0000, 0x0000, 0xd7d7, 0x4e0b, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd56
  test('dd56', () {
    // Set up machine initial state
    loadRegisters(0x97b3, 0xb617, 0xbb50, 0x81d1, 0x0000, 0x0000, 0x0000, 0x0000, 0xa306, 0x7a49, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x56);
    poke(0x0002, 0xf4);
    poke(0xa2fa, 0xde);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x97b3, 0xb617, 0xde50, 0x81d1, 0x0000, 0x0000, 0x0000, 0x0000, 0xa306, 0x7a49, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
  });


  // Test instruction dd5c
  test('dd5c', () {
    // Set up machine initial state
    loadRegisters(0xaf82, 0x24bf, 0x2793, 0xf925, 0x0000, 0x0000, 0x0000, 0x0000, 0xf9a3, 0x0b82, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x5c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xaf82, 0x24bf, 0x27f9, 0xf925, 0x0000, 0x0000, 0x0000, 0x0000, 0xf9a3, 0x0b82, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd5d
  test('dd5d', () {
    // Set up machine initial state
    loadRegisters(0x36cb, 0x97a9, 0x400d, 0x30fe, 0x0000, 0x0000, 0x0000, 0x0000, 0x3340, 0xb3ed, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x5d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x36cb, 0x97a9, 0x4040, 0x30fe, 0x0000, 0x0000, 0x0000, 0x0000, 0x3340, 0xb3ed, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd5e
  test('dd5e', () {
    // Set up machine initial state
    loadRegisters(0xa220, 0x389d, 0x2ff8, 0x368c, 0x0000, 0x0000, 0x0000, 0x0000, 0x8d32, 0x3512, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x5e);
    poke(0x0002, 0x8f);
    poke(0x8cc1, 0xce);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa220, 0x389d, 0x2fce, 0x368c, 0x0000, 0x0000, 0x0000, 0x0000, 0x8d32, 0x3512, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
  });


  // Test instruction dd60
  test('dd60', () {
    // Set up machine initial state
    loadRegisters(0x2392, 0x7f6a, 0x3dc0, 0xcefb, 0x0000, 0x0000, 0x0000, 0x0000, 0x44a0, 0xc424, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x60);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2392, 0x7f6a, 0x3dc0, 0xcefb, 0x0000, 0x0000, 0x0000, 0x0000, 0x7fa0, 0xc424, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd61
  test('dd61', () {
    // Set up machine initial state
    loadRegisters(0x76ed, 0x268c, 0xd5c8, 0xbab0, 0x0000, 0x0000, 0x0000, 0x0000, 0xb650, 0x0a93, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x61);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x76ed, 0x268c, 0xd5c8, 0xbab0, 0x0000, 0x0000, 0x0000, 0x0000, 0x8c50, 0x0a93, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd62
  test('dd62', () {
    // Set up machine initial state
    loadRegisters(0x4c6f, 0xb482, 0xfef4, 0x62e7, 0x0000, 0x0000, 0x0000, 0x0000, 0x6e25, 0x9655, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x62);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4c6f, 0xb482, 0xfef4, 0x62e7, 0x0000, 0x0000, 0x0000, 0x0000, 0xfe25, 0x9655, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd63
  test('dd63', () {
    // Set up machine initial state
    loadRegisters(0x6e9a, 0x5499, 0x3c8f, 0x1f64, 0x0000, 0x0000, 0x0000, 0x0000, 0xbf35, 0x0df7, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x63);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6e9a, 0x5499, 0x3c8f, 0x1f64, 0x0000, 0x0000, 0x0000, 0x0000, 0x8f35, 0x0df7, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd64
  test('dd64', () {
    // Set up machine initial state
    loadRegisters(0x47f6, 0x1b7a, 0xa55e, 0x2fc2, 0x0000, 0x0000, 0x0000, 0x0000, 0xefc7, 0xaca0, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x64);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x47f6, 0x1b7a, 0xa55e, 0x2fc2, 0x0000, 0x0000, 0x0000, 0x0000, 0xefc7, 0xaca0, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd65
  test('dd65', () {
    // Set up machine initial state
    loadRegisters(0xd786, 0x7d1d, 0xb659, 0x77e8, 0x0000, 0x0000, 0x0000, 0x0000, 0x58fa, 0x006d, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x65);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd786, 0x7d1d, 0xb659, 0x77e8, 0x0000, 0x0000, 0x0000, 0x0000, 0xfafa, 0x006d, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd66
  test('dd66', () {
    // Set up machine initial state
    loadRegisters(0x84c2, 0x79b1, 0xca4a, 0xaaa0, 0x0000, 0x0000, 0x0000, 0x0000, 0xce5d, 0xdd2d, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x66);
    poke(0x0002, 0xb5);
    poke(0xce12, 0x03);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x84c2, 0x79b1, 0xca4a, 0x03a0, 0x0000, 0x0000, 0x0000, 0x0000, 0xce5d, 0xdd2d, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
  });


  // Test instruction dd67
  test('dd67', () {
    // Set up machine initial state
    loadRegisters(0x967c, 0x511e, 0x336d, 0x40f6, 0x0000, 0x0000, 0x0000, 0x0000, 0x66e7, 0x5be2, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x67);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x967c, 0x511e, 0x336d, 0x40f6, 0x0000, 0x0000, 0x0000, 0x0000, 0x96e7, 0x5be2, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd68
  test('dd68', () {
    // Set up machine initial state
    loadRegisters(0x4a9d, 0xefa8, 0xfebd, 0x07e4, 0x0000, 0x0000, 0x0000, 0x0000, 0x5fd8, 0xb23f, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x68);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4a9d, 0xefa8, 0xfebd, 0x07e4, 0x0000, 0x0000, 0x0000, 0x0000, 0x5fef, 0xb23f, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd69
  test('dd69', () {
    // Set up machine initial state
    loadRegisters(0x6466, 0x2142, 0x2523, 0x82b3, 0x0000, 0x0000, 0x0000, 0x0000, 0x6479, 0x04a7, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x69);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6466, 0x2142, 0x2523, 0x82b3, 0x0000, 0x0000, 0x0000, 0x0000, 0x6442, 0x04a7, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd6a
  test('dd6a', () {
    // Set up machine initial state
    loadRegisters(0x401f, 0x61f1, 0x4b08, 0xfa88, 0x0000, 0x0000, 0x0000, 0x0000, 0xc37f, 0xd8f6, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x6a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x401f, 0x61f1, 0x4b08, 0xfa88, 0x0000, 0x0000, 0x0000, 0x0000, 0xc34b, 0xd8f6, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd6b
  test('dd6b', () {
    // Set up machine initial state
    loadRegisters(0x6dc7, 0xe2ae, 0x40bd, 0xf3c0, 0x0000, 0x0000, 0x0000, 0x0000, 0x2290, 0x2749, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x6b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6dc7, 0xe2ae, 0x40bd, 0xf3c0, 0x0000, 0x0000, 0x0000, 0x0000, 0x22bd, 0x2749, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd6c
  test('dd6c', () {
    // Set up machine initial state
    loadRegisters(0x3939, 0x90da, 0x62dc, 0x7c31, 0x0000, 0x0000, 0x0000, 0x0000, 0x412f, 0x7211, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x6c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3939, 0x90da, 0x62dc, 0x7c31, 0x0000, 0x0000, 0x0000, 0x0000, 0x4141, 0x7211, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd6d
  test('dd6d', () {
    // Set up machine initial state
    loadRegisters(0x3964, 0xff3f, 0x23d4, 0xc7c7, 0x0000, 0x0000, 0x0000, 0x0000, 0x9b70, 0x20c6, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x6d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3964, 0xff3f, 0x23d4, 0xc7c7, 0x0000, 0x0000, 0x0000, 0x0000, 0x9b70, 0x20c6, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd6e
  test('dd6e', () {
    // Set up machine initial state
    loadRegisters(0x223f, 0xf661, 0xb61c, 0x0f53, 0x0000, 0x0000, 0x0000, 0x0000, 0xc648, 0xfae8, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x6e);
    poke(0x0002, 0x2c);
    poke(0xc674, 0x6b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x223f, 0xf661, 0xb61c, 0x0f6b, 0x0000, 0x0000, 0x0000, 0x0000, 0xc648, 0xfae8, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
  });


  // Test instruction dd6f
  test('dd6f', () {
    // Set up machine initial state
    loadRegisters(0x6e84, 0x9cd4, 0xa293, 0x647d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0d0b, 0x4a56, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x6f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6e84, 0x9cd4, 0xa293, 0x647d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0d6e, 0x4a56, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd70
  test('dd70', () {
    // Set up machine initial state
    loadRegisters(0xd09f, 0xfe00, 0x231e, 0x31ec, 0x0000, 0x0000, 0x0000, 0x0000, 0x05fa, 0xea92, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x70);
    poke(0x0002, 0xf6);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd09f, 0xfe00, 0x231e, 0x31ec, 0x0000, 0x0000, 0x0000, 0x0000, 0x05fa, 0xea92, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
    expect(peek(1520), equals(0xfe));
  });


  // Test instruction dd71
  test('dd71', () {
    // Set up machine initial state
    loadRegisters(0xebee, 0x151c, 0x05c7, 0xee08, 0x0000, 0x0000, 0x0000, 0x0000, 0x3722, 0x2ec6, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x71);
    poke(0x0002, 0x23);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xebee, 0x151c, 0x05c7, 0xee08, 0x0000, 0x0000, 0x0000, 0x0000, 0x3722, 0x2ec6, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
    expect(peek(14149), equals(0x1c));
  });


  // Test instruction dd72
  test('dd72', () {
    // Set up machine initial state
    loadRegisters(0x80c9, 0xac1e, 0x63bd, 0x828b, 0x0000, 0x0000, 0x0000, 0x0000, 0x8dff, 0x94ef, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x72);
    poke(0x0002, 0x93);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x80c9, 0xac1e, 0x63bd, 0x828b, 0x0000, 0x0000, 0x0000, 0x0000, 0x8dff, 0x94ef, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
    expect(peek(36242), equals(0x63));
  });


  // Test instruction dd73
  test('dd73', () {
    // Set up machine initial state
    loadRegisters(0x8f3e, 0xb5a3, 0x07de, 0x0b0c, 0x0000, 0x0000, 0x0000, 0x0000, 0x79c6, 0xae79, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x73);
    poke(0x0002, 0x57);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8f3e, 0xb5a3, 0x07de, 0x0b0c, 0x0000, 0x0000, 0x0000, 0x0000, 0x79c6, 0xae79, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
    expect(peek(31261), equals(0xde));
  });


  // Test instruction dd74
  test('dd74', () {
    // Set up machine initial state
    loadRegisters(0x4ae0, 0x49c5, 0x3deb, 0x0125, 0x0000, 0x0000, 0x0000, 0x0000, 0x5910, 0x429a, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x74);
    poke(0x0002, 0xb9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4ae0, 0x49c5, 0x3deb, 0x0125, 0x0000, 0x0000, 0x0000, 0x0000, 0x5910, 0x429a, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
    expect(peek(22729), equals(0x01));
  });


  // Test instruction dd75
  test('dd75', () {
    // Set up machine initial state
    loadRegisters(0x5772, 0xe833, 0xb63e, 0x734f, 0x0000, 0x0000, 0x0000, 0x0000, 0xae4c, 0xe8c2, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x75);
    poke(0x0002, 0x30);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5772, 0xe833, 0xb63e, 0x734f, 0x0000, 0x0000, 0x0000, 0x0000, 0xae4c, 0xe8c2, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
    expect(peek(44668), equals(0x4f));
  });


  // Test instruction dd77
  test('dd77', () {
    // Set up machine initial state
    loadRegisters(0xdc56, 0xd893, 0x4116, 0xf2d2, 0x0000, 0x0000, 0x0000, 0x0000, 0xa181, 0x3157, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x77);
    poke(0x0002, 0x8c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xdc56, 0xd893, 0x4116, 0xf2d2, 0x0000, 0x0000, 0x0000, 0x0000, 0xa181, 0x3157, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
    expect(peek(41229), equals(0xdc));
  });


  // Test instruction dd7c
  test('dd7c', () {
    // Set up machine initial state
    loadRegisters(0x7558, 0x7705, 0xac92, 0xa6a1, 0x0000, 0x0000, 0x0000, 0x0000, 0x8cde, 0x7507, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x7c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8c58, 0x7705, 0xac92, 0xa6a1, 0x0000, 0x0000, 0x0000, 0x0000, 0x8cde, 0x7507, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd7d
  test('dd7d', () {
    // Set up machine initial state
    loadRegisters(0x6c18, 0x93fb, 0x6bdd, 0x3a10, 0x0000, 0x0000, 0x0000, 0x0000, 0xd7cb, 0xc0f6, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x7d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xcb18, 0x93fb, 0x6bdd, 0x3a10, 0x0000, 0x0000, 0x0000, 0x0000, 0xd7cb, 0xc0f6, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd7e
  test('dd7e', () {
    // Set up machine initial state
    loadRegisters(0x6a66, 0x1f77, 0x6220, 0x0c40, 0x0000, 0x0000, 0x0000, 0x0000, 0x1cf4, 0x1a1f, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x7e);
    poke(0x0002, 0xbc);
    poke(0x1cb0, 0x57);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5766, 0x1f77, 0x6220, 0x0c40, 0x0000, 0x0000, 0x0000, 0x0000, 0x1cf4, 0x1a1f, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
  });


  // Test instruction dd84
  test('dd84', () {
    // Set up machine initial state
    loadRegisters(0x2e47, 0x1de8, 0xb8b9, 0x78a6, 0x0000, 0x0000, 0x0000, 0x0000, 0x9f1d, 0xb11f, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x84);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xcd98, 0x1de8, 0xb8b9, 0x78a6, 0x0000, 0x0000, 0x0000, 0x0000, 0x9f1d, 0xb11f, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd85
  test('dd85', () {
    // Set up machine initial state
    loadRegisters(0xb27a, 0xb1ff, 0x8d7b, 0x40c0, 0x0000, 0x0000, 0x0000, 0x0000, 0xb513, 0x0688, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x85);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc580, 0xb1ff, 0x8d7b, 0x40c0, 0x0000, 0x0000, 0x0000, 0x0000, 0xb513, 0x0688, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd86
  test('dd86', () {
    // Set up machine initial state
    loadRegisters(0x4efa, 0xd085, 0x5bac, 0xe364, 0x0000, 0x0000, 0x0000, 0x0000, 0xb5b5, 0xfe3a, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x86);
    poke(0x0002, 0xc1);
    poke(0xb576, 0x5b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa9bc, 0xd085, 0x5bac, 0xe364, 0x0000, 0x0000, 0x0000, 0x0000, 0xb5b5, 0xfe3a, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
  });


  // Test instruction dd8c
  test('dd8c', () {
    // Set up machine initial state
    loadRegisters(0xbc63, 0x8fdc, 0xea8f, 0x9734, 0x0000, 0x0000, 0x0000, 0x0000, 0x0eb3, 0x1b54, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x8c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xcb98, 0x8fdc, 0xea8f, 0x9734, 0x0000, 0x0000, 0x0000, 0x0000, 0x0eb3, 0x1b54, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd8d
  test('dd8d', () {
    // Set up machine initial state
    loadRegisters(0xb61f, 0x1c81, 0xb6fb, 0xd6e5, 0x0000, 0x0000, 0x0000, 0x0000, 0x09be, 0xa736, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x8d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7535, 0x1c81, 0xb6fb, 0xd6e5, 0x0000, 0x0000, 0x0000, 0x0000, 0x09be, 0xa736, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd8e
  test('dd8e', () {
    // Set up machine initial state
    loadRegisters(0x4ed4, 0x182d, 0xab17, 0x94ae, 0x0000, 0x0000, 0x0000, 0x0000, 0xbb97, 0x87da, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x8e);
    poke(0x0002, 0x25);
    poke(0xbbbc, 0x32);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8094, 0x182d, 0xab17, 0x94ae, 0x0000, 0x0000, 0x0000, 0x0000, 0xbb97, 0x87da, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
  });


  // Test instruction dd94
  test('dd94', () {
    // Set up machine initial state
    loadRegisters(0x7ef1, 0x9efe, 0x6ea1, 0xfc55, 0x0000, 0x0000, 0x0000, 0x0000, 0x0a09, 0x89c5, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x94);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7422, 0x9efe, 0x6ea1, 0xfc55, 0x0000, 0x0000, 0x0000, 0x0000, 0x0a09, 0x89c5, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd95
  test('dd95', () {
    // Set up machine initial state
    loadRegisters(0x2920, 0x59ab, 0x428c, 0x3a94, 0x0000, 0x0000, 0x0000, 0x0000, 0x44fd, 0xf243, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x95);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2c3b, 0x59ab, 0x428c, 0x3a94, 0x0000, 0x0000, 0x0000, 0x0000, 0x44fd, 0xf243, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd96
  test('dd96', () {
    // Set up machine initial state
    loadRegisters(0x9b76, 0x461f, 0xced7, 0xdb3f, 0x0000, 0x0000, 0x0000, 0x0000, 0x2c66, 0x9dbf, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x96);
    poke(0x0002, 0x5f);
    poke(0x2cc5, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5206, 0x461f, 0xced7, 0xdb3f, 0x0000, 0x0000, 0x0000, 0x0000, 0x2c66, 0x9dbf, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
  });


  // Test instruction dd9c
  test('dd9c', () {
    // Set up machine initial state
    loadRegisters(0xfaf4, 0x670e, 0xafcc, 0x8b34, 0x0000, 0x0000, 0x0000, 0x0000, 0x285f, 0x1caa, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x9c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd282, 0x670e, 0xafcc, 0x8b34, 0x0000, 0x0000, 0x0000, 0x0000, 0x285f, 0x1caa, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd9d
  test('dd9d', () {
    // Set up machine initial state
    loadRegisters(0xf827, 0x0cdb, 0xdf32, 0xd0e4, 0x0000, 0x0000, 0x0000, 0x0000, 0x9b12, 0x7d07, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x9d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe5a2, 0x0cdb, 0xdf32, 0xd0e4, 0x0000, 0x0000, 0x0000, 0x0000, 0x9b12, 0x7d07, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dd9e
  test('dd9e', () {
    // Set up machine initial state
    loadRegisters(0x938e, 0xf9c5, 0xcbc4, 0xca21, 0x0000, 0x0000, 0x0000, 0x0000, 0xb4cc, 0x46fa, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0x9e);
    poke(0x0002, 0x14);
    poke(0xb4e0, 0xb5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xde9b, 0xf9c5, 0xcbc4, 0xca21, 0x0000, 0x0000, 0x0000, 0x0000, 0xb4cc, 0x46fa, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
  });


  // Test instruction dda4
  test('dda4', () {
    // Set up machine initial state
    loadRegisters(0x52f5, 0xba53, 0xacfc, 0x9481, 0x0000, 0x0000, 0x0000, 0x0000, 0x2f8b, 0xedf6, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xa4);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0210, 0xba53, 0xacfc, 0x9481, 0x0000, 0x0000, 0x0000, 0x0000, 0x2f8b, 0xedf6, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dda5
  test('dda5', () {
    // Set up machine initial state
    loadRegisters(0xbaaf, 0xa675, 0xd757, 0xf1db, 0x0000, 0x0000, 0x0000, 0x0000, 0xfdef, 0xd8ce, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xa5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xaabc, 0xa675, 0xd757, 0xf1db, 0x0000, 0x0000, 0x0000, 0x0000, 0xfdef, 0xd8ce, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction dda6
  test('dda6', () {
    // Set up machine initial state
    loadRegisters(0x1da4, 0x20c4, 0xebc3, 0xda8d, 0x0000, 0x0000, 0x0000, 0x0000, 0x7e95, 0x5e8a, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xa6);
    poke(0x0002, 0x41);
    poke(0x7ed6, 0xc7);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0514, 0x20c4, 0xebc3, 0xda8d, 0x0000, 0x0000, 0x0000, 0x0000, 0x7e95, 0x5e8a, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
  });


  // Test instruction ddac
  test('ddac', () {
    // Set up machine initial state
    loadRegisters(0xef15, 0x2a7c, 0x17e5, 0x3f6e, 0x0000, 0x0000, 0x0000, 0x0000, 0xaffa, 0xa0b5, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xac);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4000, 0x2a7c, 0x17e5, 0x3f6e, 0x0000, 0x0000, 0x0000, 0x0000, 0xaffa, 0xa0b5, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction ddad
  test('ddad', () {
    // Set up machine initial state
    loadRegisters(0xba2e, 0x6ba1, 0xef1b, 0x5713, 0x0000, 0x0000, 0x0000, 0x0000, 0xba38, 0xa708, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xad);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8284, 0x6ba1, 0xef1b, 0x5713, 0x0000, 0x0000, 0x0000, 0x0000, 0xba38, 0xa708, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction ddae
  test('ddae', () {
    // Set up machine initial state
    loadRegisters(0x8009, 0x3ad6, 0xa721, 0x2100, 0x0000, 0x0000, 0x0000, 0x0000, 0xe909, 0x87b4, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xae);
    poke(0x0002, 0x72);
    poke(0xe97b, 0xc3);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4300, 0x3ad6, 0xa721, 0x2100, 0x0000, 0x0000, 0x0000, 0x0000, 0xe909, 0x87b4, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
  });


  // Test instruction ddb4
  test('ddb4', () {
    // Set up machine initial state
    loadRegisters(0x1ccd, 0x29aa, 0x2e82, 0x4dc8, 0x0000, 0x0000, 0x0000, 0x0000, 0x9c04, 0x8be3, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xb4);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9c8c, 0x29aa, 0x2e82, 0x4dc8, 0x0000, 0x0000, 0x0000, 0x0000, 0x9c04, 0x8be3, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction ddb5
  test('ddb5', () {
    // Set up machine initial state
    loadRegisters(0x46b4, 0xfc93, 0x7a06, 0x0518, 0x0000, 0x0000, 0x0000, 0x0000, 0x0ac5, 0x4150, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xb5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc780, 0xfc93, 0x7a06, 0x0518, 0x0000, 0x0000, 0x0000, 0x0000, 0x0ac5, 0x4150, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction ddb6
  test('ddb6', () {
    // Set up machine initial state
    loadRegisters(0x5017, 0xab81, 0x4287, 0x5ee1, 0x0000, 0x0000, 0x0000, 0x0000, 0xc66f, 0xd6cc, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xb6);
    poke(0x0002, 0x31);
    poke(0xc6a0, 0x1c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5c0c, 0xab81, 0x4287, 0x5ee1, 0x0000, 0x0000, 0x0000, 0x0000, 0xc66f, 0xd6cc, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
  });


  // Test instruction ddbc
  test('ddbc', () {
    // Set up machine initial state
    loadRegisters(0x53e0, 0xaa98, 0xf7d7, 0xfa0c, 0x0000, 0x0000, 0x0000, 0x0000, 0xbe7a, 0xa41f, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xbc);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x53bf, 0xaa98, 0xf7d7, 0xfa0c, 0x0000, 0x0000, 0x0000, 0x0000, 0xbe7a, 0xa41f, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction ddbd
  test('ddbd', () {
    // Set up machine initial state
    loadRegisters(0xdc83, 0x80ce, 0x5d2f, 0xe999, 0x0000, 0x0000, 0x0000, 0x0000, 0xbb41, 0xa24f, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xbd);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xdc82, 0x80ce, 0x5d2f, 0xe999, 0x0000, 0x0000, 0x0000, 0x0000, 0xbb41, 0xa24f, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction ddbe
  test('ddbe', () {
    // Set up machine initial state
    loadRegisters(0x9838, 0xbfd5, 0xa299, 0xd34b, 0x0000, 0x0000, 0x0000, 0x0000, 0x9332, 0xb1d5, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xbe);
    poke(0x0002, 0x48);
    poke(0x937a, 0x5b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x981e, 0xbfd5, 0xa299, 0xd34b, 0x0000, 0x0000, 0x0000, 0x0000, 0x9332, 0xb1d5, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
  });


  // Test instruction ddcb00
  test('ddcb00', () {
    // Set up machine initial state
    loadRegisters(0x3c65, 0xf0e4, 0x09d1, 0x646b, 0x0000, 0x0000, 0x0000, 0x0000, 0x1da1, 0xf08f, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x0d);
    poke(0x0003, 0x00);
    poke(0x1dae, 0xa1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3c01, 0x43e4, 0x09d1, 0x646b, 0x0000, 0x0000, 0x0000, 0x0000, 0x1da1, 0xf08f, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(7598), equals(0x43));
  }, tags: 'undocumented');


  // Test instruction ddcb01
  test('ddcb01', () {
    // Set up machine initial state
    loadRegisters(0xf68f, 0xe33b, 0x2d4a, 0x7725, 0x0000, 0x0000, 0x0000, 0x0000, 0x28fd, 0xf31b, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xb7);
    poke(0x0003, 0x01);
    poke(0x28b4, 0xe3);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf681, 0xe3c7, 0x2d4a, 0x7725, 0x0000, 0x0000, 0x0000, 0x0000, 0x28fd, 0xf31b, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(10420), equals(0xc7));
  }, tags: 'undocumented');


  // Test instruction ddcb02
  test('ddcb02', () {
    // Set up machine initial state
    loadRegisters(0xe20c, 0x836e, 0x513a, 0xf840, 0x0000, 0x0000, 0x0000, 0x0000, 0xc796, 0xae9b, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x91);
    poke(0x0003, 0x02);
    poke(0xc727, 0x8d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe20d, 0x836e, 0x1b3a, 0xf840, 0x0000, 0x0000, 0x0000, 0x0000, 0xc796, 0xae9b, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(50983), equals(0x1b));
  }, tags: 'undocumented');


  // Test instruction ddcb03
  test('ddcb03', () {
    // Set up machine initial state
    loadRegisters(0x6224, 0x3571, 0xc519, 0x48dc, 0x0000, 0x0000, 0x0000, 0x0000, 0x041e, 0xc07b, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x48);
    poke(0x0003, 0x03);
    poke(0x0466, 0x78);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x62a4, 0x3571, 0xc5f0, 0x48dc, 0x0000, 0x0000, 0x0000, 0x0000, 0x041e, 0xc07b, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(1126), equals(0xf0));
  }, tags: 'undocumented');


  // Test instruction ddcb04
  test('ddcb04', () {
    // Set up machine initial state
    loadRegisters(0xb310, 0xbfc4, 0x64af, 0xd622, 0x0000, 0x0000, 0x0000, 0x0000, 0x5949, 0xa989, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x48);
    poke(0x0003, 0x04);
    poke(0x5991, 0x68);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb380, 0xbfc4, 0x64af, 0xd022, 0x0000, 0x0000, 0x0000, 0x0000, 0x5949, 0xa989, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(22929), equals(0xd0));
  }, tags: 'undocumented');


  // Test instruction ddcb05
  test('ddcb05', () {
    // Set up machine initial state
    loadRegisters(0x4954, 0xbb04, 0x56ec, 0x9d58, 0x0000, 0x0000, 0x0000, 0x0000, 0x0077, 0x1349, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xff);
    poke(0x0003, 0x05);
    poke(0x0076, 0x95);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x492d, 0xbb04, 0x56ec, 0x9d2b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0077, 0x1349, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(118), equals(0x2b));
  }, tags: 'undocumented');


  // Test instruction ddcb06
  test('ddcb06', () {
    // Set up machine initial state
    loadRegisters(0x0cf4, 0xf636, 0x90a6, 0x6117, 0x0000, 0x0000, 0x0000, 0x0000, 0x5421, 0x90ee, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x07);
    poke(0x0003, 0x06);
    poke(0x5428, 0x97);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0c29, 0xf636, 0x90a6, 0x6117, 0x0000, 0x0000, 0x0000, 0x0000, 0x5421, 0x90ee, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(21544), equals(0x2f));
  });


  // Test instruction ddcb07
  test('ddcb07', () {
    // Set up machine initial state
    loadRegisters(0x6f4d, 0x9ca3, 0xbdf6, 0xed50, 0x0000, 0x0000, 0x0000, 0x0000, 0x9803, 0x55f9, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x42);
    poke(0x0003, 0x07);
    poke(0x9845, 0xae);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5d09, 0x9ca3, 0xbdf6, 0xed50, 0x0000, 0x0000, 0x0000, 0x0000, 0x9803, 0x55f9, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(38981), equals(0x5d));
  }, tags: 'undocumented');


  // Test instruction ddcb08
  test('ddcb08', () {
    // Set up machine initial state
    loadRegisters(0x02f4, 0x1c66, 0x6023, 0xae06, 0x0000, 0x0000, 0x0000, 0x0000, 0xef40, 0xb006, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x0a);
    poke(0x0003, 0x08);
    poke(0xef4a, 0xda);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0228, 0x6d66, 0x6023, 0xae06, 0x0000, 0x0000, 0x0000, 0x0000, 0xef40, 0xb006, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(61258), equals(0x6d));
  }, tags: 'undocumented');


  // Test instruction ddcb09
  test('ddcb09', () {
    // Set up machine initial state
    loadRegisters(0x9825, 0x9258, 0x54d5, 0x5e1e, 0x0000, 0x0000, 0x0000, 0x0000, 0x9d0b, 0x6e58, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x3b);
    poke(0x0003, 0x09);
    poke(0x9d46, 0x6f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x98a5, 0x92b7, 0x54d5, 0x5e1e, 0x0000, 0x0000, 0x0000, 0x0000, 0x9d0b, 0x6e58, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(40262), equals(0xb7));
  }, tags: 'undocumented');


  // Test instruction ddcb0a
  test('ddcb0a', () {
    // Set up machine initial state
    loadRegisters(0xd2dd, 0x6aac, 0xe789, 0x9293, 0x0000, 0x0000, 0x0000, 0x0000, 0x1fb4, 0x2498, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x83);
    poke(0x0003, 0x0a);
    poke(0x1f37, 0x78);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd22c, 0x6aac, 0x3c89, 0x9293, 0x0000, 0x0000, 0x0000, 0x0000, 0x1fb4, 0x2498, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(7991), equals(0x3c));
  }, tags: 'undocumented');


  // Test instruction ddcb0b
  test('ddcb0b', () {
    // Set up machine initial state
    loadRegisters(0xb82c, 0xb284, 0x23f8, 0x7e7d, 0x0000, 0x0000, 0x0000, 0x0000, 0xcd09, 0x6a03, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xfa);
    poke(0x0003, 0x0b);
    poke(0xcd03, 0x92);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb808, 0xb284, 0x2349, 0x7e7d, 0x0000, 0x0000, 0x0000, 0x0000, 0xcd09, 0x6a03, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(52483), equals(0x49));
  }, tags: 'undocumented');


  // Test instruction ddcb0c
  test('ddcb0c', () {
    // Set up machine initial state
    loadRegisters(0xdf8b, 0xb6cc, 0xee8d, 0x855a, 0x0000, 0x0000, 0x0000, 0x0000, 0xbf6b, 0x9b7d, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x79);
    poke(0x0003, 0x0c);
    poke(0xbfe4, 0x0d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xdf81, 0xb6cc, 0xee8d, 0x865a, 0x0000, 0x0000, 0x0000, 0x0000, 0xbf6b, 0x9b7d, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(49124), equals(0x86));
  }, tags: 'undocumented');


  // Test instruction ddcb0d
  test('ddcb0d', () {
    // Set up machine initial state
    loadRegisters(0xbae3, 0xceec, 0xbbaa, 0xb65e, 0x0000, 0x0000, 0x0000, 0x0000, 0x88bd, 0x503e, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xe4);
    poke(0x0003, 0x0d);
    poke(0x88a1, 0x1f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xba89, 0xceec, 0xbbaa, 0xb68f, 0x0000, 0x0000, 0x0000, 0x0000, 0x88bd, 0x503e, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(34977), equals(0x8f));
  }, tags: 'undocumented');


  // Test instruction ddcb0e
  test('ddcb0e', () {
    // Set up machine initial state
    loadRegisters(0x1c36, 0x890b, 0x7830, 0x060c, 0x0000, 0x0000, 0x0000, 0x0000, 0xfd49, 0x5d07, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xc6);
    poke(0x0003, 0x0e);
    poke(0xfd0f, 0xad);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1c81, 0x890b, 0x7830, 0x060c, 0x0000, 0x0000, 0x0000, 0x0000, 0xfd49, 0x5d07, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(64783), equals(0xd6));
  });


  // Test instruction ddcb0f
  test('ddcb0f', () {
    // Set up machine initial state
    loadRegisters(0xf5a7, 0xfad4, 0xfa4b, 0x9c53, 0x0000, 0x0000, 0x0000, 0x0000, 0x7447, 0x2267, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x57);
    poke(0x0003, 0x0f);
    poke(0x749e, 0xf8);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7c28, 0xfad4, 0xfa4b, 0x9c53, 0x0000, 0x0000, 0x0000, 0x0000, 0x7447, 0x2267, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(29854), equals(0x7c));
  }, tags: 'undocumented');


  // Test instruction ddcb10
  test('ddcb10', () {
    // Set up machine initial state
    loadRegisters(0xf3af, 0xba1f, 0x5387, 0x926e, 0x0000, 0x0000, 0x0000, 0x0000, 0xbba2, 0xca47, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x4f);
    poke(0x0003, 0x10);
    poke(0xbbf1, 0x45);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf38c, 0x8b1f, 0x5387, 0x926e, 0x0000, 0x0000, 0x0000, 0x0000, 0xbba2, 0xca47, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(48113), equals(0x8b));
  }, tags: 'undocumented');


  // Test instruction ddcb11
  test('ddcb11', () {
    // Set up machine initial state
    loadRegisters(0x2a69, 0xd604, 0xa9aa, 0x5b52, 0x0000, 0x0000, 0x0000, 0x0000, 0x1809, 0xd275, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xeb);
    poke(0x0003, 0x11);
    poke(0x17f4, 0xd9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2aa1, 0xd6b3, 0xa9aa, 0x5b52, 0x0000, 0x0000, 0x0000, 0x0000, 0x1809, 0xd275, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(6132), equals(0xb3));
  }, tags: 'undocumented');


  // Test instruction ddcb12
  test('ddcb12', () {
    // Set up machine initial state
    loadRegisters(0x9287, 0xc479, 0x26d1, 0x10ce, 0x0000, 0x0000, 0x0000, 0x0000, 0xc0fb, 0x2777, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xa6);
    poke(0x0003, 0x12);
    poke(0xc0a1, 0xe2);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9285, 0xc479, 0xc5d1, 0x10ce, 0x0000, 0x0000, 0x0000, 0x0000, 0xc0fb, 0x2777, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(49313), equals(0xc5));
  }, tags: 'undocumented');


  // Test instruction ddcb13
  test('ddcb13', () {
    // Set up machine initial state
    loadRegisters(0xa507, 0x580a, 0xa48f, 0x11cd, 0x0000, 0x0000, 0x0000, 0x0000, 0x5ac4, 0xccc7, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xff);
    poke(0x0003, 0x13);
    poke(0x5ac3, 0xa7);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa509, 0x580a, 0xa44f, 0x11cd, 0x0000, 0x0000, 0x0000, 0x0000, 0x5ac4, 0xccc7, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(23235), equals(0x4f));
  }, tags: 'undocumented');


  // Test instruction ddcb14
  test('ddcb14', () {
    // Set up machine initial state
    loadRegisters(0x294b, 0x5b89, 0x8467, 0x0430, 0x0000, 0x0000, 0x0000, 0x0000, 0x0977, 0xc4e8, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xdd);
    poke(0x0003, 0x14);
    poke(0x0954, 0x85);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2909, 0x5b89, 0x8467, 0x0b30, 0x0000, 0x0000, 0x0000, 0x0000, 0x0977, 0xc4e8, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(2388), equals(0x0b));
  }, tags: 'undocumented');


  // Test instruction ddcb15
  test('ddcb15', () {
    // Set up machine initial state
    loadRegisters(0x1fd1, 0x6d53, 0x5b7c, 0xa134, 0x0000, 0x0000, 0x0000, 0x0000, 0xede9, 0xa85c, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x07);
    poke(0x0003, 0x15);
    poke(0xedf0, 0x0e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1f0c, 0x6d53, 0x5b7c, 0xa11d, 0x0000, 0x0000, 0x0000, 0x0000, 0xede9, 0xa85c, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(60912), equals(0x1d));
  }, tags: 'undocumented');


  // Test instruction ddcb16
  test('ddcb16', () {
    // Set up machine initial state
    loadRegisters(0xda70, 0xa1e4, 0x00b0, 0x92c8, 0x0000, 0x0000, 0x0000, 0x0000, 0x16be, 0x2c95, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x45);
    poke(0x0003, 0x16);
    poke(0x1703, 0x5b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xdaa0, 0xa1e4, 0x00b0, 0x92c8, 0x0000, 0x0000, 0x0000, 0x0000, 0x16be, 0x2c95, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(5891), equals(0xb6));
  });


  // Test instruction ddcb17
  test('ddcb17', () {
    // Set up machine initial state
    loadRegisters(0x3300, 0xcbd1, 0x4e1a, 0xcd27, 0x0000, 0x0000, 0x0000, 0x0000, 0xb8c9, 0xe6d4, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x1c);
    poke(0x0003, 0x17);
    poke(0xb8e5, 0x7e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xfcac, 0xcbd1, 0x4e1a, 0xcd27, 0x0000, 0x0000, 0x0000, 0x0000, 0xb8c9, 0xe6d4, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(47333), equals(0xfc));
  }, tags: 'undocumented');


  // Test instruction ddcb18
  test('ddcb18', () {
    // Set up machine initial state
    loadRegisters(0xd980, 0x4eb5, 0x9cf9, 0xb9f1, 0x0000, 0x0000, 0x0000, 0x0000, 0xa189, 0xbd7c, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x0e);
    poke(0x0003, 0x18);
    poke(0xa197, 0x90);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd90c, 0x48b5, 0x9cf9, 0xb9f1, 0x0000, 0x0000, 0x0000, 0x0000, 0xa189, 0xbd7c, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(41367), equals(0x48));
  }, tags: 'undocumented');


  // Test instruction ddcb19
  test('ddcb19', () {
    // Set up machine initial state
    loadRegisters(0x23b7, 0x595a, 0xa756, 0xcf2e, 0x0000, 0x0000, 0x0000, 0x0000, 0xf0e7, 0x26e4, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xa3);
    poke(0x0003, 0x19);
    poke(0xf08a, 0x37);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2389, 0x599b, 0xa756, 0xcf2e, 0x0000, 0x0000, 0x0000, 0x0000, 0xf0e7, 0x26e4, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(61578), equals(0x9b));
  }, tags: 'undocumented');


  // Test instruction ddcb1a
  test('ddcb1a', () {
    // Set up machine initial state
    loadRegisters(0x8b52, 0x7e45, 0xbd0f, 0x37a6, 0x0000, 0x0000, 0x0000, 0x0000, 0xde61, 0x9cd9, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xac);
    poke(0x0003, 0x1a);
    poke(0xde0d, 0xcc);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8b24, 0x7e45, 0x660f, 0x37a6, 0x0000, 0x0000, 0x0000, 0x0000, 0xde61, 0x9cd9, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(56845), equals(0x66));
  }, tags: 'undocumented');


  // Test instruction ddcb1b
  test('ddcb1b', () {
    // Set up machine initial state
    loadRegisters(0x5c79, 0x1414, 0x811c, 0x5881, 0x0000, 0x0000, 0x0000, 0x0000, 0xb7c3, 0xd14f, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x05);
    poke(0x0003, 0x1b);
    poke(0xb7c8, 0x91);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5c89, 0x1414, 0x81c8, 0x5881, 0x0000, 0x0000, 0x0000, 0x0000, 0xb7c3, 0xd14f, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(47048), equals(0xc8));
  }, tags: 'undocumented');


  // Test instruction ddcb1c
  test('ddcb1c', () {
    // Set up machine initial state
    loadRegisters(0xfafc, 0x6277, 0x8b67, 0xd423, 0x0000, 0x0000, 0x0000, 0x0000, 0xfef9, 0x4a66, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xff);
    poke(0x0003, 0x1c);
    poke(0xfef8, 0x61);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xfa25, 0x6277, 0x8b67, 0x3023, 0x0000, 0x0000, 0x0000, 0x0000, 0xfef9, 0x4a66, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(65272), equals(0x30));
  }, tags: 'undocumented');


  // Test instruction ddcb1d
  test('ddcb1d', () {
    // Set up machine initial state
    loadRegisters(0x76a5, 0x324e, 0xe641, 0x58f9, 0x0000, 0x0000, 0x0000, 0x0000, 0x5b63, 0xe18b, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x3a);
    poke(0x0003, 0x1d);
    poke(0x5b9d, 0xf3);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x76ad, 0x324e, 0xe641, 0x58f9, 0x0000, 0x0000, 0x0000, 0x0000, 0x5b63, 0xe18b, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(23453), equals(0xf9));
  }, tags: 'undocumented');


  // Test instruction ddcb1e
  test('ddcb1e', () {
    // Set up machine initial state
    loadRegisters(0xc5d9, 0xcd58, 0x8967, 0xf074, 0x0000, 0x0000, 0x0000, 0x0000, 0x75b4, 0x693a, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xce);
    poke(0x0003, 0x1e);
    poke(0x7582, 0x91);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc589, 0xcd58, 0x8967, 0xf074, 0x0000, 0x0000, 0x0000, 0x0000, 0x75b4, 0x693a, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(30082), equals(0xc8));
  });


  // Test instruction ddcb1f
  test('ddcb1f', () {
    // Set up machine initial state
    loadRegisters(0xd28f, 0x7f6d, 0x2058, 0x63e3, 0x0000, 0x0000, 0x0000, 0x0000, 0x1d9b, 0xbaba, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xa8);
    poke(0x0003, 0x1f);
    poke(0x1d43, 0xb4);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xda88, 0x7f6d, 0x2058, 0x63e3, 0x0000, 0x0000, 0x0000, 0x0000, 0x1d9b, 0xbaba, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(7491), equals(0xda));
  }, tags: 'undocumented');


  // Test instruction ddcb20
  test('ddcb20', () {
    // Set up machine initial state
    loadRegisters(0x4ce5, 0x739e, 0xdc6c, 0x18f4, 0x0000, 0x0000, 0x0000, 0x0000, 0xdc39, 0x8b0c, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xe8);
    poke(0x0003, 0x20);
    poke(0xdc21, 0x0e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4c08, 0x1c9e, 0xdc6c, 0x18f4, 0x0000, 0x0000, 0x0000, 0x0000, 0xdc39, 0x8b0c, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(56353), equals(0x1c));
  }, tags: 'undocumented');


  // Test instruction ddcb21
  test('ddcb21', () {
    // Set up machine initial state
    loadRegisters(0xd29d, 0x66dd, 0x23ef, 0x9096, 0x0000, 0x0000, 0x0000, 0x0000, 0x3494, 0xb6c3, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x9e);
    poke(0x0003, 0x21);
    poke(0x3432, 0xf7);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd2ad, 0x66ee, 0x23ef, 0x9096, 0x0000, 0x0000, 0x0000, 0x0000, 0x3494, 0xb6c3, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(13362), equals(0xee));
  }, tags: 'undocumented');


  // Test instruction ddcb22
  test('ddcb22', () {
    // Set up machine initial state
    loadRegisters(0xfb5d, 0xe0d0, 0x7c02, 0xb4b7, 0x0000, 0x0000, 0x0000, 0x0000, 0xbd3f, 0x385b, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x43);
    poke(0x0003, 0x22);
    poke(0xbd82, 0x9f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xfb29, 0xe0d0, 0x3e02, 0xb4b7, 0x0000, 0x0000, 0x0000, 0x0000, 0xbd3f, 0x385b, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(48514), equals(0x3e));
  }, tags: 'undocumented');


  // Test instruction ddcb23
  test('ddcb23', () {
    // Set up machine initial state
    loadRegisters(0xc359, 0x68b6, 0xda84, 0xb990, 0x0000, 0x0000, 0x0000, 0x0000, 0x22dd, 0xbd27, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xc1);
    poke(0x0003, 0x23);
    poke(0x229e, 0xe0);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc385, 0x68b6, 0xdac0, 0xb990, 0x0000, 0x0000, 0x0000, 0x0000, 0x22dd, 0xbd27, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(8862), equals(0xc0));
  }, tags: 'undocumented');


  // Test instruction ddcb24
  test('ddcb24', () {
    // Set up machine initial state
    loadRegisters(0xbaf5, 0x7b0b, 0x560b, 0x7c33, 0x0000, 0x0000, 0x0000, 0x0000, 0x31f1, 0xddbd, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xe8);
    poke(0x0003, 0x24);
    poke(0x31d9, 0xc3);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xba81, 0x7b0b, 0x560b, 0x8633, 0x0000, 0x0000, 0x0000, 0x0000, 0x31f1, 0xddbd, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(12761), equals(0x86));
  }, tags: 'undocumented');


  // Test instruction ddcb25
  test('ddcb25', () {
    // Set up machine initial state
    loadRegisters(0x43bb, 0xa21b, 0x2347, 0xae4a, 0x0000, 0x0000, 0x0000, 0x0000, 0xcc63, 0xfc94, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xc1);
    poke(0x0003, 0x25);
    poke(0xcc24, 0xeb);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4381, 0xa21b, 0x2347, 0xaed6, 0x0000, 0x0000, 0x0000, 0x0000, 0xcc63, 0xfc94, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(52260), equals(0xd6));
  }, tags: 'undocumented');


  // Test instruction ddcb26
  test('ddcb26', () {
    // Set up machine initial state
    loadRegisters(0x2065, 0xff37, 0xe41f, 0x70e7, 0x0000, 0x0000, 0x0000, 0x0000, 0x6528, 0xa0d5, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xf7);
    poke(0x0003, 0x26);
    poke(0x651f, 0x89);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2005, 0xff37, 0xe41f, 0x70e7, 0x0000, 0x0000, 0x0000, 0x0000, 0x6528, 0xa0d5, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(25887), equals(0x12));
  });


  // Test instruction ddcb27
  test('ddcb27', () {
    // Set up machine initial state
    loadRegisters(0xa806, 0x5669, 0x1bee, 0xf62c, 0x0000, 0x0000, 0x0000, 0x0000, 0x1f69, 0x3418, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xc3);
    poke(0x0003, 0x27);
    poke(0x1f2c, 0xac);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5809, 0x5669, 0x1bee, 0xf62c, 0x0000, 0x0000, 0x0000, 0x0000, 0x1f69, 0x3418, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(7980), equals(0x58));
  }, tags: 'undocumented');


  // Test instruction ddcb28
  test('ddcb28', () {
    // Set up machine initial state
    loadRegisters(0x7afd, 0x64b8, 0x51f7, 0x7164, 0x0000, 0x0000, 0x0000, 0x0000, 0x999b, 0x8857, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xb6);
    poke(0x0003, 0x28);
    poke(0x9951, 0x24);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7a04, 0x12b8, 0x51f7, 0x7164, 0x0000, 0x0000, 0x0000, 0x0000, 0x999b, 0x8857, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(39249), equals(0x12));
  }, tags: 'undocumented');


  // Test instruction ddcb29
  test('ddcb29', () {
    // Set up machine initial state
    loadRegisters(0x0404, 0xb794, 0x323f, 0xfd34, 0x0000, 0x0000, 0x0000, 0x0000, 0x20e7, 0xc753, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x9c);
    poke(0x0003, 0x29);
    poke(0x2083, 0x82);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0480, 0xb7c1, 0x323f, 0xfd34, 0x0000, 0x0000, 0x0000, 0x0000, 0x20e7, 0xc753, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(8323), equals(0xc1));
  }, tags: 'undocumented');


  // Test instruction ddcb2a
  test('ddcb2a', () {
    // Set up machine initial state
    loadRegisters(0x4524, 0xafde, 0x0c08, 0x75d7, 0x0000, 0x0000, 0x0000, 0x0000, 0x9505, 0xb624, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xd8);
    poke(0x0003, 0x2a);
    poke(0x94dd, 0x7c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4528, 0xafde, 0x3e08, 0x75d7, 0x0000, 0x0000, 0x0000, 0x0000, 0x9505, 0xb624, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(38109), equals(0x3e));
  }, tags: 'undocumented');


  // Test instruction ddcb2b
  test('ddcb2b', () {
    // Set up machine initial state
    loadRegisters(0x8324, 0xe290, 0x26be, 0x7ddd, 0x0000, 0x0000, 0x0000, 0x0000, 0xb484, 0x571c, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xbd);
    poke(0x0003, 0x2b);
    poke(0xb441, 0x44);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8324, 0xe290, 0x2622, 0x7ddd, 0x0000, 0x0000, 0x0000, 0x0000, 0xb484, 0x571c, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(46145), equals(0x22));
  }, tags: 'undocumented');


  // Test instruction ddcb2c
  test('ddcb2c', () {
    // Set up machine initial state
    loadRegisters(0xc688, 0x0c94, 0x6e4b, 0x7dc7, 0x0000, 0x0000, 0x0000, 0x0000, 0xfe28, 0xdc80, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x2c);
    poke(0x0003, 0x2c);
    poke(0xfe54, 0x81);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc685, 0x0c94, 0x6e4b, 0xc0c7, 0x0000, 0x0000, 0x0000, 0x0000, 0xfe28, 0xdc80, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(65108), equals(0xc0));
  }, tags: 'undocumented');


  // Test instruction ddcb2d
  test('ddcb2d', () {
    // Set up machine initial state
    loadRegisters(0xce28, 0xd2ae, 0xc9be, 0x4236, 0x0000, 0x0000, 0x0000, 0x0000, 0xb4ed, 0x6de3, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x9b);
    poke(0x0003, 0x2d);
    poke(0xb488, 0x44);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xce24, 0xd2ae, 0xc9be, 0x4222, 0x0000, 0x0000, 0x0000, 0x0000, 0xb4ed, 0x6de3, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(46216), equals(0x22));
  }, tags: 'undocumented');


  // Test instruction ddcb2e
  test('ddcb2e', () {
    // Set up machine initial state
    loadRegisters(0x50b0, 0xde74, 0xeca8, 0x83ff, 0x0000, 0x0000, 0x0000, 0x0000, 0x69d8, 0x75c7, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x3d);
    poke(0x0003, 0x2e);
    poke(0x6a15, 0x05);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5001, 0xde74, 0xeca8, 0x83ff, 0x0000, 0x0000, 0x0000, 0x0000, 0x69d8, 0x75c7, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(27157), equals(0x02));
  });


  // Test instruction ddcb2f
  test('ddcb2f', () {
    // Set up machine initial state
    loadRegisters(0xaec6, 0x759b, 0x3059, 0x01b9, 0x0000, 0x0000, 0x0000, 0x0000, 0x7a30, 0xdd56, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xd3);
    poke(0x0003, 0x2f);
    poke(0x7a03, 0xf2);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf9ac, 0x759b, 0x3059, 0x01b9, 0x0000, 0x0000, 0x0000, 0x0000, 0x7a30, 0xdd56, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(31235), equals(0xf9));
  }, tags: 'undocumented');


  // Test instruction ddcb30
  test('ddcb30', () {
    // Set up machine initial state
    loadRegisters(0x3c89, 0x96ad, 0x9cc7, 0xa68c, 0x0000, 0x0000, 0x0000, 0x0000, 0xeee8, 0x5a80, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xdf);
    poke(0x0003, 0x30);
    poke(0xeec7, 0x32);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3c24, 0x65ad, 0x9cc7, 0xa68c, 0x0000, 0x0000, 0x0000, 0x0000, 0xeee8, 0x5a80, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(61127), equals(0x65));
  }, tags: 'undocumented');


  // Test instruction ddcb31
  test('ddcb31', () {
    // Set up machine initial state
    loadRegisters(0xebf5, 0x41e9, 0x929b, 0x7d47, 0x0000, 0x0000, 0x0000, 0x0000, 0xf22d, 0x8943, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x49);
    poke(0x0003, 0x31);
    poke(0xf276, 0xcd);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xeb89, 0x419b, 0x929b, 0x7d47, 0x0000, 0x0000, 0x0000, 0x0000, 0xf22d, 0x8943, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(62070), equals(0x9b));
  }, tags: 'undocumented');


  // Test instruction ddcb32
  test('ddcb32', () {
    // Set up machine initial state
    loadRegisters(0x9a1b, 0xaa64, 0x4209, 0x01ad, 0x0000, 0x0000, 0x0000, 0x0000, 0x579f, 0xec4c, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xe0);
    poke(0x0003, 0x32);
    poke(0x577f, 0xe2);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9a85, 0xaa64, 0xc509, 0x01ad, 0x0000, 0x0000, 0x0000, 0x0000, 0x579f, 0xec4c, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(22399), equals(0xc5));
  }, tags: 'undocumented');


  // Test instruction ddcb33
  test('ddcb33', () {
    // Set up machine initial state
    loadRegisters(0xb8b1, 0xb854, 0x524f, 0x9599, 0x0000, 0x0000, 0x0000, 0x0000, 0xefac, 0xd9ec, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xc9);
    poke(0x0003, 0x33);
    poke(0xef75, 0x0b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb804, 0xb854, 0x5217, 0x9599, 0x0000, 0x0000, 0x0000, 0x0000, 0xefac, 0xd9ec, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(61301), equals(0x17));
  }, tags: 'undocumented');


  // Test instruction ddcb34
  test('ddcb34', () {
    // Set up machine initial state
    loadRegisters(0xcd3c, 0x4432, 0x20d4, 0x0b3e, 0x0000, 0x0000, 0x0000, 0x0000, 0xab48, 0xc95f, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x49);
    poke(0x0003, 0x34);
    poke(0xab91, 0xef);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xcd89, 0x4432, 0x20d4, 0xdf3e, 0x0000, 0x0000, 0x0000, 0x0000, 0xab48, 0xc95f, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(43921), equals(0xdf));
  }, tags: 'undocumented');


  // Test instruction ddcb35
  test('ddcb35', () {
    // Set up machine initial state
    loadRegisters(0xdeb1, 0xc6fc, 0x696d, 0x150d, 0x0000, 0x0000, 0x0000, 0x0000, 0xeb1a, 0x4a12, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xb9);
    poke(0x0003, 0x35);
    poke(0xead3, 0x8f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xde09, 0xc6fc, 0x696d, 0x151f, 0x0000, 0x0000, 0x0000, 0x0000, 0xeb1a, 0x4a12, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(60115), equals(0x1f));
  }, tags: 'undocumented');


  // Test instruction ddcb36
  test('ddcb36', () {
    // Set up machine initial state
    loadRegisters(0x3d81, 0x443b, 0xff21, 0x63e3, 0x0000, 0x0000, 0x0000, 0x0000, 0x132e, 0xfb39, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xb4);
    poke(0x0003, 0x36);
    poke(0x12e2, 0x02);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3d04, 0x443b, 0xff21, 0x63e3, 0x0000, 0x0000, 0x0000, 0x0000, 0x132e, 0xfb39, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(4834), equals(0x05));
  }, tags: 'undocumented');


  // Test instruction ddcb37
  test('ddcb37', () {
    // Set up machine initial state
    loadRegisters(0x72d9, 0xbfc9, 0xa69a, 0xec0b, 0x0000, 0x0000, 0x0000, 0x0000, 0x5077, 0x4e3e, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xc6);
    poke(0x0003, 0x37);
    poke(0x503d, 0x3d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7b2c, 0xbfc9, 0xa69a, 0xec0b, 0x0000, 0x0000, 0x0000, 0x0000, 0x5077, 0x4e3e, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(20541), equals(0x7b));
  }, tags: 'undocumented');


  // Test instruction ddcb38
  test('ddcb38', () {
    // Set up machine initial state
    loadRegisters(0x3c64, 0xb1ee, 0x38e1, 0xae9f, 0x0000, 0x0000, 0x0000, 0x0000, 0xf695, 0x44b3, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x8e);
    poke(0x0003, 0x38);
    poke(0xf623, 0x5e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3c28, 0x2fee, 0x38e1, 0xae9f, 0x0000, 0x0000, 0x0000, 0x0000, 0xf695, 0x44b3, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(63011), equals(0x2f));
  }, tags: 'undocumented');


  // Test instruction ddcb39
  test('ddcb39', () {
    // Set up machine initial state
    loadRegisters(0x05d6, 0x9aad, 0xa2db, 0xdf75, 0x0000, 0x0000, 0x0000, 0x0000, 0xa895, 0xe243, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xdc);
    poke(0x0003, 0x39);
    poke(0xa871, 0x83);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0505, 0x9a41, 0xa2db, 0xdf75, 0x0000, 0x0000, 0x0000, 0x0000, 0xa895, 0xe243, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(43121), equals(0x41));
  }, tags: 'undocumented');


  // Test instruction ddcb3a
  test('ddcb3a', () {
    // Set up machine initial state
    loadRegisters(0x0e22, 0x0b9f, 0x873b, 0xc01d, 0x0000, 0x0000, 0x0000, 0x0000, 0x2591, 0x49c3, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x0d);
    poke(0x0003, 0x3a);
    poke(0x259e, 0x89);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0e05, 0x0b9f, 0x443b, 0xc01d, 0x0000, 0x0000, 0x0000, 0x0000, 0x2591, 0x49c3, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(9630), equals(0x44));
  }, tags: 'undocumented');


  // Test instruction ddcb3b
  test('ddcb3b', () {
    // Set up machine initial state
    loadRegisters(0x1bd9, 0xc795, 0xd8ae, 0x7ccf, 0x0000, 0x0000, 0x0000, 0x0000, 0x6fed, 0x09dc, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x20);
    poke(0x0003, 0x3b);
    poke(0x700d, 0xa9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1b01, 0xc795, 0xd854, 0x7ccf, 0x0000, 0x0000, 0x0000, 0x0000, 0x6fed, 0x09dc, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(28685), equals(0x54));
  }, tags: 'undocumented');


  // Test instruction ddcb3c
  test('ddcb3c', () {
    // Set up machine initial state
    loadRegisters(0xb651, 0xbdf7, 0xfca3, 0x7529, 0x0000, 0x0000, 0x0000, 0x0000, 0xf53b, 0x018b, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xe1);
    poke(0x0003, 0x3c);
    poke(0xf51c, 0xd0);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb628, 0xbdf7, 0xfca3, 0x6829, 0x0000, 0x0000, 0x0000, 0x0000, 0xf53b, 0x018b, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(62748), equals(0x68));
  }, tags: 'undocumented');


  // Test instruction ddcb3d
  test('ddcb3d', () {
    // Set up machine initial state
    loadRegisters(0x2a2d, 0x6e6e, 0xcfbd, 0x1db5, 0x0000, 0x0000, 0x0000, 0x0000, 0x0320, 0x6ab0, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xbe);
    poke(0x0003, 0x3d);
    poke(0x02de, 0x58);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2a28, 0x6e6e, 0xcfbd, 0x1d2c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0320, 0x6ab0, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(734), equals(0x2c));
  }, tags: 'undocumented');


  // Test instruction ddcb3e
  test('ddcb3e', () {
    // Set up machine initial state
    loadRegisters(0x39b8, 0xb26e, 0xb670, 0xb8a2, 0x0000, 0x0000, 0x0000, 0x0000, 0x784a, 0x7840, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x0a);
    poke(0x0003, 0x3e);
    poke(0x7854, 0x5d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x392d, 0xb26e, 0xb670, 0xb8a2, 0x0000, 0x0000, 0x0000, 0x0000, 0x784a, 0x7840, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(30804), equals(0x2e));
  });


  // Test instruction ddcb3f
  test('ddcb3f', () {
    // Set up machine initial state
    loadRegisters(0x2a17, 0x429d, 0xd8c0, 0xe069, 0x0000, 0x0000, 0x0000, 0x0000, 0x3488, 0x7150, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x31);
    poke(0x0003, 0x3f);
    poke(0x34b9, 0x04);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0200, 0x429d, 0xd8c0, 0xe069, 0x0000, 0x0000, 0x0000, 0x0000, 0x3488, 0x7150, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(13497), equals(0x02));
  }, tags: 'undocumented');


  // Test instruction ddcb40
  test('ddcb40', () {
    // Set up machine initial state
    loadRegisters(0x119b, 0xf6ba, 0x079e, 0x0e41, 0x0000, 0x0000, 0x0000, 0x0000, 0x8c01, 0xcd21, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xbd);
    poke(0x0003, 0x40);
    poke(0x8bbe, 0xe7);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1119, 0xf6ba, 0x079e, 0x0e41, 0x0000, 0x0000, 0x0000, 0x0000, 0x8c01, 0xcd21, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb41
  test('ddcb41', () {
    // Set up machine initial state
    loadRegisters(0x22b3, 0xc4b0, 0x575b, 0x66b4, 0x0000, 0x0000, 0x0000, 0x0000, 0xcdcf, 0xa25c, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x52);
    poke(0x0003, 0x41);
    poke(0xce21, 0x75);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2219, 0xc4b0, 0x575b, 0x66b4, 0x0000, 0x0000, 0x0000, 0x0000, 0xcdcf, 0xa25c, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb42
  test('ddcb42', () {
    // Set up machine initial state
    loadRegisters(0xaf5e, 0x7720, 0xaa95, 0x3b0a, 0x0000, 0x0000, 0x0000, 0x0000, 0xf03a, 0x856a, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x1e);
    poke(0x0003, 0x42);
    poke(0xf058, 0x90);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xaf74, 0x7720, 0xaa95, 0x3b0a, 0x0000, 0x0000, 0x0000, 0x0000, 0xf03a, 0x856a, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb43
  test('ddcb43', () {
    // Set up machine initial state
    loadRegisters(0x7fa6, 0xb699, 0x5e71, 0x1827, 0x0000, 0x0000, 0x0000, 0x0000, 0xe8b6, 0x96a8, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xbc);
    poke(0x0003, 0x43);
    poke(0xe872, 0x6b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7f38, 0xb699, 0x5e71, 0x1827, 0x0000, 0x0000, 0x0000, 0x0000, 0xe8b6, 0x96a8, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb44
  test('ddcb44', () {
    // Set up machine initial state
    loadRegisters(0x5faa, 0xde05, 0x12fd, 0xf73b, 0x0000, 0x0000, 0x0000, 0x0000, 0xee0a, 0x6634, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xe8);
    poke(0x0003, 0x44);
    poke(0xedf2, 0x62);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5f7c, 0xde05, 0x12fd, 0xf73b, 0x0000, 0x0000, 0x0000, 0x0000, 0xee0a, 0x6634, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb45
  test('ddcb45', () {
    // Set up machine initial state
    loadRegisters(0xeac7, 0x699c, 0x47d3, 0x89c3, 0x0000, 0x0000, 0x0000, 0x0000, 0xa2be, 0xd81e, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x02);
    poke(0x0003, 0x45);
    poke(0xa2c0, 0x55);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xea31, 0x699c, 0x47d3, 0x89c3, 0x0000, 0x0000, 0x0000, 0x0000, 0xa2be, 0xd81e, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb46
  test('ddcb46', () {
    // Set up machine initial state
    loadRegisters(0x60de, 0xac1d, 0x4173, 0xf92a, 0x0000, 0x0000, 0x0000, 0x0000, 0xa39f, 0x12e5, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xe2);
    poke(0x0003, 0x46);
    poke(0xa381, 0xd5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6030, 0xac1d, 0x4173, 0xf92a, 0x0000, 0x0000, 0x0000, 0x0000, 0xa39f, 0x12e5, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  });


  // Test instruction ddcb47
  test('ddcb47', () {
    // Set up machine initial state
    loadRegisters(0x1b1a, 0xf7c0, 0x22f6, 0x5253, 0x0000, 0x0000, 0x0000, 0x0000, 0x5227, 0x919d, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x7a);
    poke(0x0003, 0x47);
    poke(0x52a1, 0x6a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1b54, 0xf7c0, 0x22f6, 0x5253, 0x0000, 0x0000, 0x0000, 0x0000, 0x5227, 0x919d, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb48
  test('ddcb48', () {
    // Set up machine initial state
    loadRegisters(0x721a, 0x4509, 0xd68f, 0x3b3d, 0x0000, 0x0000, 0x0000, 0x0000, 0x2746, 0x7f97, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x13);
    poke(0x0003, 0x48);
    poke(0x2759, 0xa8);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7274, 0x4509, 0xd68f, 0x3b3d, 0x0000, 0x0000, 0x0000, 0x0000, 0x2746, 0x7f97, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb49
  test('ddcb49', () {
    // Set up machine initial state
    loadRegisters(0x7fe9, 0xda22, 0xea9c, 0xf480, 0x0000, 0x0000, 0x0000, 0x0000, 0x41c6, 0x75a9, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x94);
    poke(0x0003, 0x49);
    poke(0x415a, 0x26);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7f11, 0xda22, 0xea9c, 0xf480, 0x0000, 0x0000, 0x0000, 0x0000, 0x41c6, 0x75a9, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb4a
  test('ddcb4a', () {
    // Set up machine initial state
    loadRegisters(0xf16d, 0xe6c3, 0x5a42, 0x8b21, 0x0000, 0x0000, 0x0000, 0x0000, 0xbfeb, 0xe383, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x3b);
    poke(0x0003, 0x4a);
    poke(0xc026, 0xb5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf155, 0xe6c3, 0x5a42, 0x8b21, 0x0000, 0x0000, 0x0000, 0x0000, 0xbfeb, 0xe383, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb4b
  test('ddcb4b', () {
    // Set up machine initial state
    loadRegisters(0x1050, 0x880a, 0x52b2, 0xfb1b, 0x0000, 0x0000, 0x0000, 0x0000, 0xc239, 0x6b40, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xb0);
    poke(0x0003, 0x4b);
    poke(0xc1e9, 0x18);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1054, 0x880a, 0x52b2, 0xfb1b, 0x0000, 0x0000, 0x0000, 0x0000, 0xc239, 0x6b40, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb4c
  test('ddcb4c', () {
    // Set up machine initial state
    loadRegisters(0x0538, 0xbc63, 0xf081, 0x0a55, 0x0000, 0x0000, 0x0000, 0x0000, 0x874c, 0x80a3, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x97);
    poke(0x0003, 0x4c);
    poke(0x86e3, 0x63);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0510, 0xbc63, 0xf081, 0x0a55, 0x0000, 0x0000, 0x0000, 0x0000, 0x874c, 0x80a3, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb4d
  test('ddcb4d', () {
    // Set up machine initial state
    loadRegisters(0x7f8c, 0x32b4, 0x03d5, 0xef66, 0x0000, 0x0000, 0x0000, 0x0000, 0x7d2a, 0x03bc, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x15);
    poke(0x0003, 0x4d);
    poke(0x7d3f, 0x60);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7f7c, 0x32b4, 0x03d5, 0xef66, 0x0000, 0x0000, 0x0000, 0x0000, 0x7d2a, 0x03bc, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb4e
  test('ddcb4e', () {
    // Set up machine initial state
    loadRegisters(0x7c67, 0xfa92, 0xb4d0, 0x9f23, 0x0000, 0x0000, 0x0000, 0x0000, 0xeade, 0x1785, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xb0);
    poke(0x0003, 0x4e);
    poke(0xea8e, 0x3b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7c39, 0xfa92, 0xb4d0, 0x9f23, 0x0000, 0x0000, 0x0000, 0x0000, 0xeade, 0x1785, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  });


  // Test instruction ddcb4f
  test('ddcb4f', () {
    // Set up machine initial state
    loadRegisters(0x725c, 0x257b, 0xdb73, 0x2478, 0x0000, 0x0000, 0x0000, 0x0000, 0x88c0, 0xf151, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x8b);
    poke(0x0003, 0x4f);
    poke(0x884b, 0x4c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x725c, 0x257b, 0xdb73, 0x2478, 0x0000, 0x0000, 0x0000, 0x0000, 0x88c0, 0xf151, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb50
  test('ddcb50', () {
    // Set up machine initial state
    loadRegisters(0x35f4, 0x8e51, 0x406c, 0x2e3c, 0x0000, 0x0000, 0x0000, 0x0000, 0xdaf2, 0x413c, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x12);
    poke(0x0003, 0x50);
    poke(0xdb04, 0x00);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x355c, 0x8e51, 0x406c, 0x2e3c, 0x0000, 0x0000, 0x0000, 0x0000, 0xdaf2, 0x413c, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb51
  test('ddcb51', () {
    // Set up machine initial state
    loadRegisters(0xa630, 0xba85, 0xc88c, 0xe86c, 0x0000, 0x0000, 0x0000, 0x0000, 0x84b2, 0xcd8e, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x18);
    poke(0x0003, 0x51);
    poke(0x84ca, 0x1c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa610, 0xba85, 0xc88c, 0xe86c, 0x0000, 0x0000, 0x0000, 0x0000, 0x84b2, 0xcd8e, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb52
  test('ddcb52', () {
    // Set up machine initial state
    loadRegisters(0xcb88, 0x1220, 0x1103, 0xa868, 0x0000, 0x0000, 0x0000, 0x0000, 0x6156, 0xcfac, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x42);
    poke(0x0003, 0x52);
    poke(0x6198, 0x53);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xcb74, 0x1220, 0x1103, 0xa868, 0x0000, 0x0000, 0x0000, 0x0000, 0x6156, 0xcfac, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb53
  test('ddcb53', () {
    // Set up machine initial state
    loadRegisters(0x5eb3, 0x569e, 0xf76d, 0x88c6, 0x0000, 0x0000, 0x0000, 0x0000, 0xae45, 0x623e, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xe3);
    poke(0x0003, 0x53);
    poke(0xae28, 0xd6);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5e39, 0x569e, 0xf76d, 0x88c6, 0x0000, 0x0000, 0x0000, 0x0000, 0xae45, 0x623e, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb54
  test('ddcb54', () {
    // Set up machine initial state
    loadRegisters(0xc3c9, 0x76fe, 0xf1ff, 0x416e, 0x0000, 0x0000, 0x0000, 0x0000, 0xefd5, 0x7576, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x7d);
    poke(0x0003, 0x54);
    poke(0xf052, 0x5d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc331, 0x76fe, 0xf1ff, 0x416e, 0x0000, 0x0000, 0x0000, 0x0000, 0xefd5, 0x7576, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb55
  test('ddcb55', () {
    // Set up machine initial state
    loadRegisters(0x7068, 0xdcd0, 0x8345, 0xd498, 0x0000, 0x0000, 0x0000, 0x0000, 0xf352, 0xa88b, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x88);
    poke(0x0003, 0x55);
    poke(0xf2da, 0x03);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7074, 0xdcd0, 0x8345, 0xd498, 0x0000, 0x0000, 0x0000, 0x0000, 0xf352, 0xa88b, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb56
  test('ddcb56', () {
    // Set up machine initial state
    loadRegisters(0x9128, 0x2cb8, 0x571c, 0xf4fd, 0x0000, 0x0000, 0x0000, 0x0000, 0x6d30, 0xaec2, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x57);
    poke(0x0003, 0x56);
    poke(0x6d87, 0x61);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x917c, 0x2cb8, 0x571c, 0xf4fd, 0x0000, 0x0000, 0x0000, 0x0000, 0x6d30, 0xaec2, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  });


  // Test instruction ddcb57
  test('ddcb57', () {
    // Set up machine initial state
    loadRegisters(0x3ca7, 0x541a, 0x027c, 0xc0b4, 0x0000, 0x0000, 0x0000, 0x0000, 0x5833, 0x160a, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x06);
    poke(0x0003, 0x57);
    poke(0x5839, 0x1d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3c19, 0x541a, 0x027c, 0xc0b4, 0x0000, 0x0000, 0x0000, 0x0000, 0x5833, 0x160a, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb58
  test('ddcb58', () {
    // Set up machine initial state
    loadRegisters(0xc650, 0xe1a8, 0x9d6c, 0xbec3, 0x0000, 0x0000, 0x0000, 0x0000, 0x6a46, 0xb66c, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x83);
    poke(0x0003, 0x58);
    poke(0x69c9, 0x0f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc638, 0xe1a8, 0x9d6c, 0xbec3, 0x0000, 0x0000, 0x0000, 0x0000, 0x6a46, 0xb66c, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb59
  test('ddcb59', () {
    // Set up machine initial state
    loadRegisters(0xad07, 0x9bda, 0xb7ee, 0x63c4, 0x0000, 0x0000, 0x0000, 0x0000, 0x9195, 0x9703, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xdb);
    poke(0x0003, 0x59);
    poke(0x9170, 0x10);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xad55, 0x9bda, 0xb7ee, 0x63c4, 0x0000, 0x0000, 0x0000, 0x0000, 0x9195, 0x9703, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb5a
  test('ddcb5a', () {
    // Set up machine initial state
    loadRegisters(0x80c0, 0x5105, 0x36b0, 0xa37c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0de0, 0xce7f, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xd1);
    poke(0x0003, 0x5a);
    poke(0x0db1, 0xbe);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8018, 0x5105, 0x36b0, 0xa37c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0de0, 0xce7f, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb5b
  test('ddcb5b', () {
    // Set up machine initial state
    loadRegisters(0x2a8d, 0x083d, 0x1409, 0x06ba, 0x0000, 0x0000, 0x0000, 0x0000, 0x62ad, 0xbaff, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xd5);
    poke(0x0003, 0x5b);
    poke(0x6282, 0x67);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2a75, 0x083d, 0x1409, 0x06ba, 0x0000, 0x0000, 0x0000, 0x0000, 0x62ad, 0xbaff, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb5c
  test('ddcb5c', () {
    // Set up machine initial state
    loadRegisters(0x4ca4, 0xe502, 0xd23c, 0x6da8, 0x0000, 0x0000, 0x0000, 0x0000, 0x9dc6, 0x6f04, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x5c);
    poke(0x0003, 0x5c);
    poke(0x9e22, 0xc9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4c18, 0xe502, 0xd23c, 0x6da8, 0x0000, 0x0000, 0x0000, 0x0000, 0x9dc6, 0x6f04, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb5d
  test('ddcb5d', () {
    // Set up machine initial state
    loadRegisters(0x7e39, 0x511b, 0x3cfa, 0x60d3, 0x0000, 0x0000, 0x0000, 0x0000, 0xd193, 0x3fe9, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xff);
    poke(0x0003, 0x5d);
    poke(0xd192, 0x0d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7e11, 0x511b, 0x3cfa, 0x60d3, 0x0000, 0x0000, 0x0000, 0x0000, 0xd193, 0x3fe9, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb5e
  test('ddcb5e', () {
    // Set up machine initial state
    loadRegisters(0xcef1, 0x0235, 0xe2b1, 0x7a4c, 0x0000, 0x0000, 0x0000, 0x0000, 0xed14, 0xd0d6, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x62);
    poke(0x0003, 0x5e);
    poke(0xed76, 0xa7);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xce7d, 0x0235, 0xe2b1, 0x7a4c, 0x0000, 0x0000, 0x0000, 0x0000, 0xed14, 0xd0d6, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  });


  // Test instruction ddcb5f
  test('ddcb5f', () {
    // Set up machine initial state
    loadRegisters(0x094f, 0x20a8, 0x52e1, 0xd783, 0x0000, 0x0000, 0x0000, 0x0000, 0xdf46, 0xda41, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x3f);
    poke(0x0003, 0x5f);
    poke(0xdf85, 0x9e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0919, 0x20a8, 0x52e1, 0xd783, 0x0000, 0x0000, 0x0000, 0x0000, 0xdf46, 0xda41, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb60
  test('ddcb60', () {
    // Set up machine initial state
    loadRegisters(0x42ce, 0x0713, 0xdc90, 0x2c89, 0x0000, 0x0000, 0x0000, 0x0000, 0x32a2, 0xc4d4, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x65);
    poke(0x0003, 0x60);
    poke(0x3307, 0x2e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4274, 0x0713, 0xdc90, 0x2c89, 0x0000, 0x0000, 0x0000, 0x0000, 0x32a2, 0xc4d4, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb61
  test('ddcb61', () {
    // Set up machine initial state
    loadRegisters(0x1b36, 0x1403, 0x8b9b, 0xc221, 0x0000, 0x0000, 0x0000, 0x0000, 0x36cb, 0x93d4, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xa8);
    poke(0x0003, 0x61);
    poke(0x3673, 0xbc);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1b30, 0x1403, 0x8b9b, 0xc221, 0x0000, 0x0000, 0x0000, 0x0000, 0x36cb, 0x93d4, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb62
  test('ddcb62', () {
    // Set up machine initial state
    loadRegisters(0x361b, 0x4055, 0x650a, 0x3f98, 0x0000, 0x0000, 0x0000, 0x0000, 0x0acc, 0xa102, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xd9);
    poke(0x0003, 0x62);
    poke(0x0aa5, 0xea);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x365d, 0x4055, 0x650a, 0x3f98, 0x0000, 0x0000, 0x0000, 0x0000, 0x0acc, 0xa102, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb63
  test('ddcb63', () {
    // Set up machine initial state
    loadRegisters(0x6548, 0x08df, 0x3ceb, 0x6d24, 0x0000, 0x0000, 0x0000, 0x0000, 0xe679, 0xf98e, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x79);
    poke(0x0003, 0x63);
    poke(0xe6f2, 0x83);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6574, 0x08df, 0x3ceb, 0x6d24, 0x0000, 0x0000, 0x0000, 0x0000, 0xe679, 0xf98e, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb64
  test('ddcb64', () {
    // Set up machine initial state
    loadRegisters(0x3c22, 0xe2a7, 0x6da9, 0xc346, 0x0000, 0x0000, 0x0000, 0x0000, 0xecfb, 0x85b6, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x71);
    poke(0x0003, 0x64);
    poke(0xed6c, 0x52);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3c38, 0xe2a7, 0x6da9, 0xc346, 0x0000, 0x0000, 0x0000, 0x0000, 0xecfb, 0x85b6, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb65
  test('ddcb65', () {
    // Set up machine initial state
    loadRegisters(0x09bd, 0x0abb, 0x3afa, 0x91f5, 0x0000, 0x0000, 0x0000, 0x0000, 0x7779, 0xaef5, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x67);
    poke(0x0003, 0x65);
    poke(0x77e0, 0xf5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0931, 0x0abb, 0x3afa, 0x91f5, 0x0000, 0x0000, 0x0000, 0x0000, 0x7779, 0xaef5, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb66
  test('ddcb66', () {
    // Set up machine initial state
    loadRegisters(0xccbc, 0xd301, 0x9b66, 0x40fb, 0x0000, 0x0000, 0x0000, 0x0000, 0xee15, 0x0d23, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x63);
    poke(0x0003, 0x66);
    poke(0xee78, 0x70);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xcc38, 0xd301, 0x9b66, 0x40fb, 0x0000, 0x0000, 0x0000, 0x0000, 0xee15, 0x0d23, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  });


  // Test instruction ddcb67
  test('ddcb67', () {
    // Set up machine initial state
    loadRegisters(0xeccb, 0x342f, 0xbe3e, 0xa79b, 0x0000, 0x0000, 0x0000, 0x0000, 0xeea1, 0xdfae, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xd7);
    poke(0x0003, 0x67);
    poke(0xee78, 0x06);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xec7d, 0x342f, 0xbe3e, 0xa79b, 0x0000, 0x0000, 0x0000, 0x0000, 0xeea1, 0xdfae, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb68
  test('ddcb68', () {
    // Set up machine initial state
    loadRegisters(0x8e51, 0x0063, 0x49ad, 0xb7d4, 0x0000, 0x0000, 0x0000, 0x0000, 0xe968, 0x864e, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xb1);
    poke(0x0003, 0x68);
    poke(0xe919, 0x20);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8e39, 0x0063, 0x49ad, 0xb7d4, 0x0000, 0x0000, 0x0000, 0x0000, 0xe968, 0x864e, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb69
  test('ddcb69', () {
    // Set up machine initial state
    loadRegisters(0x9f11, 0x42b5, 0x74fe, 0x1116, 0x0000, 0x0000, 0x0000, 0x0000, 0x33f4, 0x46c2, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xe8);
    poke(0x0003, 0x69);
    poke(0x33dc, 0x4f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9f75, 0x42b5, 0x74fe, 0x1116, 0x0000, 0x0000, 0x0000, 0x0000, 0x33f4, 0x46c2, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb6a
  test('ddcb6a', () {
    // Set up machine initial state
    loadRegisters(0x4632, 0x0bd8, 0x0018, 0x1ac3, 0x0000, 0x0000, 0x0000, 0x0000, 0x86b6, 0x1dd2, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x33);
    poke(0x0003, 0x6a);
    poke(0x86e9, 0x1c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4654, 0x0bd8, 0x0018, 0x1ac3, 0x0000, 0x0000, 0x0000, 0x0000, 0x86b6, 0x1dd2, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb6b
  test('ddcb6b', () {
    // Set up machine initial state
    loadRegisters(0x7a76, 0xf79f, 0xa78e, 0xf867, 0x0000, 0x0000, 0x0000, 0x0000, 0x187b, 0x0023, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x11);
    poke(0x0003, 0x6b);
    poke(0x188c, 0xbc);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7a18, 0xf79f, 0xa78e, 0xf867, 0x0000, 0x0000, 0x0000, 0x0000, 0x187b, 0x0023, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb6c
  test('ddcb6c', () {
    // Set up machine initial state
    loadRegisters(0xdd91, 0x1f1e, 0xc1e1, 0x0ea7, 0x0000, 0x0000, 0x0000, 0x0000, 0x3e21, 0xf544, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x5e);
    poke(0x0003, 0x6c);
    poke(0x3e7f, 0x2a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xdd39, 0x1f1e, 0xc1e1, 0x0ea7, 0x0000, 0x0000, 0x0000, 0x0000, 0x3e21, 0xf544, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb6d
  test('ddcb6d', () {
    // Set up machine initial state
    loadRegisters(0xdebf, 0x9ae4, 0xfd24, 0xb3c2, 0x0000, 0x0000, 0x0000, 0x0000, 0xe314, 0xad84, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xdd);
    poke(0x0003, 0x6d);
    poke(0xe2f1, 0x41);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xde75, 0x9ae4, 0xfd24, 0xb3c2, 0x0000, 0x0000, 0x0000, 0x0000, 0xe314, 0xad84, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb6e
  test('ddcb6e', () {
    // Set up machine initial state
    loadRegisters(0xca75, 0x9f16, 0xc700, 0x1dce, 0x0000, 0x0000, 0x0000, 0x0000, 0x3086, 0xd68e, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xb2);
    poke(0x0003, 0x6e);
    poke(0x3038, 0x3f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xca31, 0x9f16, 0xc700, 0x1dce, 0x0000, 0x0000, 0x0000, 0x0000, 0x3086, 0xd68e, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  });


  // Test instruction ddcb6f
  test('ddcb6f', () {
    // Set up machine initial state
    loadRegisters(0xd4cd, 0x0b39, 0x3e2e, 0xc06e, 0x0000, 0x0000, 0x0000, 0x0000, 0xfc1b, 0xd592, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xbe);
    poke(0x0003, 0x6f);
    poke(0xfbd9, 0x56);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd47d, 0x0b39, 0x3e2e, 0xc06e, 0x0000, 0x0000, 0x0000, 0x0000, 0xfc1b, 0xd592, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb70
  test('ddcb70', () {
    // Set up machine initial state
    loadRegisters(0xf901, 0x09b8, 0x43f8, 0x2a76, 0x0000, 0x0000, 0x0000, 0x0000, 0x042c, 0x7f2d, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xb5);
    poke(0x0003, 0x70);
    poke(0x03e1, 0x74);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf911, 0x09b8, 0x43f8, 0x2a76, 0x0000, 0x0000, 0x0000, 0x0000, 0x042c, 0x7f2d, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb71
  test('ddcb71', () {
    // Set up machine initial state
    loadRegisters(0xac78, 0x36ad, 0x34cb, 0xf950, 0x0000, 0x0000, 0x0000, 0x0000, 0x1b33, 0xaa23, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xf7);
    poke(0x0003, 0x71);
    poke(0x1b2a, 0x08);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xac5c, 0x36ad, 0x34cb, 0xf950, 0x0000, 0x0000, 0x0000, 0x0000, 0x1b33, 0xaa23, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb72
  test('ddcb72', () {
    // Set up machine initial state
    loadRegisters(0xb1b3, 0xf1e4, 0x9984, 0xc7fb, 0x0000, 0x0000, 0x0000, 0x0000, 0xce25, 0xc5b6, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x22);
    poke(0x0003, 0x72);
    poke(0xce47, 0x08);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb15d, 0xf1e4, 0x9984, 0xc7fb, 0x0000, 0x0000, 0x0000, 0x0000, 0xce25, 0xc5b6, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb73
  test('ddcb73', () {
    // Set up machine initial state
    loadRegisters(0x21ba, 0x592d, 0xf406, 0xe21f, 0x0000, 0x0000, 0x0000, 0x0000, 0x6442, 0xcf58, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x12);
    poke(0x0003, 0x73);
    poke(0x6454, 0x3c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2174, 0x592d, 0xf406, 0xe21f, 0x0000, 0x0000, 0x0000, 0x0000, 0x6442, 0xcf58, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb74
  test('ddcb74', () {
    // Set up machine initial state
    loadRegisters(0x6642, 0x64c1, 0xdbe5, 0xeb48, 0x0000, 0x0000, 0x0000, 0x0000, 0x7dc1, 0xc1fb, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x08);
    poke(0x0003, 0x74);
    poke(0x7dc9, 0xbe);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x667c, 0x64c1, 0xdbe5, 0xeb48, 0x0000, 0x0000, 0x0000, 0x0000, 0x7dc1, 0xc1fb, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb75
  test('ddcb75', () {
    // Set up machine initial state
    loadRegisters(0x8778, 0x580e, 0x00dd, 0xf4c6, 0x0000, 0x0000, 0x0000, 0x0000, 0x60ad, 0x9b60, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x5b);
    poke(0x0003, 0x75);
    poke(0x6108, 0xcf);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8730, 0x580e, 0x00dd, 0xf4c6, 0x0000, 0x0000, 0x0000, 0x0000, 0x60ad, 0x9b60, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb76
  test('ddcb76', () {
    // Set up machine initial state
    loadRegisters(0x65b8, 0x5cc2, 0x3058, 0xe258, 0x0000, 0x0000, 0x0000, 0x0000, 0x7e8a, 0xb296, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x73);
    poke(0x0003, 0x76);
    poke(0x7efd, 0x1e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x657c, 0x5cc2, 0x3058, 0xe258, 0x0000, 0x0000, 0x0000, 0x0000, 0x7e8a, 0xb296, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  });


  // Test instruction ddcb77
  test('ddcb77', () {
    // Set up machine initial state
    loadRegisters(0xe3a8, 0x47a0, 0xc510, 0xcf0a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0537, 0xb242, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x7f);
    poke(0x0003, 0x77);
    poke(0x05b6, 0x97);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe354, 0x47a0, 0xc510, 0xcf0a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0537, 0xb242, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb78
  test('ddcb78', () {
    // Set up machine initial state
    loadRegisters(0x424f, 0x24f6, 0x1632, 0x8a4f, 0x0000, 0x0000, 0x0000, 0x0000, 0x9397, 0x846c, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x70);
    poke(0x0003, 0x78);
    poke(0x9407, 0x76);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4255, 0x24f6, 0x1632, 0x8a4f, 0x0000, 0x0000, 0x0000, 0x0000, 0x9397, 0x846c, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb79
  test('ddcb79', () {
    // Set up machine initial state
    loadRegisters(0xe6a0, 0xeeaa, 0x41f7, 0x5da2, 0x0000, 0x0000, 0x0000, 0x0000, 0x41de, 0x4189, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xc3);
    poke(0x0003, 0x79);
    poke(0x41a1, 0xb8);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe690, 0xeeaa, 0x41f7, 0x5da2, 0x0000, 0x0000, 0x0000, 0x0000, 0x41de, 0x4189, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb7a
  test('ddcb7a', () {
    // Set up machine initial state
    loadRegisters(0xcabf, 0x56aa, 0x6a06, 0x6cd7, 0x0000, 0x0000, 0x0000, 0x0000, 0x0aa9, 0x9812, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x3f);
    poke(0x0003, 0x7a);
    poke(0x0ae8, 0xeb);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xca99, 0x56aa, 0x6a06, 0x6cd7, 0x0000, 0x0000, 0x0000, 0x0000, 0x0aa9, 0x9812, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb7b
  test('ddcb7b', () {
    // Set up machine initial state
    loadRegisters(0xae3f, 0x0227, 0x721f, 0x52a1, 0x0000, 0x0000, 0x0000, 0x0000, 0x5040, 0xb98a, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x88);
    poke(0x0003, 0x7b);
    poke(0x4fc8, 0x22);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xae5d, 0x0227, 0x721f, 0x52a1, 0x0000, 0x0000, 0x0000, 0x0000, 0x5040, 0xb98a, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb7c
  test('ddcb7c', () {
    // Set up machine initial state
    loadRegisters(0x8a80, 0xa2f1, 0x239a, 0xd5cc, 0x0000, 0x0000, 0x0000, 0x0000, 0x6883, 0xb050, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x9e);
    poke(0x0003, 0x7c);
    poke(0x6821, 0x3a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8a7c, 0xa2f1, 0x239a, 0xd5cc, 0x0000, 0x0000, 0x0000, 0x0000, 0x6883, 0xb050, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb7d
  test('ddcb7d', () {
    // Set up machine initial state
    loadRegisters(0xc37f, 0xcf33, 0x1010, 0x98e6, 0x0000, 0x0000, 0x0000, 0x0000, 0xb021, 0x0356, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x29);
    poke(0x0003, 0x7d);
    poke(0xb04a, 0x2c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc375, 0xcf33, 0x1010, 0x98e6, 0x0000, 0x0000, 0x0000, 0x0000, 0xb021, 0x0356, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb7e
  test('ddcb7e', () {
    // Set up machine initial state
    loadRegisters(0x9a25, 0x2f6e, 0x0d0d, 0xa83f, 0x0000, 0x0000, 0x0000, 0x0000, 0xcef0, 0x8c15, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x4f);
    poke(0x0003, 0x7e);
    poke(0xcf3f, 0xf2);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9a99, 0x2f6e, 0x0d0d, 0xa83f, 0x0000, 0x0000, 0x0000, 0x0000, 0xcef0, 0x8c15, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  });


  // Test instruction ddcb7f
  test('ddcb7f', () {
    // Set up machine initial state
    loadRegisters(0x53b9, 0x1f4e, 0x4837, 0x21b6, 0x0000, 0x0000, 0x0000, 0x0000, 0x5ec2, 0x80c3, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x75);
    poke(0x0003, 0x7f);
    poke(0x5f37, 0xa2);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5399, 0x1f4e, 0x4837, 0x21b6, 0x0000, 0x0000, 0x0000, 0x0000, 0x5ec2, 0x80c3, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction ddcb80
  test('ddcb80', () {
    // Set up machine initial state
    loadRegisters(0x6319, 0xbaf9, 0xc84b, 0xbcf2, 0x0000, 0x0000, 0x0000, 0x0000, 0xacc5, 0xa4ed, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x70);
    poke(0x0003, 0x80);
    poke(0xad35, 0x30);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6319, 0x30f9, 0xc84b, 0xbcf2, 0x0000, 0x0000, 0x0000, 0x0000, 0xacc5, 0xa4ed, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcb81
  test('ddcb81', () {
    // Set up machine initial state
    loadRegisters(0xfae1, 0x5ae5, 0x9502, 0xdc9b, 0x0000, 0x0000, 0x0000, 0x0000, 0xbdd3, 0x1a52, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x2a);
    poke(0x0003, 0x81);
    poke(0xbdfd, 0x24);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xfae1, 0x5a24, 0x9502, 0xdc9b, 0x0000, 0x0000, 0x0000, 0x0000, 0xbdd3, 0x1a52, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcb82
  test('ddcb82', () {
    // Set up machine initial state
    loadRegisters(0xdaf6, 0x3260, 0xf1ac, 0x1d47, 0x0000, 0x0000, 0x0000, 0x0000, 0x5e74, 0x35e2, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x9a);
    poke(0x0003, 0x82);
    poke(0x5e0e, 0x51);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xdaf6, 0x3260, 0x50ac, 0x1d47, 0x0000, 0x0000, 0x0000, 0x0000, 0x5e74, 0x35e2, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(24078), equals(0x50));
  }, tags: 'undocumented');


  // Test instruction ddcb83
  test('ddcb83', () {
    // Set up machine initial state
    loadRegisters(0x8e7c, 0x5586, 0x8c92, 0xfb00, 0x0000, 0x0000, 0x0000, 0x0000, 0x3441, 0xd365, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x0e);
    poke(0x0003, 0x83);
    poke(0x344f, 0x01);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8e7c, 0x5586, 0x8c00, 0xfb00, 0x0000, 0x0000, 0x0000, 0x0000, 0x3441, 0xd365, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(13391), equals(0x00));
  }, tags: 'undocumented');


  // Test instruction ddcb84
  test('ddcb84', () {
    // Set up machine initial state
    loadRegisters(0xc1b3, 0x4874, 0xc535, 0x0e1c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0123, 0xdd28, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x47);
    poke(0x0003, 0x84);
    poke(0x016a, 0xb0);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc1b3, 0x4874, 0xc535, 0xb01c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0123, 0xdd28, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcb85
  test('ddcb85', () {
    // Set up machine initial state
    loadRegisters(0x0928, 0xb0db, 0x4e07, 0xa7b7, 0x0000, 0x0000, 0x0000, 0x0000, 0x0ba3, 0xc61c, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x6c);
    poke(0x0003, 0x85);
    poke(0x0c0f, 0xde);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0928, 0xb0db, 0x4e07, 0xa7de, 0x0000, 0x0000, 0x0000, 0x0000, 0x0ba3, 0xc61c, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcb86
  test('ddcb86', () {
    // Set up machine initial state
    loadRegisters(0x4515, 0xde09, 0x3ce7, 0x1fde, 0x0000, 0x0000, 0x0000, 0x0000, 0x10c5, 0x33ed, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x5c);
    poke(0x0003, 0x86);
    poke(0x1121, 0x7c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4515, 0xde09, 0x3ce7, 0x1fde, 0x0000, 0x0000, 0x0000, 0x0000, 0x10c5, 0x33ed, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  });


  // Test instruction ddcb87
  test('ddcb87', () {
    // Set up machine initial state
    loadRegisters(0xd05e, 0xa733, 0xd1dd, 0x1603, 0x0000, 0x0000, 0x0000, 0x0000, 0xede6, 0xe5fb, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x02);
    poke(0x0003, 0x87);
    poke(0xede8, 0xc4);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc45e, 0xa733, 0xd1dd, 0x1603, 0x0000, 0x0000, 0x0000, 0x0000, 0xede6, 0xe5fb, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcb88
  test('ddcb88', () {
    // Set up machine initial state
    loadRegisters(0xe4fa, 0x3325, 0xc266, 0x1b13, 0x0000, 0x0000, 0x0000, 0x0000, 0x878e, 0xe695, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x9b);
    poke(0x0003, 0x88);
    poke(0x8729, 0x7c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe4fa, 0x7c25, 0xc266, 0x1b13, 0x0000, 0x0000, 0x0000, 0x0000, 0x878e, 0xe695, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcb89
  test('ddcb89', () {
    // Set up machine initial state
    loadRegisters(0x933b, 0x6fdd, 0xa3a8, 0x2634, 0x0000, 0x0000, 0x0000, 0x0000, 0x8f3e, 0x7727, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x2b);
    poke(0x0003, 0x89);
    poke(0x8f69, 0xcf);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x933b, 0x6fcd, 0xa3a8, 0x2634, 0x0000, 0x0000, 0x0000, 0x0000, 0x8f3e, 0x7727, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(36713), equals(0xcd));
  }, tags: 'undocumented');


  // Test instruction ddcb8a
  test('ddcb8a', () {
    // Set up machine initial state
    loadRegisters(0x6759, 0xad1e, 0x5d71, 0xce52, 0x0000, 0x0000, 0x0000, 0x0000, 0x39a9, 0x38a0, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x0a);
    poke(0x0003, 0x8a);
    poke(0x39b3, 0xea);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6759, 0xad1e, 0xe871, 0xce52, 0x0000, 0x0000, 0x0000, 0x0000, 0x39a9, 0x38a0, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(14771), equals(0xe8));
  }, tags: 'undocumented');


  // Test instruction ddcb8b
  test('ddcb8b', () {
    // Set up machine initial state
    loadRegisters(0x3da2, 0x1833, 0x03c1, 0x07e9, 0x0000, 0x0000, 0x0000, 0x0000, 0x1685, 0xd790, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x62);
    poke(0x0003, 0x8b);
    poke(0x16e7, 0x8a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3da2, 0x1833, 0x0388, 0x07e9, 0x0000, 0x0000, 0x0000, 0x0000, 0x1685, 0xd790, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(5863), equals(0x88));
  }, tags: 'undocumented');


  // Test instruction ddcb8c
  test('ddcb8c', () {
    // Set up machine initial state
    loadRegisters(0xa625, 0xed31, 0x3946, 0x32dc, 0x0000, 0x0000, 0x0000, 0x0000, 0xc6a2, 0x7ad6, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xe8);
    poke(0x0003, 0x8c);
    poke(0xc68a, 0x3e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa625, 0xed31, 0x3946, 0x3cdc, 0x0000, 0x0000, 0x0000, 0x0000, 0xc6a2, 0x7ad6, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(50826), equals(0x3c));
  }, tags: 'undocumented');


  // Test instruction ddcb8d
  test('ddcb8d', () {
    // Set up machine initial state
    loadRegisters(0x016b, 0x5802, 0xa683, 0x2549, 0x0000, 0x0000, 0x0000, 0x0000, 0x22e6, 0x33bb, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xcc);
    poke(0x0003, 0x8d);
    poke(0x22b2, 0x9e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x016b, 0x5802, 0xa683, 0x259c, 0x0000, 0x0000, 0x0000, 0x0000, 0x22e6, 0x33bb, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(8882), equals(0x9c));
  }, tags: 'undocumented');


  // Test instruction ddcb8e
  test('ddcb8e', () {
    // Set up machine initial state
    loadRegisters(0xf4f4, 0xf3a8, 0x2843, 0x82cb, 0x0000, 0x0000, 0x0000, 0x0000, 0xd2e8, 0xd367, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x0a);
    poke(0x0003, 0x8e);
    poke(0xd2f2, 0x03);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf4f4, 0xf3a8, 0x2843, 0x82cb, 0x0000, 0x0000, 0x0000, 0x0000, 0xd2e8, 0xd367, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(54002), equals(0x01));
  });


  // Test instruction ddcb8f
  test('ddcb8f', () {
    // Set up machine initial state
    loadRegisters(0x6b1a, 0x8ae2, 0x269b, 0xcb2f, 0x0000, 0x0000, 0x0000, 0x0000, 0x3ffe, 0x75dd, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x7b);
    poke(0x0003, 0x8f);
    poke(0x4079, 0x96);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x941a, 0x8ae2, 0x269b, 0xcb2f, 0x0000, 0x0000, 0x0000, 0x0000, 0x3ffe, 0x75dd, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(16505), equals(0x94));
  }, tags: 'undocumented');


  // Test instruction ddcb90
  test('ddcb90', () {
    // Set up machine initial state
    loadRegisters(0xc167, 0x3dfc, 0x42e7, 0x9e14, 0x0000, 0x0000, 0x0000, 0x0000, 0xb501, 0x84fe, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x04);
    poke(0x0003, 0x90);
    poke(0xb505, 0x46);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc167, 0x42fc, 0x42e7, 0x9e14, 0x0000, 0x0000, 0x0000, 0x0000, 0xb501, 0x84fe, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(46341), equals(0x42));
  }, tags: 'undocumented');


  // Test instruction ddcb91
  test('ddcb91', () {
    // Set up machine initial state
    loadRegisters(0xe85e, 0xcc89, 0xd249, 0xea3b, 0x0000, 0x0000, 0x0000, 0x0000, 0xc987, 0xc4d1, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x11);
    poke(0x0003, 0x91);
    poke(0xc998, 0x83);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe85e, 0xcc83, 0xd249, 0xea3b, 0x0000, 0x0000, 0x0000, 0x0000, 0xc987, 0xc4d1, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcb92
  test('ddcb92', () {
    // Set up machine initial state
    loadRegisters(0x28a3, 0x85ff, 0xab28, 0x47a5, 0x0000, 0x0000, 0x0000, 0x0000, 0x9166, 0xe755, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x4b);
    poke(0x0003, 0x92);
    poke(0x91b1, 0xaa);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x28a3, 0x85ff, 0xaa28, 0x47a5, 0x0000, 0x0000, 0x0000, 0x0000, 0x9166, 0xe755, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcb93
  test('ddcb93', () {
    // Set up machine initial state
    loadRegisters(0x58ac, 0xc88b, 0x6d24, 0xdbdd, 0x0000, 0x0000, 0x0000, 0x0000, 0xac2e, 0x5199, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x03);
    poke(0x0003, 0x93);
    poke(0xac31, 0x93);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x58ac, 0xc88b, 0x6d93, 0xdbdd, 0x0000, 0x0000, 0x0000, 0x0000, 0xac2e, 0x5199, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcb94
  test('ddcb94', () {
    // Set up machine initial state
    loadRegisters(0xe38d, 0x35a5, 0x8d07, 0xbfb8, 0x0000, 0x0000, 0x0000, 0x0000, 0x5e84, 0x5f24, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x11);
    poke(0x0003, 0x94);
    poke(0x5e95, 0xb7);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe38d, 0x35a5, 0x8d07, 0xb3b8, 0x0000, 0x0000, 0x0000, 0x0000, 0x5e84, 0x5f24, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(24213), equals(0xb3));
  }, tags: 'undocumented');


  // Test instruction ddcb95
  test('ddcb95', () {
    // Set up machine initial state
    loadRegisters(0x41f4, 0x9536, 0xdd7d, 0x4948, 0x0000, 0x0000, 0x0000, 0x0000, 0xfb74, 0xf17d, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xe6);
    poke(0x0003, 0x95);
    poke(0xfb5a, 0xc6);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x41f4, 0x9536, 0xdd7d, 0x49c2, 0x0000, 0x0000, 0x0000, 0x0000, 0xfb74, 0xf17d, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(64346), equals(0xc2));
  }, tags: 'undocumented');


  // Test instruction ddcb96
  test('ddcb96', () {
    // Set up machine initial state
    loadRegisters(0x4a9e, 0x42ef, 0x32d7, 0x18cf, 0x0000, 0x0000, 0x0000, 0x0000, 0x7a81, 0xbb1d, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xd5);
    poke(0x0003, 0x96);
    poke(0x7a56, 0xae);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4a9e, 0x42ef, 0x32d7, 0x18cf, 0x0000, 0x0000, 0x0000, 0x0000, 0x7a81, 0xbb1d, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(31318), equals(0xaa));
  });


  // Test instruction ddcb97
  test('ddcb97', () {
    // Set up machine initial state
    loadRegisters(0x9ad3, 0x89f0, 0x73c7, 0x0b1a, 0x0000, 0x0000, 0x0000, 0x0000, 0x847c, 0x4b86, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x92);
    poke(0x0003, 0x97);
    poke(0x840e, 0x23);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x23d3, 0x89f0, 0x73c7, 0x0b1a, 0x0000, 0x0000, 0x0000, 0x0000, 0x847c, 0x4b86, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcb98
  test('ddcb98', () {
    // Set up machine initial state
    loadRegisters(0x6e22, 0xb9fd, 0x9fdc, 0x3aed, 0x0000, 0x0000, 0x0000, 0x0000, 0x041e, 0xfd79, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xdc);
    poke(0x0003, 0x98);
    poke(0x03fa, 0x58);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6e22, 0x50fd, 0x9fdc, 0x3aed, 0x0000, 0x0000, 0x0000, 0x0000, 0x041e, 0xfd79, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(1018), equals(0x50));
  }, tags: 'undocumented');


  // Test instruction ddcb99
  test('ddcb99', () {
    // Set up machine initial state
    loadRegisters(0xa132, 0x3891, 0x1515, 0x2830, 0x0000, 0x0000, 0x0000, 0x0000, 0x09fd, 0x0473, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x6d);
    poke(0x0003, 0x99);
    poke(0x0a6a, 0xce);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa132, 0x38c6, 0x1515, 0x2830, 0x0000, 0x0000, 0x0000, 0x0000, 0x09fd, 0x0473, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(2666), equals(0xc6));
  }, tags: 'undocumented');


  // Test instruction ddcb9a
  test('ddcb9a', () {
    // Set up machine initial state
    loadRegisters(0x783d, 0x8f69, 0x91c4, 0xe38f, 0x0000, 0x0000, 0x0000, 0x0000, 0x68a8, 0x391d, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x8a);
    poke(0x0003, 0x9a);
    poke(0x6832, 0xa8);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x783d, 0x8f69, 0xa0c4, 0xe38f, 0x0000, 0x0000, 0x0000, 0x0000, 0x68a8, 0x391d, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(26674), equals(0xa0));
  }, tags: 'undocumented');


  // Test instruction ddcb9b
  test('ddcb9b', () {
    // Set up machine initial state
    loadRegisters(0x955a, 0xc7b0, 0x53b3, 0xaec6, 0x0000, 0x0000, 0x0000, 0x0000, 0x06ef, 0xe991, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x97);
    poke(0x0003, 0x9b);
    poke(0x0686, 0x62);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x955a, 0xc7b0, 0x5362, 0xaec6, 0x0000, 0x0000, 0x0000, 0x0000, 0x06ef, 0xe991, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcb9c
  test('ddcb9c', () {
    // Set up machine initial state
    loadRegisters(0xaf69, 0xf896, 0xe791, 0xa2ee, 0x0000, 0x0000, 0x0000, 0x0000, 0x847b, 0x59ed, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x54);
    poke(0x0003, 0x9c);
    poke(0x84cf, 0x1b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xaf69, 0xf896, 0xe791, 0x13ee, 0x0000, 0x0000, 0x0000, 0x0000, 0x847b, 0x59ed, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(33999), equals(0x13));
  }, tags: 'undocumented');


  // Test instruction ddcb9d
  test('ddcb9d', () {
    // Set up machine initial state
    loadRegisters(0x7d1e, 0x5009, 0x1248, 0x380c, 0x0000, 0x0000, 0x0000, 0x0000, 0xe920, 0x4fe6, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x0f);
    poke(0x0003, 0x9d);
    poke(0xe92f, 0xe8);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7d1e, 0x5009, 0x1248, 0x38e0, 0x0000, 0x0000, 0x0000, 0x0000, 0xe920, 0x4fe6, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(59695), equals(0xe0));
  }, tags: 'undocumented');


  // Test instruction ddcb9e
  test('ddcb9e', () {
    // Set up machine initial state
    loadRegisters(0xc207, 0xb47c, 0x0e16, 0xe17f, 0x0000, 0x0000, 0x0000, 0x0000, 0xd8bb, 0xbb99, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xb5);
    poke(0x0003, 0x9e);
    poke(0xd870, 0xee);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc207, 0xb47c, 0x0e16, 0xe17f, 0x0000, 0x0000, 0x0000, 0x0000, 0xd8bb, 0xbb99, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(55408), equals(0xe6));
  });


  // Test instruction ddcb9f
  test('ddcb9f', () {
    // Set up machine initial state
    loadRegisters(0xc26b, 0x7537, 0x46bb, 0x13c0, 0x0000, 0x0000, 0x0000, 0x0000, 0xe63c, 0x1d98, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xb8);
    poke(0x0003, 0x9f);
    poke(0xe5f4, 0xa6);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa66b, 0x7537, 0x46bb, 0x13c0, 0x0000, 0x0000, 0x0000, 0x0000, 0xe63c, 0x1d98, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcba0
  test('ddcba0', () {
    // Set up machine initial state
    loadRegisters(0x0bbe, 0x8500, 0x8609, 0x5352, 0x0000, 0x0000, 0x0000, 0x0000, 0xa2f0, 0xda02, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x02);
    poke(0x0003, 0xa0);
    poke(0xa2f2, 0x39);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0bbe, 0x2900, 0x8609, 0x5352, 0x0000, 0x0000, 0x0000, 0x0000, 0xa2f0, 0xda02, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(41714), equals(0x29));
  }, tags: 'undocumented');


  // Test instruction ddcba1
  test('ddcba1', () {
    // Set up machine initial state
    loadRegisters(0xad0a, 0xaa76, 0x0f2d, 0x832c, 0x0000, 0x0000, 0x0000, 0x0000, 0x45bb, 0xa22d, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xf5);
    poke(0x0003, 0xa1);
    poke(0x45b0, 0xd2);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xad0a, 0xaac2, 0x0f2d, 0x832c, 0x0000, 0x0000, 0x0000, 0x0000, 0x45bb, 0xa22d, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(17840), equals(0xc2));
  }, tags: 'undocumented');


  // Test instruction ddcba2
  test('ddcba2', () {
    // Set up machine initial state
    loadRegisters(0xf586, 0x4a7d, 0xa5ab, 0x26fc, 0x0000, 0x0000, 0x0000, 0x0000, 0x628b, 0x6c4d, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x0e);
    poke(0x0003, 0xa2);
    poke(0x6299, 0xa1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf586, 0x4a7d, 0xa1ab, 0x26fc, 0x0000, 0x0000, 0x0000, 0x0000, 0x628b, 0x6c4d, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcba3
  test('ddcba3', () {
    // Set up machine initial state
    loadRegisters(0xde5b, 0xa284, 0xd40e, 0xc92d, 0x0000, 0x0000, 0x0000, 0x0000, 0x040d, 0x12c0, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x2e);
    poke(0x0003, 0xa3);
    poke(0x043b, 0x04);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xde5b, 0xa284, 0xd404, 0xc92d, 0x0000, 0x0000, 0x0000, 0x0000, 0x040d, 0x12c0, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcba4
  test('ddcba4', () {
    // Set up machine initial state
    loadRegisters(0xdfaa, 0xae40, 0x02c3, 0xe0b5, 0x0000, 0x0000, 0x0000, 0x0000, 0xfe4d, 0xfaa3, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x03);
    poke(0x0003, 0xa4);
    poke(0xfe50, 0x27);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xdfaa, 0xae40, 0x02c3, 0x27b5, 0x0000, 0x0000, 0x0000, 0x0000, 0xfe4d, 0xfaa3, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcba5
  test('ddcba5', () {
    // Set up machine initial state
    loadRegisters(0x1a15, 0x04cb, 0x4352, 0xee39, 0x0000, 0x0000, 0x0000, 0x0000, 0x7b27, 0x38a0, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xf6);
    poke(0x0003, 0xa5);
    poke(0x7b1d, 0x6b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1a15, 0x04cb, 0x4352, 0xee6b, 0x0000, 0x0000, 0x0000, 0x0000, 0x7b27, 0x38a0, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcba6
  test('ddcba6', () {
    // Set up machine initial state
    loadRegisters(0x5e46, 0xb98a, 0xb822, 0x04ca, 0x0000, 0x0000, 0x0000, 0x0000, 0xae1b, 0x8730, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x27);
    poke(0x0003, 0xa6);
    poke(0xae42, 0x8f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5e46, 0xb98a, 0xb822, 0x04ca, 0x0000, 0x0000, 0x0000, 0x0000, 0xae1b, 0x8730, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  });


  // Test instruction ddcba7
  test('ddcba7', () {
    // Set up machine initial state
    loadRegisters(0x0eed, 0x7b11, 0x8cb0, 0xeb3d, 0x0000, 0x0000, 0x0000, 0x0000, 0x5ec8, 0x97cf, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xf2);
    poke(0x0003, 0xa7);
    poke(0x5eba, 0x87);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x87ed, 0x7b11, 0x8cb0, 0xeb3d, 0x0000, 0x0000, 0x0000, 0x0000, 0x5ec8, 0x97cf, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcba8
  test('ddcba8', () {
    // Set up machine initial state
    loadRegisters(0x5173, 0x3089, 0x070d, 0xe8f9, 0x0000, 0x0000, 0x0000, 0x0000, 0xe84f, 0x55f0, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xd0);
    poke(0x0003, 0xa8);
    poke(0xe81f, 0x7e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5173, 0x5e89, 0x070d, 0xe8f9, 0x0000, 0x0000, 0x0000, 0x0000, 0xe84f, 0x55f0, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(59423), equals(0x5e));
  }, tags: 'undocumented');


  // Test instruction ddcba9
  test('ddcba9', () {
    // Set up machine initial state
    loadRegisters(0x4fb8, 0xccb5, 0x3e9a, 0x2673, 0x0000, 0x0000, 0x0000, 0x0000, 0x0fdd, 0xaef2, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x9d);
    poke(0x0003, 0xa9);
    poke(0x0f7a, 0x1f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4fb8, 0xcc1f, 0x3e9a, 0x2673, 0x0000, 0x0000, 0x0000, 0x0000, 0x0fdd, 0xaef2, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbaa
  test('ddcbaa', () {
    // Set up machine initial state
    loadRegisters(0xfe76, 0x6f96, 0x3feb, 0x0b21, 0x0000, 0x0000, 0x0000, 0x0000, 0x6747, 0x07ba, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x9f);
    poke(0x0003, 0xaa);
    poke(0x66e6, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xfe76, 0x6f96, 0x50eb, 0x0b21, 0x0000, 0x0000, 0x0000, 0x0000, 0x6747, 0x07ba, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbab
  test('ddcbab', () {
    // Set up machine initial state
    loadRegisters(0x2eb4, 0x36f1, 0x8f44, 0x36af, 0x0000, 0x0000, 0x0000, 0x0000, 0x6682, 0x9d60, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x16);
    poke(0x0003, 0xab);
    poke(0x6698, 0xeb);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2eb4, 0x36f1, 0x8fcb, 0x36af, 0x0000, 0x0000, 0x0000, 0x0000, 0x6682, 0x9d60, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(26264), equals(0xcb));
  }, tags: 'undocumented');


  // Test instruction ddcbac
  test('ddcbac', () {
    // Set up machine initial state
    loadRegisters(0xaf32, 0x8ca8, 0x6558, 0x06d9, 0x0000, 0x0000, 0x0000, 0x0000, 0xa4dd, 0xcd1f, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xc4);
    poke(0x0003, 0xac);
    poke(0xa4a1, 0x44);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xaf32, 0x8ca8, 0x6558, 0x44d9, 0x0000, 0x0000, 0x0000, 0x0000, 0xa4dd, 0xcd1f, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbad
  test('ddcbad', () {
    // Set up machine initial state
    loadRegisters(0xfcc9, 0x69a7, 0x0eed, 0xeab5, 0x0000, 0x0000, 0x0000, 0x0000, 0xeef5, 0x3ed2, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x49);
    poke(0x0003, 0xad);
    poke(0xef3e, 0x76);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xfcc9, 0x69a7, 0x0eed, 0xea56, 0x0000, 0x0000, 0x0000, 0x0000, 0xeef5, 0x3ed2, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(61246), equals(0x56));
  }, tags: 'undocumented');


  // Test instruction ddcbae
  test('ddcbae', () {
    // Set up machine initial state
    loadRegisters(0x5f7a, 0x9c20, 0xf013, 0xc4b7, 0x0000, 0x0000, 0x0000, 0x0000, 0xb306, 0x15dd, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x6e);
    poke(0x0003, 0xae);
    poke(0xb374, 0x5a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5f7a, 0x9c20, 0xf013, 0xc4b7, 0x0000, 0x0000, 0x0000, 0x0000, 0xb306, 0x15dd, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  });


  // Test instruction ddcbaf
  test('ddcbaf', () {
    // Set up machine initial state
    loadRegisters(0xb11e, 0x2583, 0x51fa, 0xd427, 0x0000, 0x0000, 0x0000, 0x0000, 0x3619, 0x9cef, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xc2);
    poke(0x0003, 0xaf);
    poke(0x35db, 0x15);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x151e, 0x2583, 0x51fa, 0xd427, 0x0000, 0x0000, 0x0000, 0x0000, 0x3619, 0x9cef, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbb0
  test('ddcbb0', () {
    // Set up machine initial state
    loadRegisters(0xf43e, 0xce57, 0x3bf3, 0x0933, 0x0000, 0x0000, 0x0000, 0x0000, 0x58d7, 0xd89f, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x47);
    poke(0x0003, 0xb0);
    poke(0x591e, 0x1e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf43e, 0x1e57, 0x3bf3, 0x0933, 0x0000, 0x0000, 0x0000, 0x0000, 0x58d7, 0xd89f, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbb1
  test('ddcbb1', () {
    // Set up machine initial state
    loadRegisters(0x35ef, 0xbbbc, 0xdb46, 0x046c, 0x0000, 0x0000, 0x0000, 0x0000, 0xadd2, 0x2b6e, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x86);
    poke(0x0003, 0xb1);
    poke(0xad58, 0x46);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x35ef, 0xbb06, 0xdb46, 0x046c, 0x0000, 0x0000, 0x0000, 0x0000, 0xadd2, 0x2b6e, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(44376), equals(0x06));
  }, tags: 'undocumented');


  // Test instruction ddcbb2
  test('ddcbb2', () {
    // Set up machine initial state
    loadRegisters(0xc26c, 0xfd32, 0x9b7f, 0xab6c, 0x0000, 0x0000, 0x0000, 0x0000, 0xe7d0, 0x501f, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x70);
    poke(0x0003, 0xb2);
    poke(0xe840, 0x48);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc26c, 0xfd32, 0x087f, 0xab6c, 0x0000, 0x0000, 0x0000, 0x0000, 0xe7d0, 0x501f, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(59456), equals(0x08));
  }, tags: 'undocumented');


  // Test instruction ddcbb3
  test('ddcbb3', () {
    // Set up machine initial state
    loadRegisters(0x36ca, 0xb434, 0xe212, 0xf805, 0x0000, 0x0000, 0x0000, 0x0000, 0x53fb, 0xb191, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xde);
    poke(0x0003, 0xb3);
    poke(0x53d9, 0x06);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x36ca, 0xb434, 0xe206, 0xf805, 0x0000, 0x0000, 0x0000, 0x0000, 0x53fb, 0xb191, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbb4
  test('ddcbb4', () {
    // Set up machine initial state
    loadRegisters(0x0a1c, 0xab67, 0x9ca1, 0x2f98, 0x0000, 0x0000, 0x0000, 0x0000, 0x5066, 0x320c, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x6b);
    poke(0x0003, 0xb4);
    poke(0x50d1, 0xdd);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0a1c, 0xab67, 0x9ca1, 0x9d98, 0x0000, 0x0000, 0x0000, 0x0000, 0x5066, 0x320c, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(20689), equals(0x9d));
  }, tags: 'undocumented');


  // Test instruction ddcbb5
  test('ddcbb5', () {
    // Set up machine initial state
    loadRegisters(0xfd6d, 0x51c9, 0x16d6, 0x1373, 0x0000, 0x0000, 0x0000, 0x0000, 0x146e, 0x2148, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xec);
    poke(0x0003, 0xb5);
    poke(0x145a, 0xd6);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xfd6d, 0x51c9, 0x16d6, 0x1396, 0x0000, 0x0000, 0x0000, 0x0000, 0x146e, 0x2148, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(5210), equals(0x96));
  }, tags: 'undocumented');


  // Test instruction ddcbb6
  test('ddcbb6', () {
    // Set up machine initial state
    loadRegisters(0x1d0b, 0x04e8, 0x109e, 0x1dde, 0x0000, 0x0000, 0x0000, 0x0000, 0x8772, 0x8661, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x15);
    poke(0x0003, 0xb6);
    poke(0x8787, 0x8c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1d0b, 0x04e8, 0x109e, 0x1dde, 0x0000, 0x0000, 0x0000, 0x0000, 0x8772, 0x8661, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  });


  // Test instruction ddcbb7
  test('ddcbb7', () {
    // Set up machine initial state
    loadRegisters(0xf012, 0xb87e, 0x65ba, 0xa5c8, 0x0000, 0x0000, 0x0000, 0x0000, 0x6120, 0x789d, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xd3);
    poke(0x0003, 0xb7);
    poke(0x60f3, 0x54);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1412, 0xb87e, 0x65ba, 0xa5c8, 0x0000, 0x0000, 0x0000, 0x0000, 0x6120, 0x789d, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(24819), equals(0x14));
  }, tags: 'undocumented');


  // Test instruction ddcbb8
  test('ddcbb8', () {
    // Set up machine initial state
    loadRegisters(0x8eae, 0x4a53, 0xbfa1, 0x5e7e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0bf6, 0x1e35, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x13);
    poke(0x0003, 0xb8);
    poke(0x0c09, 0x87);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8eae, 0x0753, 0xbfa1, 0x5e7e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0bf6, 0x1e35, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(3081), equals(0x07));
  }, tags: 'undocumented');


  // Test instruction ddcbb9
  test('ddcbb9', () {
    // Set up machine initial state
    loadRegisters(0x5fb7, 0xa81e, 0xe2d2, 0x4117, 0x0000, 0x0000, 0x0000, 0x0000, 0x0564, 0x48a1, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x56);
    poke(0x0003, 0xb9);
    poke(0x05ba, 0xc8);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5fb7, 0xa848, 0xe2d2, 0x4117, 0x0000, 0x0000, 0x0000, 0x0000, 0x0564, 0x48a1, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(1466), equals(0x48));
  }, tags: 'undocumented');


  // Test instruction ddcbba
  test('ddcbba', () {
    // Set up machine initial state
    loadRegisters(0x7f6a, 0x47fe, 0xce45, 0x75de, 0x0000, 0x0000, 0x0000, 0x0000, 0xf5e0, 0x032c, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x86);
    poke(0x0003, 0xba);
    poke(0xf566, 0x30);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7f6a, 0x47fe, 0x3045, 0x75de, 0x0000, 0x0000, 0x0000, 0x0000, 0xf5e0, 0x032c, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbbb
  test('ddcbbb', () {
    // Set up machine initial state
    loadRegisters(0xc7e3, 0xe49e, 0x9ec5, 0x07e7, 0x0000, 0x0000, 0x0000, 0x0000, 0xbd31, 0x9d5f, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xef);
    poke(0x0003, 0xbb);
    poke(0xbd20, 0xc9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc7e3, 0xe49e, 0x9e49, 0x07e7, 0x0000, 0x0000, 0x0000, 0x0000, 0xbd31, 0x9d5f, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(48416), equals(0x49));
  }, tags: 'undocumented');


  // Test instruction ddcbbc
  test('ddcbbc', () {
    // Set up machine initial state
    loadRegisters(0xb430, 0x7ac7, 0xb45f, 0xfbf7, 0x0000, 0x0000, 0x0000, 0x0000, 0x638e, 0x3173, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xc0);
    poke(0x0003, 0xbc);
    poke(0x634e, 0x28);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb430, 0x7ac7, 0xb45f, 0x28f7, 0x0000, 0x0000, 0x0000, 0x0000, 0x638e, 0x3173, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbbd
  test('ddcbbd', () {
    // Set up machine initial state
    loadRegisters(0x4e71, 0x6ffa, 0xa3f9, 0xa2e5, 0x0000, 0x0000, 0x0000, 0x0000, 0xe3c4, 0x02d4, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xb9);
    poke(0x0003, 0xbd);
    poke(0xe37d, 0xdd);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4e71, 0x6ffa, 0xa3f9, 0xa25d, 0x0000, 0x0000, 0x0000, 0x0000, 0xe3c4, 0x02d4, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(58237), equals(0x5d));
  }, tags: 'undocumented');


  // Test instruction ddcbbe
  test('ddcbbe', () {
    // Set up machine initial state
    loadRegisters(0x4af8, 0x99a5, 0xd6fd, 0x7a16, 0x0000, 0x0000, 0x0000, 0x0000, 0x58d3, 0xce54, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x4d);
    poke(0x0003, 0xbe);
    poke(0x5920, 0xe8);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4af8, 0x99a5, 0xd6fd, 0x7a16, 0x0000, 0x0000, 0x0000, 0x0000, 0x58d3, 0xce54, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(22816), equals(0x68));
  });


  // Test instruction ddcbbf
  test('ddcbbf', () {
    // Set up machine initial state
    loadRegisters(0x6e31, 0x0320, 0x134b, 0x77c3, 0x0000, 0x0000, 0x0000, 0x0000, 0x1734, 0xbc2d, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x26);
    poke(0x0003, 0xbf);
    poke(0x175a, 0xe2);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6231, 0x0320, 0x134b, 0x77c3, 0x0000, 0x0000, 0x0000, 0x0000, 0x1734, 0xbc2d, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(5978), equals(0x62));
  }, tags: 'undocumented');


  // Test instruction ddcbc0
  test('ddcbc0', () {
    // Set up machine initial state
    loadRegisters(0x75be, 0x2b93, 0x093d, 0x1128, 0x0000, 0x0000, 0x0000, 0x0000, 0x792e, 0x31f7, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x00);
    poke(0x0003, 0xc0);
    poke(0x792e, 0x92);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x75be, 0x9393, 0x093d, 0x1128, 0x0000, 0x0000, 0x0000, 0x0000, 0x792e, 0x31f7, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(31022), equals(0x93));
  }, tags: 'undocumented');


  // Test instruction ddcbc1
  test('ddcbc1', () {
    // Set up machine initial state
    loadRegisters(0x313f, 0x8223, 0x5fcc, 0x42c8, 0x0000, 0x0000, 0x0000, 0x0000, 0xdccc, 0xd87b, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xf7);
    poke(0x0003, 0xc1);
    poke(0xdcc3, 0x1c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x313f, 0x821d, 0x5fcc, 0x42c8, 0x0000, 0x0000, 0x0000, 0x0000, 0xdccc, 0xd87b, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(56515), equals(0x1d));
  }, tags: 'undocumented');


  // Test instruction ddcbc2
  test('ddcbc2', () {
    // Set up machine initial state
    loadRegisters(0xa7e3, 0xbf55, 0xd27b, 0x0a9d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0cfa, 0xea4e, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x85);
    poke(0x0003, 0xc2);
    poke(0x0c7f, 0x30);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa7e3, 0xbf55, 0x317b, 0x0a9d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0cfa, 0xea4e, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(3199), equals(0x31));
  }, tags: 'undocumented');


  // Test instruction ddcbc3
  test('ddcbc3', () {
    // Set up machine initial state
    loadRegisters(0xe076, 0x2760, 0x1eec, 0x9968, 0x0000, 0x0000, 0x0000, 0x0000, 0x5426, 0xa1a0, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x32);
    poke(0x0003, 0xc3);
    poke(0x5458, 0xdd);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe076, 0x2760, 0x1edd, 0x9968, 0x0000, 0x0000, 0x0000, 0x0000, 0x5426, 0xa1a0, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbc4
  test('ddcbc4', () {
    // Set up machine initial state
    loadRegisters(0xa679, 0xcc05, 0x3f4d, 0xc899, 0x0000, 0x0000, 0x0000, 0x0000, 0x7acd, 0x48d7, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xae);
    poke(0x0003, 0xc4);
    poke(0x7a7b, 0x27);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa679, 0xcc05, 0x3f4d, 0x2799, 0x0000, 0x0000, 0x0000, 0x0000, 0x7acd, 0x48d7, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbc5
  test('ddcbc5', () {
    // Set up machine initial state
    loadRegisters(0xddfd, 0x64d4, 0x2671, 0x35e7, 0x0000, 0x0000, 0x0000, 0x0000, 0xba99, 0xbd98, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x9c);
    poke(0x0003, 0xc5);
    poke(0xba35, 0x20);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xddfd, 0x64d4, 0x2671, 0x3521, 0x0000, 0x0000, 0x0000, 0x0000, 0xba99, 0xbd98, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(47669), equals(0x21));
  }, tags: 'undocumented');


  // Test instruction ddcbc6
  test('ddcbc6', () {
    // Set up machine initial state
    loadRegisters(0xb324, 0xdc0c, 0x1e35, 0x8cd5, 0x0000, 0x0000, 0x0000, 0x0000, 0xab2c, 0xb6f3, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xc4);
    poke(0x0003, 0xc6);
    poke(0xaaf0, 0xb8);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb324, 0xdc0c, 0x1e35, 0x8cd5, 0x0000, 0x0000, 0x0000, 0x0000, 0xab2c, 0xb6f3, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(43760), equals(0xb9));
  });


  // Test instruction ddcbc7
  test('ddcbc7', () {
    // Set up machine initial state
    loadRegisters(0xa254, 0x9e56, 0x6828, 0x3189, 0x0000, 0x0000, 0x0000, 0x0000, 0x64cb, 0xdfad, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xf8);
    poke(0x0003, 0xc7);
    poke(0x64c3, 0x94);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9554, 0x9e56, 0x6828, 0x3189, 0x0000, 0x0000, 0x0000, 0x0000, 0x64cb, 0xdfad, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(25795), equals(0x95));
  }, tags: 'undocumented');


  // Test instruction ddcbc8
  test('ddcbc8', () {
    // Set up machine initial state
    loadRegisters(0x8aca, 0x139e, 0xe652, 0x248b, 0x0000, 0x0000, 0x0000, 0x0000, 0x6e7a, 0x189a, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x65);
    poke(0x0003, 0xc8);
    poke(0x6edf, 0x8f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8aca, 0x8f9e, 0xe652, 0x248b, 0x0000, 0x0000, 0x0000, 0x0000, 0x6e7a, 0x189a, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbc9
  test('ddcbc9', () {
    // Set up machine initial state
    loadRegisters(0xf15f, 0x856e, 0xa21f, 0x8a59, 0x0000, 0x0000, 0x0000, 0x0000, 0xb670, 0x4f79, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xfb);
    poke(0x0003, 0xc9);
    poke(0xb66b, 0xb9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf15f, 0x85bb, 0xa21f, 0x8a59, 0x0000, 0x0000, 0x0000, 0x0000, 0xb670, 0x4f79, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(46699), equals(0xbb));
  }, tags: 'undocumented');


  // Test instruction ddcbca
  test('ddcbca', () {
    // Set up machine initial state
    loadRegisters(0xdfab, 0xa031, 0x1d78, 0xad3a, 0x0000, 0x0000, 0x0000, 0x0000, 0xa887, 0x7334, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x8a);
    poke(0x0003, 0xca);
    poke(0xa811, 0x7e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xdfab, 0xa031, 0x7e78, 0xad3a, 0x0000, 0x0000, 0x0000, 0x0000, 0xa887, 0x7334, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbcb
  test('ddcbcb', () {
    // Set up machine initial state
    loadRegisters(0xebd6, 0x376e, 0xc346, 0xb10c, 0x0000, 0x0000, 0x0000, 0x0000, 0xa447, 0x31d6, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xa4);
    poke(0x0003, 0xcb);
    poke(0xa3eb, 0x73);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xebd6, 0x376e, 0xc373, 0xb10c, 0x0000, 0x0000, 0x0000, 0x0000, 0xa447, 0x31d6, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbcc
  test('ddcbcc', () {
    // Set up machine initial state
    loadRegisters(0x0212, 0xdc46, 0x8f41, 0x854e, 0x0000, 0x0000, 0x0000, 0x0000, 0x1f5a, 0x07ca, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x65);
    poke(0x0003, 0xcc);
    poke(0x1fbf, 0x72);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0212, 0xdc46, 0x8f41, 0x724e, 0x0000, 0x0000, 0x0000, 0x0000, 0x1f5a, 0x07ca, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbcd
  test('ddcbcd', () {
    // Set up machine initial state
    loadRegisters(0x3344, 0xd73c, 0xd6b8, 0x929d, 0x0000, 0x0000, 0x0000, 0x0000, 0x5376, 0x6d3a, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xe9);
    poke(0x0003, 0xcd);
    poke(0x535f, 0x1c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3344, 0xd73c, 0xd6b8, 0x921e, 0x0000, 0x0000, 0x0000, 0x0000, 0x5376, 0x6d3a, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(21343), equals(0x1e));
  }, tags: 'undocumented');


  // Test instruction ddcbce
  test('ddcbce', () {
    // Set up machine initial state
    loadRegisters(0x9e47, 0xfc93, 0x9ffc, 0xaace, 0x0000, 0x0000, 0x0000, 0x0000, 0x0313, 0x7f66, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x85);
    poke(0x0003, 0xce);
    poke(0x0298, 0x10);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9e47, 0xfc93, 0x9ffc, 0xaace, 0x0000, 0x0000, 0x0000, 0x0000, 0x0313, 0x7f66, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(664), equals(0x12));
  });


  // Test instruction ddcbcf
  test('ddcbcf', () {
    // Set up machine initial state
    loadRegisters(0x53e8, 0xd379, 0x87d5, 0x10b0, 0x0000, 0x0000, 0x0000, 0x0000, 0xc5d0, 0x4f7f, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xe2);
    poke(0x0003, 0xcf);
    poke(0xc5b2, 0xb5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb7e8, 0xd379, 0x87d5, 0x10b0, 0x0000, 0x0000, 0x0000, 0x0000, 0xc5d0, 0x4f7f, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(50610), equals(0xb7));
  }, tags: 'undocumented');


  // Test instruction ddcbd0
  test('ddcbd0', () {
    // Set up machine initial state
    loadRegisters(0x3278, 0x6114, 0xd25d, 0x1cf8, 0x0000, 0x0000, 0x0000, 0x0000, 0xad43, 0x99fc, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x7f);
    poke(0x0003, 0xd0);
    poke(0xadc2, 0x51);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3278, 0x5514, 0xd25d, 0x1cf8, 0x0000, 0x0000, 0x0000, 0x0000, 0xad43, 0x99fc, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(44482), equals(0x55));
  }, tags: 'undocumented');


  // Test instruction ddcbd1
  test('ddcbd1', () {
    // Set up machine initial state
    loadRegisters(0xc0b8, 0x371a, 0x6472, 0xd92d, 0x0000, 0x0000, 0x0000, 0x0000, 0x10b2, 0x3074, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xa6);
    poke(0x0003, 0xd1);
    poke(0x1058, 0x2c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc0b8, 0x372c, 0x6472, 0xd92d, 0x0000, 0x0000, 0x0000, 0x0000, 0x10b2, 0x3074, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbd2
  test('ddcbd2', () {
    // Set up machine initial state
    loadRegisters(0x5bb6, 0xcaa8, 0xe0db, 0xaf84, 0x0000, 0x0000, 0x0000, 0x0000, 0xb9a1, 0x7b5f, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x9c);
    poke(0x0003, 0xd2);
    poke(0xb93d, 0x9c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5bb6, 0xcaa8, 0x9cdb, 0xaf84, 0x0000, 0x0000, 0x0000, 0x0000, 0xb9a1, 0x7b5f, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbd3
  test('ddcbd3', () {
    // Set up machine initial state
    loadRegisters(0xdb6a, 0x4fe2, 0x9e52, 0xa034, 0x0000, 0x0000, 0x0000, 0x0000, 0xda36, 0x88a0, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xbd);
    poke(0x0003, 0xd3);
    poke(0xd9f3, 0x60);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xdb6a, 0x4fe2, 0x9e64, 0xa034, 0x0000, 0x0000, 0x0000, 0x0000, 0xda36, 0x88a0, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(55795), equals(0x64));
  }, tags: 'undocumented');


  // Test instruction ddcbd4
  test('ddcbd4', () {
    // Set up machine initial state
    loadRegisters(0xcc1c, 0xb884, 0x6ad2, 0x1621, 0x0000, 0x0000, 0x0000, 0x0000, 0xef26, 0x41de, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x58);
    poke(0x0003, 0xd4);
    poke(0xef7e, 0x5e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xcc1c, 0xb884, 0x6ad2, 0x5e21, 0x0000, 0x0000, 0x0000, 0x0000, 0xef26, 0x41de, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbd5
  test('ddcbd5', () {
    // Set up machine initial state
    loadRegisters(0xc41d, 0xc8b0, 0xcacb, 0x7687, 0x0000, 0x0000, 0x0000, 0x0000, 0x8dbc, 0xcc25, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x41);
    poke(0x0003, 0xd5);
    poke(0x8dfd, 0x71);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc41d, 0xc8b0, 0xcacb, 0x7675, 0x0000, 0x0000, 0x0000, 0x0000, 0x8dbc, 0xcc25, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(36349), equals(0x75));
  }, tags: 'undocumented');


  // Test instruction ddcbd6
  test('ddcbd6', () {
    // Set up machine initial state
    loadRegisters(0x09eb, 0x769d, 0x7e07, 0x51f9, 0x0000, 0x0000, 0x0000, 0x0000, 0x5f03, 0x6280, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xea);
    poke(0x0003, 0xd6);
    poke(0x5eed, 0x73);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x09eb, 0x769d, 0x7e07, 0x51f9, 0x0000, 0x0000, 0x0000, 0x0000, 0x5f03, 0x6280, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(24301), equals(0x77));
  });


  // Test instruction ddcbd7
  test('ddcbd7', () {
    // Set up machine initial state
    loadRegisters(0x241b, 0xee10, 0xc152, 0x2f6d, 0x0000, 0x0000, 0x0000, 0x0000, 0xe725, 0xc0d7, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x80);
    poke(0x0003, 0xd7);
    poke(0xe6a5, 0x60);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x641b, 0xee10, 0xc152, 0x2f6d, 0x0000, 0x0000, 0x0000, 0x0000, 0xe725, 0xc0d7, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(59045), equals(0x64));
  }, tags: 'undocumented');


  // Test instruction ddcbd8
  test('ddcbd8', () {
    // Set up machine initial state
    loadRegisters(0xe3dc, 0x1981, 0xc97b, 0xcb42, 0x0000, 0x0000, 0x0000, 0x0000, 0xb30f, 0xb32a, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x4c);
    poke(0x0003, 0xd8);
    poke(0xb35b, 0x96);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe3dc, 0x9e81, 0xc97b, 0xcb42, 0x0000, 0x0000, 0x0000, 0x0000, 0xb30f, 0xb32a, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(45915), equals(0x9e));
  }, tags: 'undocumented');


  // Test instruction ddcbd9
  test('ddcbd9', () {
    // Set up machine initial state
    loadRegisters(0xe9a0, 0xa7c7, 0xa476, 0x6057, 0x0000, 0x0000, 0x0000, 0x0000, 0x2642, 0x58a0, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x52);
    poke(0x0003, 0xd9);
    poke(0x2694, 0xef);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe9a0, 0xa7ef, 0xa476, 0x6057, 0x0000, 0x0000, 0x0000, 0x0000, 0x2642, 0x58a0, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbda
  test('ddcbda', () {
    // Set up machine initial state
    loadRegisters(0x6787, 0x26a7, 0xa194, 0x11d3, 0x0000, 0x0000, 0x0000, 0x0000, 0x2d76, 0x7f80, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xea);
    poke(0x0003, 0xda);
    poke(0x2d60, 0x82);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6787, 0x26a7, 0x8a94, 0x11d3, 0x0000, 0x0000, 0x0000, 0x0000, 0x2d76, 0x7f80, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(11616), equals(0x8a));
  }, tags: 'undocumented');


  // Test instruction ddcbdb
  test('ddcbdb', () {
    // Set up machine initial state
    loadRegisters(0xf986, 0x6a4b, 0x6588, 0xd2c8, 0x0000, 0x0000, 0x0000, 0x0000, 0x2b7d, 0x5847, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x4d);
    poke(0x0003, 0xdb);
    poke(0x2bca, 0x10);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf986, 0x6a4b, 0x6518, 0xd2c8, 0x0000, 0x0000, 0x0000, 0x0000, 0x2b7d, 0x5847, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(11210), equals(0x18));
  }, tags: 'undocumented');


  // Test instruction ddcbdc
  test('ddcbdc', () {
    // Set up machine initial state
    loadRegisters(0x4c9e, 0xd94d, 0x9760, 0xb707, 0x0000, 0x0000, 0x0000, 0x0000, 0x7ed4, 0x5cc5, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xd3);
    poke(0x0003, 0xdc);
    poke(0x7ea7, 0x45);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4c9e, 0xd94d, 0x9760, 0x4d07, 0x0000, 0x0000, 0x0000, 0x0000, 0x7ed4, 0x5cc5, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(32423), equals(0x4d));
  }, tags: 'undocumented');


  // Test instruction ddcbdd
  test('ddcbdd', () {
    // Set up machine initial state
    loadRegisters(0x4b3b, 0xd351, 0x9be9, 0x2310, 0x0000, 0x0000, 0x0000, 0x0000, 0x58c1, 0xe430, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x6f);
    poke(0x0003, 0xdd);
    poke(0x5930, 0x20);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4b3b, 0xd351, 0x9be9, 0x2328, 0x0000, 0x0000, 0x0000, 0x0000, 0x58c1, 0xe430, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(22832), equals(0x28));
  }, tags: 'undocumented');


  // Test instruction ddcbde
  test('ddcbde', () {
    // Set up machine initial state
    loadRegisters(0x3b62, 0xca1e, 0xa41a, 0x227a, 0x0000, 0x0000, 0x0000, 0x0000, 0x89d2, 0x7011, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x14);
    poke(0x0003, 0xde);
    poke(0x89e6, 0x5e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3b62, 0xca1e, 0xa41a, 0x227a, 0x0000, 0x0000, 0x0000, 0x0000, 0x89d2, 0x7011, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  });


  // Test instruction ddcbdf
  test('ddcbdf', () {
    // Set up machine initial state
    loadRegisters(0x4c8a, 0x5b42, 0x50dd, 0x4be0, 0x0000, 0x0000, 0x0000, 0x0000, 0xd227, 0x4913, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xef);
    poke(0x0003, 0xdf);
    poke(0xd216, 0x72);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7a8a, 0x5b42, 0x50dd, 0x4be0, 0x0000, 0x0000, 0x0000, 0x0000, 0xd227, 0x4913, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(53782), equals(0x7a));
  }, tags: 'undocumented');


  // Test instruction ddcbe0
  test('ddcbe0', () {
    // Set up machine initial state
    loadRegisters(0x440a, 0x713d, 0xacfc, 0xf762, 0x0000, 0x0000, 0x0000, 0x0000, 0x1c4b, 0xb6ba, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x62);
    poke(0x0003, 0xe0);
    poke(0x1cad, 0x46);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x440a, 0x563d, 0xacfc, 0xf762, 0x0000, 0x0000, 0x0000, 0x0000, 0x1c4b, 0xb6ba, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(7341), equals(0x56));
  }, tags: 'undocumented');


  // Test instruction ddcbe1
  test('ddcbe1', () {
    // Set up machine initial state
    loadRegisters(0xc219, 0xaa6b, 0xdfbf, 0x6f10, 0x0000, 0x0000, 0x0000, 0x0000, 0xb931, 0xd3d6, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x2e);
    poke(0x0003, 0xe1);
    poke(0xb95f, 0x75);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc219, 0xaa75, 0xdfbf, 0x6f10, 0x0000, 0x0000, 0x0000, 0x0000, 0xb931, 0xd3d6, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbe2
  test('ddcbe2', () {
    // Set up machine initial state
    loadRegisters(0x66d7, 0xabd0, 0xcb48, 0x8054, 0x0000, 0x0000, 0x0000, 0x0000, 0xef50, 0x9997, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x85);
    poke(0x0003, 0xe2);
    poke(0xeed5, 0x72);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x66d7, 0xabd0, 0x7248, 0x8054, 0x0000, 0x0000, 0x0000, 0x0000, 0xef50, 0x9997, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbe3
  test('ddcbe3', () {
    // Set up machine initial state
    loadRegisters(0x7013, 0xe7ed, 0x7e1c, 0x57fb, 0x0000, 0x0000, 0x0000, 0x0000, 0x7ec6, 0x75eb, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xf4);
    poke(0x0003, 0xe3);
    poke(0x7eba, 0x34);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7013, 0xe7ed, 0x7e34, 0x57fb, 0x0000, 0x0000, 0x0000, 0x0000, 0x7ec6, 0x75eb, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbe4
  test('ddcbe4', () {
    // Set up machine initial state
    loadRegisters(0x1108, 0x6e70, 0xf0af, 0x2f0c, 0x0000, 0x0000, 0x0000, 0x0000, 0x95c7, 0x6501, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xbf);
    poke(0x0003, 0xe4);
    poke(0x9586, 0x34);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1108, 0x6e70, 0xf0af, 0x340c, 0x0000, 0x0000, 0x0000, 0x0000, 0x95c7, 0x6501, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbe5
  test('ddcbe5', () {
    // Set up machine initial state
    loadRegisters(0x57cc, 0x5511, 0x2696, 0xb83d, 0x0000, 0x0000, 0x0000, 0x0000, 0x6ab0, 0x0e90, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xf2);
    poke(0x0003, 0xe5);
    poke(0x6aa2, 0x2e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x57cc, 0x5511, 0x2696, 0xb83e, 0x0000, 0x0000, 0x0000, 0x0000, 0x6ab0, 0x0e90, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(27298), equals(0x3e));
  }, tags: 'undocumented');


  // Test instruction ddcbe6
  test('ddcbe6', () {
    // Set up machine initial state
    loadRegisters(0x207a, 0xa441, 0x1e03, 0xac60, 0x0000, 0x0000, 0x0000, 0x0000, 0xd866, 0x5fdc, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x25);
    poke(0x0003, 0xe6);
    poke(0xd88b, 0x4c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x207a, 0xa441, 0x1e03, 0xac60, 0x0000, 0x0000, 0x0000, 0x0000, 0xd866, 0x5fdc, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(55435), equals(0x5c));
  });


  // Test instruction ddcbe7
  test('ddcbe7', () {
    // Set up machine initial state
    loadRegisters(0xc3c5, 0x7fa9, 0x4e07, 0xe02d, 0x0000, 0x0000, 0x0000, 0x0000, 0x2a1b, 0x55b7, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xf3);
    poke(0x0003, 0xe7);
    poke(0x2a0e, 0xeb);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xfbc5, 0x7fa9, 0x4e07, 0xe02d, 0x0000, 0x0000, 0x0000, 0x0000, 0x2a1b, 0x55b7, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(10766), equals(0xfb));
  }, tags: 'undocumented');


  // Test instruction ddcbe8
  test('ddcbe8', () {
    // Set up machine initial state
    loadRegisters(0x6d1c, 0xa0c4, 0x93f0, 0xa0b4, 0x0000, 0x0000, 0x0000, 0x0000, 0x4bda, 0x7761, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xf2);
    poke(0x0003, 0xe8);
    poke(0x4bcc, 0xba);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6d1c, 0xbac4, 0x93f0, 0xa0b4, 0x0000, 0x0000, 0x0000, 0x0000, 0x4bda, 0x7761, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbe9
  test('ddcbe9', () {
    // Set up machine initial state
    loadRegisters(0xebe5, 0x0c2c, 0x1a2a, 0x2720, 0x0000, 0x0000, 0x0000, 0x0000, 0x72dd, 0xa354, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x8a);
    poke(0x0003, 0xe9);
    poke(0x7267, 0x0a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xebe5, 0x0c2a, 0x1a2a, 0x2720, 0x0000, 0x0000, 0x0000, 0x0000, 0x72dd, 0xa354, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(29287), equals(0x2a));
  }, tags: 'undocumented');


  // Test instruction ddcbea
  test('ddcbea', () {
    // Set up machine initial state
    loadRegisters(0x42d2, 0xda7a, 0x757f, 0x6da6, 0x0000, 0x0000, 0x0000, 0x0000, 0xa7e9, 0xb933, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x04);
    poke(0x0003, 0xea);
    poke(0xa7ed, 0x5f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x42d2, 0xda7a, 0x7f7f, 0x6da6, 0x0000, 0x0000, 0x0000, 0x0000, 0xa7e9, 0xb933, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(42989), equals(0x7f));
  }, tags: 'undocumented');


  // Test instruction ddcbeb
  test('ddcbeb', () {
    // Set up machine initial state
    loadRegisters(0xe945, 0x10aa, 0xf5f8, 0x7647, 0x0000, 0x0000, 0x0000, 0x0000, 0x16df, 0x93fb, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x24);
    poke(0x0003, 0xeb);
    poke(0x1703, 0xf3);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe945, 0x10aa, 0xf5f3, 0x7647, 0x0000, 0x0000, 0x0000, 0x0000, 0x16df, 0x93fb, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbec
  test('ddcbec', () {
    // Set up machine initial state
    loadRegisters(0x7180, 0xbc85, 0x7dd3, 0xf467, 0x0000, 0x0000, 0x0000, 0x0000, 0xdd88, 0x6a41, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x60);
    poke(0x0003, 0xec);
    poke(0xdde8, 0x00);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7180, 0xbc85, 0x7dd3, 0x2067, 0x0000, 0x0000, 0x0000, 0x0000, 0xdd88, 0x6a41, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(56808), equals(0x20));
  }, tags: 'undocumented');


  // Test instruction ddcbed
  test('ddcbed', () {
    // Set up machine initial state
    loadRegisters(0x6b2f, 0x9762, 0x1f0a, 0xdb61, 0x0000, 0x0000, 0x0000, 0x0000, 0xf772, 0x33e3, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xbe);
    poke(0x0003, 0xed);
    poke(0xf730, 0x6b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6b2f, 0x9762, 0x1f0a, 0xdb6b, 0x0000, 0x0000, 0x0000, 0x0000, 0xf772, 0x33e3, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbee
  test('ddcbee', () {
    // Set up machine initial state
    loadRegisters(0x79ea, 0xdc8a, 0x7887, 0x3baa, 0x0000, 0x0000, 0x0000, 0x0000, 0x6c28, 0xabbc, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xde);
    poke(0x0003, 0xee);
    poke(0x6c06, 0xbd);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x79ea, 0xdc8a, 0x7887, 0x3baa, 0x0000, 0x0000, 0x0000, 0x0000, 0x6c28, 0xabbc, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  });


  // Test instruction ddcbef
  test('ddcbef', () {
    // Set up machine initial state
    loadRegisters(0x46c3, 0x2fc2, 0x8690, 0xa836, 0x0000, 0x0000, 0x0000, 0x0000, 0xcc68, 0xa8ce, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x30);
    poke(0x0003, 0xef);
    poke(0xcc98, 0x11);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x31c3, 0x2fc2, 0x8690, 0xa836, 0x0000, 0x0000, 0x0000, 0x0000, 0xcc68, 0xa8ce, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(52376), equals(0x31));
  }, tags: 'undocumented');


  // Test instruction ddcbf0
  test('ddcbf0', () {
    // Set up machine initial state
    loadRegisters(0xb330, 0x4469, 0x362b, 0xb515, 0x0000, 0x0000, 0x0000, 0x0000, 0x13c0, 0x6479, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x2f);
    poke(0x0003, 0xf0);
    poke(0x13ef, 0xad);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb330, 0xed69, 0x362b, 0xb515, 0x0000, 0x0000, 0x0000, 0x0000, 0x13c0, 0x6479, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(5103), equals(0xed));
  }, tags: 'undocumented');


  // Test instruction ddcbf1
  test('ddcbf1', () {
    // Set up machine initial state
    loadRegisters(0x94c0, 0x9ab0, 0xa0fd, 0x7c1d, 0x0000, 0x0000, 0x0000, 0x0000, 0x47ba, 0x8c81, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x40);
    poke(0x0003, 0xf1);
    poke(0x47fa, 0x78);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x94c0, 0x9a78, 0xa0fd, 0x7c1d, 0x0000, 0x0000, 0x0000, 0x0000, 0x47ba, 0x8c81, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbf2
  test('ddcbf2', () {
    // Set up machine initial state
    loadRegisters(0x5302, 0x9204, 0x20ec, 0xd640, 0x0000, 0x0000, 0x0000, 0x0000, 0xc947, 0x4ef1, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x0f);
    poke(0x0003, 0xf2);
    poke(0xc956, 0x21);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5302, 0x9204, 0x61ec, 0xd640, 0x0000, 0x0000, 0x0000, 0x0000, 0xc947, 0x4ef1, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(51542), equals(0x61));
  }, tags: 'undocumented');


  // Test instruction ddcbf3
  test('ddcbf3', () {
    // Set up machine initial state
    loadRegisters(0x9950, 0xa3d2, 0x5058, 0x5ccc, 0x0000, 0x0000, 0x0000, 0x0000, 0x1d96, 0x7c75, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x06);
    poke(0x0003, 0xf3);
    poke(0x1d9c, 0xe4);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9950, 0xa3d2, 0x50e4, 0x5ccc, 0x0000, 0x0000, 0x0000, 0x0000, 0x1d96, 0x7c75, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbf4
  test('ddcbf4', () {
    // Set up machine initial state
    loadRegisters(0x3712, 0x1f99, 0x4863, 0x47de, 0x0000, 0x0000, 0x0000, 0x0000, 0x1702, 0xc042, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x3b);
    poke(0x0003, 0xf4);
    poke(0x173d, 0xe1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3712, 0x1f99, 0x4863, 0xe1de, 0x0000, 0x0000, 0x0000, 0x0000, 0x1702, 0xc042, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbf5
  test('ddcbf5', () {
    // Set up machine initial state
    loadRegisters(0xd83f, 0x1ec9, 0xd0da, 0x4173, 0x0000, 0x0000, 0x0000, 0x0000, 0xeb3f, 0x1ead, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x64);
    poke(0x0003, 0xf5);
    poke(0xeba3, 0xc5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd83f, 0x1ec9, 0xd0da, 0x41c5, 0x0000, 0x0000, 0x0000, 0x0000, 0xeb3f, 0x1ead, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbf6
  test('ddcbf6', () {
    // Set up machine initial state
    loadRegisters(0x4d6c, 0x93ac, 0x810d, 0xcfe1, 0x0000, 0x0000, 0x0000, 0x0000, 0xdc5a, 0xc33c, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x7b);
    poke(0x0003, 0xf6);
    poke(0xdcd5, 0xa2);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4d6c, 0x93ac, 0x810d, 0xcfe1, 0x0000, 0x0000, 0x0000, 0x0000, 0xdc5a, 0xc33c, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(56533), equals(0xe2));
  });


  // Test instruction ddcbf7
  test('ddcbf7', () {
    // Set up machine initial state
    loadRegisters(0xfe40, 0x7887, 0xb9de, 0xc013, 0x0000, 0x0000, 0x0000, 0x0000, 0x301e, 0x9710, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xc3);
    poke(0x0003, 0xf7);
    poke(0x2fe1, 0xa9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe940, 0x7887, 0xb9de, 0xc013, 0x0000, 0x0000, 0x0000, 0x0000, 0x301e, 0x9710, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(12257), equals(0xe9));
  }, tags: 'undocumented');


  // Test instruction ddcbf8
  test('ddcbf8', () {
    // Set up machine initial state
    loadRegisters(0x8278, 0x21a4, 0x1e5c, 0x4952, 0x0000, 0x0000, 0x0000, 0x0000, 0x427f, 0x41e1, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x59);
    poke(0x0003, 0xf8);
    poke(0x42d8, 0x28);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8278, 0xa8a4, 0x1e5c, 0x4952, 0x0000, 0x0000, 0x0000, 0x0000, 0x427f, 0x41e1, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(17112), equals(0xa8));
  }, tags: 'undocumented');


  // Test instruction ddcbf9
  test('ddcbf9', () {
    // Set up machine initial state
    loadRegisters(0xb2df, 0xe9b8, 0x56c3, 0x16ff, 0x0000, 0x0000, 0x0000, 0x0000, 0xd88f, 0x0bab, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x55);
    poke(0x0003, 0xf9);
    poke(0xd8e4, 0x14);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb2df, 0xe994, 0x56c3, 0x16ff, 0x0000, 0x0000, 0x0000, 0x0000, 0xd88f, 0x0bab, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(55524), equals(0x94));
  }, tags: 'undocumented');


  // Test instruction ddcbfa
  test('ddcbfa', () {
    // Set up machine initial state
    loadRegisters(0x01f1, 0xbc0d, 0xd476, 0x1510, 0x0000, 0x0000, 0x0000, 0x0000, 0x9420, 0x93a3, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x74);
    poke(0x0003, 0xfa);
    poke(0x9494, 0xfe);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x01f1, 0xbc0d, 0xfe76, 0x1510, 0x0000, 0x0000, 0x0000, 0x0000, 0x9420, 0x93a3, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbfb
  test('ddcbfb', () {
    // Set up machine initial state
    loadRegisters(0x709b, 0x14eb, 0xec1c, 0xb844, 0x0000, 0x0000, 0x0000, 0x0000, 0x3453, 0xf2b0, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xaf);
    poke(0x0003, 0xfb);
    poke(0x3402, 0x02);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x709b, 0x14eb, 0xec82, 0xb844, 0x0000, 0x0000, 0x0000, 0x0000, 0x3453, 0xf2b0, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(13314), equals(0x82));
  }, tags: 'undocumented');


  // Test instruction ddcbfc
  test('ddcbfc', () {
    // Set up machine initial state
    loadRegisters(0x6c89, 0xa96e, 0xd27b, 0xd6a7, 0x0000, 0x0000, 0x0000, 0x0000, 0x6139, 0xb4c1, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xa1);
    poke(0x0003, 0xfc);
    poke(0x60da, 0x10);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6c89, 0xa96e, 0xd27b, 0x90a7, 0x0000, 0x0000, 0x0000, 0x0000, 0x6139, 0xb4c1, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(24794), equals(0x90));
  }, tags: 'undocumented');


  // Test instruction ddcbfd
  test('ddcbfd', () {
    // Set up machine initial state
    loadRegisters(0xfb3f, 0x83f6, 0x2094, 0x3349, 0x0000, 0x0000, 0x0000, 0x0000, 0x3ed0, 0x6f0e, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x28);
    poke(0x0003, 0xfd);
    poke(0x3ef8, 0xc2);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xfb3f, 0x83f6, 0x2094, 0x33c2, 0x0000, 0x0000, 0x0000, 0x0000, 0x3ed0, 0x6f0e, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction ddcbfe
  test('ddcbfe', () {
    // Set up machine initial state
    loadRegisters(0xfc42, 0x50b7, 0xe98d, 0x3e45, 0x0000, 0x0000, 0x0000, 0x0000, 0x41b5, 0x3410, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xec);
    poke(0x0003, 0xfe);
    poke(0x41a1, 0xa1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xfc42, 0x50b7, 0xe98d, 0x3e45, 0x0000, 0x0000, 0x0000, 0x0000, 0x41b5, 0x3410, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  });


  // Test instruction ddcbff
  test('ddcbff', () {
    // Set up machine initial state
    loadRegisters(0xe666, 0x94d2, 0xac90, 0x8f45, 0x0000, 0x0000, 0x0000, 0x0000, 0x0655, 0xba29, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xd3);
    poke(0x0003, 0xff);
    poke(0x0628, 0x2b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xab66, 0x94d2, 0xac90, 0x8f45, 0x0000, 0x0000, 0x0000, 0x0000, 0x0655, 0xba29, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(1576), equals(0xab));
  }, tags: 'undocumented');


  // Test instruction dde1
  test('dde1', () {
    // Set up machine initial state
    loadRegisters(0x8a15, 0x6bf0, 0x0106, 0x3dd0, 0x0000, 0x0000, 0x0000, 0x0000, 0x5da4, 0x8716, 0x595f, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xe1);
    poke(0x595f, 0x9a);
    poke(0x5960, 0x09);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8a15, 0x6bf0, 0x0106, 0x3dd0, 0x0000, 0x0000, 0x0000, 0x0000, 0x099a, 0x8716, 0x5961, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 14);
  });


  // Test instruction dde3
  test('dde3', () {
    // Set up machine initial state
    loadRegisters(0x068e, 0x58e6, 0x2713, 0x500f, 0x0000, 0x0000, 0x0000, 0x0000, 0xbe05, 0x4308, 0x57bd, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xe3);
    poke(0x57bd, 0x15);
    poke(0x57be, 0x3f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x068e, 0x58e6, 0x2713, 0x500f, 0x0000, 0x0000, 0x0000, 0x0000, 0x3f15, 0x4308, 0x57bd, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(22461), equals(0x05));
    expect(peek(22462), equals(0xbe));
  });


  // Test instruction dde5
  test('dde5', () {
    // Set up machine initial state
    loadRegisters(0x7462, 0x9b6c, 0xbfe5, 0x0330, 0x0000, 0x0000, 0x0000, 0x0000, 0xb282, 0xe272, 0x0761, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xe5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7462, 0x9b6c, 0xbfe5, 0x0330, 0x0000, 0x0000, 0x0000, 0x0000, 0xb282, 0xe272, 0x075f, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
    expect(peek(1887), equals(0x82));
    expect(peek(1888), equals(0xb2));
  });


  // Test instruction dde9
  test('dde9', () {
    // Set up machine initial state
    loadRegisters(0x75a7, 0x139b, 0xf9a3, 0x94bb, 0x0000, 0x0000, 0x0000, 0x0000, 0x64f0, 0x3433, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xe9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x75a7, 0x139b, 0xf9a3, 0x94bb, 0x0000, 0x0000, 0x0000, 0x0000, 0x64f0, 0x3433, 0x0000, 0x64f0);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction ddf9
  test('ddf9', () {
    // Set up machine initial state
    loadRegisters(0x8709, 0x15dd, 0x7fa6, 0x3c5c, 0x0000, 0x0000, 0x0000, 0x0000, 0xd3a7, 0x1d7b, 0xf67c, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xf9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8709, 0x15dd, 0x7fa6, 0x3c5c, 0x0000, 0x0000, 0x0000, 0x0000, 0xd3a7, 0x1d7b, 0xd3a7, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 10);
  });


  // Test instruction ddfd00
  test('ddfd00', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xdd);
    poke(0x0001, 0xfd);
    poke(0x0002, 0x00);
    poke(0x0003, 0x00);

    // Execute machine for tState cycles
    while(z80.tStates < 13) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x04, false, false, 16);
  }, tags: 'undocumented');


  // Test instruction de
  test('de', () {
    // Set up machine initial state
    loadRegisters(0xe78d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xde);
    poke(0x0001, 0xa1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4502, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction df
  test('df', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5507, 0x6d33);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x6d33, 0xdf);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5505, 0x0018);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
    expect(peek(21765), equals(0x34));
    expect(peek(21766), equals(0x6d));
  });


  // Test instruction e0_1
  test('e0_1', () {
    // Set up machine initial state
    loadRegisters(0x0098, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f7, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xe0);
    poke(0x43f7, 0xe9);
    poke(0x43f8, 0xaf);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0098, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f9, 0xafe9);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
  });


  // Test instruction e0_2
  test('e0_2', () {
    // Set up machine initial state
    loadRegisters(0x009c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f7, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xe0);
    poke(0x43f7, 0xe9);
    poke(0x43f8, 0xaf);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x009c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f7, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 5);
  });


  // Test instruction e1
  test('e1', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x4143, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xe1);
    poke(0x4143, 0xce);
    poke(0x4144, 0xe8);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0xe8ce, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x4145, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction e2_1
  test('e2_1', () {
    // Set up machine initial state
    loadRegisters(0x0083, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xe2);
    poke(0x0001, 0x1b);
    poke(0x0002, 0xe1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0083, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xe11b);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction e2_2
  test('e2_2', () {
    // Set up machine initial state
    loadRegisters(0x0087, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xe2);
    poke(0x0001, 0x1b);
    poke(0x0002, 0xe1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0087, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction e3
  test('e3', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x4d22, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0373, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xe3);
    poke(0x0373, 0x8e);
    poke(0x0374, 0xe1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0xe18e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0373, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 19);
    expect(peek(883), equals(0x22));
    expect(peek(884), equals(0x4d));
  });


  // Test instruction e4_1
  test('e4_1', () {
    // Set up machine initial state
    loadRegisters(0x000a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5698, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xe4);
    poke(0x0001, 0x61);
    poke(0x0002, 0x9c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x000a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5696, 0x9c61);
    checkSpecialRegisters(0x00, 0x01, false, false, 17);
    expect(peek(22166), equals(0x03));
    expect(peek(22167), equals(0x00));
  });


  // Test instruction e4_2
  test('e4_2', () {
    // Set up machine initial state
    loadRegisters(0x000e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5698, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xe4);
    poke(0x0001, 0x61);
    poke(0x0002, 0x9c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x000e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5698, 0x0003);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction e5
  test('e5', () {
    // Set up machine initial state
    loadRegisters(0x53e3, 0x1459, 0x775f, 0x1a2f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xec12, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xe5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x53e3, 0x1459, 0x775f, 0x1a2f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xec10, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
    expect(peek(60432), equals(0x2f));
    expect(peek(60433), equals(0x1a));
  });


  // Test instruction e6
  test('e6', () {
    // Set up machine initial state
    loadRegisters(0x7500, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xe6);
    poke(0x0001, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4114, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction e7
  test('e7', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5507, 0x6d33);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x6d33, 0xe7);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5505, 0x0020);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
    expect(peek(21765), equals(0x34));
    expect(peek(21766), equals(0x6d));
  });


  // Test instruction e8_1
  test('e8_1', () {
    // Set up machine initial state
    loadRegisters(0x0098, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f7, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xe8);
    poke(0x43f7, 0xe9);
    poke(0x43f8, 0xaf);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0098, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f7, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 5);
  });


  // Test instruction e8_2
  test('e8_2', () {
    // Set up machine initial state
    loadRegisters(0x009c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f7, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xe8);
    poke(0x43f7, 0xe9);
    poke(0x43f8, 0xaf);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x009c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f9, 0xafe9);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
  });


  // Test instruction e9
  test('e9', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0xcaba, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xe9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0xcaba, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xcaba);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction ea_1
  test('ea_1', () {
    // Set up machine initial state
    loadRegisters(0x0087, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xea);
    poke(0x0001, 0x1b);
    poke(0x0002, 0xe1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0087, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xe11b);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction ea_2
  test('ea_2', () {
    // Set up machine initial state
    loadRegisters(0x0083, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xea);
    poke(0x0001, 0x1b);
    poke(0x0002, 0xe1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0083, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction eb
  test('eb', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0xb879, 0x942e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xeb);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x942e, 0xb879, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction ec_1
  test('ec_1', () {
    // Set up machine initial state
    loadRegisters(0x000e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5698, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xec);
    poke(0x0001, 0x61);
    poke(0x0002, 0x9c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x000e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5696, 0x9c61);
    checkSpecialRegisters(0x00, 0x01, false, false, 17);
    expect(peek(22166), equals(0x03));
    expect(peek(22167), equals(0x00));
  });


  // Test instruction ec_2
  test('ec_2', () {
    // Set up machine initial state
    loadRegisters(0x000a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5698, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xec);
    poke(0x0001, 0x61);
    poke(0x0002, 0x9c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x000a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5698, 0x0003);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction ed40
  test('ed40', () {
    // Set up machine initial state
    loadRegisters(0x83f9, 0x296b, 0x7034, 0x1f2f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x40);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8329, 0x296b, 0x7034, 0x1f2f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 12);
  });


  // Test instruction ed41
  test('ed41', () {
    // Set up machine initial state
    loadRegisters(0x29a2, 0x0881, 0xd7dd, 0xff4e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x41);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x29a2, 0x0881, 0xd7dd, 0xff4e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 12);
  });


  // Test instruction ed42
  test('ed42', () {
    // Set up machine initial state
    loadRegisters(0xcbd3, 0x1c8f, 0xd456, 0x315e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x42);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xcb12, 0x1c8f, 0xd456, 0x14ce, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
  });


  // Test instruction ed43
  test('ed43', () {
    // Set up machine initial state
    loadRegisters(0xda36, 0x2732, 0x91cc, 0x9798, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5f73, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x43);
    poke(0x0002, 0xc6);
    poke(0x0003, 0x54);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xda36, 0x2732, 0x91cc, 0x9798, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5f73, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
    expect(peek(21702), equals(0x32));
    expect(peek(21703), equals(0x27));
  });


  // Test instruction ed44
  test('ed44', () {
    // Set up machine initial state
    loadRegisters(0xfe2b, 0x040f, 0xdeb6, 0xafc3, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5ca8, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x44);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0213, 0x040f, 0xdeb6, 0xafc3, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5ca8, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction ed45
  test('ed45', () {
    // Set up machine initial state
    loadRegisters(0x001d, 0x5b63, 0xa586, 0x1451, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x3100, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = true;
    poke(0x0000, 0xed);
    poke(0x0001, 0x45);
    poke(0x3100, 0x1f);
    poke(0x3101, 0x22);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x001d, 0x5b63, 0xa586, 0x1451, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x3102, 0x221f);
    checkSpecialRegisters(0x00, 0x02, true, true, 14);
  });


  // Test instruction ed46
  test('ed46', () {
    // Set up machine initial state
    loadRegisters(0xb6ec, 0x8afb, 0xce09, 0x70a1, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x8dea, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x46);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb6ec, 0x8afb, 0xce09, 0x70a1, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x8dea, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction ed47
  test('ed47', () {
    // Set up machine initial state
    loadRegisters(0x9a99, 0x9e5a, 0x9913, 0xcacc, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x47);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9a99, 0x9e5a, 0x9913, 0xcacc, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x9a, 0x02, false, false, 9);
  });


  // Test instruction ed48
  test('ed48', () {
    // Set up machine initial state
    loadRegisters(0xdbdd, 0x7d1b, 0x141d, 0x5fb4, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x48);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xdb2d, 0x7d7d, 0x141d, 0x5fb4, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 12);
  });


  // Test instruction ed49
  test('ed49', () {
    // Set up machine initial state
    loadRegisters(0x07a5, 0x59ec, 0xf459, 0x4316, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x07a5, 0x59ec, 0xf459, 0x4316, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 12);
  });


  // Test instruction ed4a
  test('ed4a', () {
    // Set up machine initial state
    loadRegisters(0x5741, 0x24b5, 0x83d2, 0x9ac8, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x4a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x57a8, 0x24b5, 0x83d2, 0xbf7e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
  });


  // Test instruction ed4b
  test('ed4b', () {
    // Set up machine initial state
    loadRegisters(0x650c, 0xd74d, 0x0448, 0xa3b9, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xb554, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x4b);
    poke(0x0002, 0x1a);
    poke(0x0003, 0xa4);
    poke(0xa41a, 0xf3);
    poke(0xa41b, 0xd4);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x650c, 0xd4f3, 0x0448, 0xa3b9, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xb554, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  });


  // Test instruction ed4c
  test('ed4c', () {
    // Set up machine initial state
    loadRegisters(0x5682, 0x7dde, 0xb049, 0x939d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xc7bb, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x4c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xaabb, 0x7dde, 0xb049, 0x939d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xc7bb, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction ed4d
  test('ed4d', () {
    // Set up machine initial state
    loadRegisters(0x1bed, 0xc358, 0x5fd5, 0x6093, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x680e, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x4d);
    poke(0x680e, 0x03);
    poke(0x680f, 0x7c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1bed, 0xc358, 0x5fd5, 0x6093, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x6810, 0x7c03);
    checkSpecialRegisters(0x00, 0x02, false, false, 14);
  });


  // Test instruction ed4e
  test('ed4e', () {
    // Set up machine initial state
    loadRegisters(0x8e01, 0xe7c6, 0x880f, 0xd2a2, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x85da, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x4e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8e01, 0xe7c6, 0x880f, 0xd2a2, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x85da, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction ed4f
  test('ed4f', () {
    // Set up machine initial state
    loadRegisters(0x2ae3, 0xc115, 0xeff8, 0x9f6d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x4f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2ae3, 0xc115, 0xeff8, 0x9f6d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x2a, false, false, 9);
  });


  // Test instruction ed50
  test('ed50', () {
    // Set up machine initial state
    loadRegisters(0x85ae, 0xbbcc, 0xe2a8, 0xf219, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x85ac, 0xbbcc, 0xbba8, 0xf219, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 12);
  });


  // Test instruction ed51
  test('ed51', () {
    // Set up machine initial state
    loadRegisters(0x2c4c, 0xc0a4, 0x5303, 0xbc25, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x51);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2c4c, 0xc0a4, 0x5303, 0xbc25, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 12);
  });


  // Test instruction ed52
  test('ed52', () {
    // Set up machine initial state
    loadRegisters(0xfc57, 0x1fc8, 0x47b6, 0xda7c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x52);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xfc82, 0x1fc8, 0x47b6, 0x92c5, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
  });


  // Test instruction ed53
  test('ed53', () {
    // Set up machine initial state
    loadRegisters(0x1f88, 0x4692, 0x5cb2, 0x4915, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x7d8c, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x53);
    poke(0x0002, 0xff);
    poke(0x0003, 0x21);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1f88, 0x4692, 0x5cb2, 0x4915, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x7d8c, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
    expect(peek(8703), equals(0xb2));
    expect(peek(8704), equals(0x5c));
  });


  // Test instruction ed54
  test('ed54', () {
    // Set up machine initial state
    loadRegisters(0xadf9, 0x5661, 0x547c, 0xc322, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xd9eb, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x54);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5313, 0x5661, 0x547c, 0xc322, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xd9eb, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction ed55
  test('ed55', () {
    // Set up machine initial state
    loadRegisters(0xb05b, 0x5e84, 0xd6e9, 0xcb3e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xd4b4, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = true;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x55);
    poke(0xd4b4, 0xea);
    poke(0xd4b5, 0xc9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb05b, 0x5e84, 0xd6e9, 0xcb3e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xd4b6, 0xc9ea);
    checkSpecialRegisters(0x00, 0x02, false, false, 14);
  });


  // Test instruction ed56
  test('ed56', () {
    // Set up machine initial state
    loadRegisters(0x5cc0, 0x9100, 0x356b, 0x4bfd, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x2c93, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x56);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5cc0, 0x9100, 0x356b, 0x4bfd, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x2c93, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction ed57
  test('ed57', () {
    // Set up machine initial state
    loadRegisters(0xbcfe, 0xdfc7, 0xa621, 0x1022, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x1e;
    z80.r = 0x17;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x57);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1e08, 0xdfc7, 0xa621, 0x1022, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x1e, 0x19, false, false, 9);
  });


  // Test instruction ed58
  test('ed58', () {
    // Set up machine initial state
    loadRegisters(0xc9ee, 0x4091, 0x9e46, 0x873a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x58);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc900, 0x4091, 0x9e40, 0x873a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 12);
  });


  // Test instruction ed59
  test('ed59', () {
    // Set up machine initial state
    loadRegisters(0x388a, 0xd512, 0xecc5, 0x93af, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x59);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x388a, 0xd512, 0xecc5, 0x93af, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 12);
  });


  // Test instruction ed5a
  test('ed5a', () {
    // Set up machine initial state
    loadRegisters(0xa41f, 0x751c, 0x19ce, 0x0493, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x5a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa408, 0x751c, 0x19ce, 0x1e62, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
  });


  // Test instruction ed5b
  test('ed5b', () {
    // Set up machine initial state
    loadRegisters(0x5df1, 0x982e, 0x002f, 0xadb9, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xf398, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x5b);
    poke(0x0002, 0x04);
    poke(0x0003, 0x9f);
    poke(0x9f04, 0x84);
    poke(0x9f05, 0x4d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5df1, 0x982e, 0x4d84, 0xadb9, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xf398, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  });


  // Test instruction ed5c
  test('ed5c', () {
    // Set up machine initial state
    loadRegisters(0x11c3, 0xb86c, 0x2042, 0xc958, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x93dc, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x5c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xefbb, 0xb86c, 0x2042, 0xc958, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x93dc, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction ed5d
  test('ed5d', () {
    // Set up machine initial state
    loadRegisters(0x1152, 0x1d20, 0x3f86, 0x64fc, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5308, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x5d);
    poke(0x5308, 0x26);
    poke(0x5309, 0xe0);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1152, 0x1d20, 0x3f86, 0x64fc, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x530a, 0xe026);
    checkSpecialRegisters(0x00, 0x02, false, false, 14);
  });


  // Test instruction ed5e
  test('ed5e', () {
    // Set up machine initial state
    loadRegisters(0x611a, 0xc8cf, 0xf215, 0xd92b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x4d86, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x5e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x611a, 0xc8cf, 0xf215, 0xd92b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x4d86, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction ed5f
  test('ed5f', () {
    // Set up machine initial state
    loadRegisters(0x1bb5, 0xfc09, 0x2dfa, 0xbab9, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0xd7;
    z80.r = 0xf3;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x5f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf5a1, 0xfc09, 0x2dfa, 0xbab9, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0xd7, 0xf5, false, false, 9);
  });


  // Test instruction ed60
  test('ed60', () {
    // Set up machine initial state
    loadRegisters(0x2c9c, 0x0dae, 0x621e, 0x2f66, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x60);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2c08, 0x0dae, 0x621e, 0x0d66, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 12);
  });


  // Test instruction ed61
  test('ed61', () {
    // Set up machine initial state
    loadRegisters(0xffa8, 0x90ca, 0x0340, 0xd847, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x61);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xffa8, 0x90ca, 0x0340, 0xd847, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 12);
  });


  // Test instruction ed62
  test('ed62', () {
    // Set up machine initial state
    loadRegisters(0xa60b, 0xd9aa, 0x6623, 0x0b1a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x62);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa6bb, 0xd9aa, 0x6623, 0xffff, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
  });


  // Test instruction ed63
  test('ed63', () {
    // Set up machine initial state
    loadRegisters(0x5222, 0x88f9, 0x9d9a, 0xe4d3, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xa2f0, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x63);
    poke(0x0002, 0x67);
    poke(0x0003, 0x65);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5222, 0x88f9, 0x9d9a, 0xe4d3, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xa2f0, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
    expect(peek(25959), equals(0xd3));
    expect(peek(25960), equals(0xe4));
  });


  // Test instruction ed64
  test('ed64', () {
    // Set up machine initial state
    loadRegisters(0x2127, 0xe425, 0x66ac, 0xb2a3, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f2, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x64);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xdf9b, 0xe425, 0x66ac, 0xb2a3, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f2, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction ed65
  test('ed65', () {
    // Set up machine initial state
    loadRegisters(0x63d2, 0x1fa1, 0x0788, 0x881c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xf207, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = true;
    poke(0x0000, 0xed);
    poke(0x0001, 0x65);
    poke(0xf207, 0xeb);
    poke(0xf208, 0x0e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x63d2, 0x1fa1, 0x0788, 0x881c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xf209, 0x0eeb);
    checkSpecialRegisters(0x00, 0x02, true, true, 14);
  });


  // Test instruction ed66
  test('ed66', () {
    // Set up machine initial state
    loadRegisters(0x4088, 0xa7e1, 0x3ffd, 0x919b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xd193, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x66);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4088, 0xa7e1, 0x3ffd, 0x919b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xd193, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction ed67
  test('ed67', () {
    // Set up machine initial state
    loadRegisters(0x3624, 0xb16a, 0xa4db, 0xb9de, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x67);
    poke(0xb9de, 0x93);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3324, 0xb16a, 0xa4db, 0xb9de, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 18);
    expect(peek(47582), equals(0x69));
  });


  // Test instruction ed68
  test('ed68', () {
    // Set up machine initial state
    loadRegisters(0x5316, 0x624b, 0x7311, 0x3106, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x68);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5320, 0x624b, 0x7311, 0x3162, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 12);
  });


  // Test instruction ed69
  test('ed69', () {
    // Set up machine initial state
    loadRegisters(0xabd8, 0x8d2f, 0x89c7, 0xc3d6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x69);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xabd8, 0x8d2f, 0x89c7, 0xc3d6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 12);
  });


  // Test instruction ed6a
  test('ed6a', () {
    // Set up machine initial state
    loadRegisters(0xbb5a, 0x6fed, 0x59bb, 0x4e40, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x6a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xbb9c, 0x6fed, 0x59bb, 0x9c80, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
  });


  // Test instruction ed6b
  test('ed6b', () {
    // Set up machine initial state
    loadRegisters(0x9e35, 0xd240, 0x1998, 0xab19, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x9275, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x6b);
    poke(0x0002, 0x98);
    poke(0x0003, 0x61);
    poke(0x6198, 0x3f);
    poke(0x6199, 0xbe);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9e35, 0xd240, 0x1998, 0xbe3f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x9275, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  });


  // Test instruction ed6c
  test('ed6c', () {
    // Set up machine initial state
    loadRegisters(0x0fb1, 0x7d5b, 0xcadb, 0x0893, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xd983, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x6c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf1b3, 0x7d5b, 0xcadb, 0x0893, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xd983, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction ed6d
  test('ed6d', () {
    // Set up machine initial state
    loadRegisters(0x3860, 0x42da, 0x5935, 0xdc10, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5cd3, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x6d);
    poke(0x5cd3, 0xa9);
    poke(0x5cd4, 0x73);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3860, 0x42da, 0x5935, 0xdc10, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5cd5, 0x73a9);
    checkSpecialRegisters(0x00, 0x02, false, false, 14);
  });


  // Test instruction ed6e
  test('ed6e', () {
    // Set up machine initial state
    loadRegisters(0x7752, 0xbec3, 0x0457, 0x8c95, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xa787, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x6e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7752, 0xbec3, 0x0457, 0x8c95, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xa787, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction ed6f
  test('ed6f', () {
    // Set up machine initial state
    loadRegisters(0x658b, 0x7a7a, 0xecf0, 0x403c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x6f);
    poke(0x403c, 0xc4);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6c2d, 0x7a7a, 0xecf0, 0x403c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 18);
    expect(peek(16444), equals(0x45));
  });


  // Test instruction ed70
  test('ed70', () {
    // Set up machine initial state
    loadRegisters(0xc6a1, 0xf7d6, 0xa3cb, 0x288d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x70);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc6a1, 0xf7d6, 0xa3cb, 0x288d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 12);
  });


  // Test instruction ed71
  test('ed71', () {
    // Set up machine initial state
    loadRegisters(0xafa0, 0x20b3, 0x7b33, 0x4ac1, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x71);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xafa0, 0x20b3, 0x7b33, 0x4ac1, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 12);
  });


  // Test instruction ed72
  test('ed72', () {
    // Set up machine initial state
    loadRegisters(0x5fd9, 0x05cb, 0x0c6c, 0xd18b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x53db, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x72);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5f3e, 0x05cb, 0x0c6c, 0x7daf, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x53db, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
  });


  // Test instruction ed73
  test('ed73', () {
    // Set up machine initial state
    loadRegisters(0x41c4, 0x763a, 0xecb0, 0xee62, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xaed5, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x73);
    poke(0x0002, 0x2a);
    poke(0x0003, 0x79);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x41c4, 0x763a, 0xecb0, 0xee62, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xaed5, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
    expect(peek(31018), equals(0xd5));
    expect(peek(31019), equals(0xae));
  });


  // Test instruction ed74
  test('ed74', () {
    // Set up machine initial state
    loadRegisters(0x4454, 0xf2d2, 0x8340, 0x7e76, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0323, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x74);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xbcbb, 0xf2d2, 0x8340, 0x7e76, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0323, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction ed75
  test('ed75', () {
    // Set up machine initial state
    loadRegisters(0x7ca4, 0x1615, 0x5d2a, 0xa95b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x7d00, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = true;
    z80.iff2 = true;
    poke(0x0000, 0xed);
    poke(0x0001, 0x75);
    poke(0x7d00, 0xfd);
    poke(0x7d01, 0x4f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7ca4, 0x1615, 0x5d2a, 0xa95b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x7d02, 0x4ffd);
    checkSpecialRegisters(0x00, 0x02, true, true, 14);
  });


  // Test instruction ed76
  test('ed76', () {
    // Set up machine initial state
    loadRegisters(0xcabf, 0xff9a, 0xb98c, 0xa8e6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xfe8e, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x76);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xcabf, 0xff9a, 0xb98c, 0xa8e6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xfe8e, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction ed78
  test('ed78', () {
    // Set up machine initial state
    loadRegisters(0x58dd, 0xf206, 0x2d6a, 0xaf16, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x78);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf2a1, 0xf206, 0x2d6a, 0xaf16, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 12);
  });


  // Test instruction ed79
  test('ed79', () {
    // Set up machine initial state
    loadRegisters(0xe000, 0x4243, 0x8f7f, 0xed90, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x79);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe000, 0x4243, 0x8f7f, 0xed90, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 12);
  });


  // Test instruction ed7a
  test('ed7a', () {
    // Set up machine initial state
    loadRegisters(0x32fd, 0xd819, 0xd873, 0x8dcf, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5d22, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x7a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x32b8, 0xd819, 0xd873, 0xeaf2, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5d22, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
  });


  // Test instruction ed7b
  test('ed7b', () {
    // Set up machine initial state
    loadRegisters(0x4f97, 0x24b7, 0xe105, 0x1bf2, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5e17, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x7b);
    poke(0x0002, 0x50);
    poke(0x0003, 0x8c);
    poke(0x8c50, 0xd8);
    poke(0x8c51, 0x48);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4f97, 0x24b7, 0xe105, 0x1bf2, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x48d8, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  });


  // Test instruction ed7c
  test('ed7c', () {
    // Set up machine initial state
    loadRegisters(0xd333, 0x29ca, 0x9622, 0xb452, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0be6, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x7c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2d3b, 0x29ca, 0x9622, 0xb452, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0be6, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction ed7d
  test('ed7d', () {
    // Set up machine initial state
    loadRegisters(0xecb6, 0x073e, 0xdc1e, 0x38d9, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x66f0, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = true;
    poke(0x0000, 0xed);
    poke(0x0001, 0x7d);
    poke(0x66f0, 0x4f);
    poke(0x66f1, 0xfb);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xecb6, 0x073e, 0xdc1e, 0x38d9, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x66f2, 0xfb4f);
    checkSpecialRegisters(0x00, 0x02, true, true, 14);
  });


  // Test instruction ed7e
  test('ed7e', () {
    // Set up machine initial state
    loadRegisters(0xb246, 0x1a1a, 0x933a, 0x4b8b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x2242, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0x7e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb246, 0x1a1a, 0x933a, 0x4b8b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x2242, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction eda0
  test('eda0', () {
    // Set up machine initial state
    loadRegisters(0x1bc9, 0x3d11, 0x95c1, 0xd097, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xa0);
    poke(0xd097, 0xb7);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1be5, 0x3d10, 0x95c2, 0xd098, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 16);
    expect(peek(38337), equals(0xb7));
  });


  // Test instruction eda1
  test('eda1', () {
    // Set up machine initial state
    loadRegisters(0xecdb, 0x7666, 0x537f, 0x3bc3, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xa1);
    poke(0x3bc3, 0xb4);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xec0f, 0x7665, 0x537f, 0x3bc4, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 16);
  });


  // Test instruction eda2
  test('eda2', () {
    // Set up machine initial state
    loadRegisters(0x0121, 0x9a82, 0x5bbd, 0x2666, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xa2);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x019f, 0x9982, 0x5bbd, 0x2667, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 16);
    expect(peek(9830), equals(0x9a));
  });


  // Test instruction eda2_01
  test('eda2_01', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0200, 0x0000, 0x8000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xa2);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0100, 0x0000, 0x8001, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 16);
    expect(peek(32768), equals(0x02));
  });


  // Test instruction eda2_02
  test('eda2_02', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x569a, 0x0000, 0x8000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xa2);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x559a, 0x0000, 0x8001, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 16);
    expect(peek(32768), equals(0x56));
  });


  // Test instruction eda2_03
  test('eda2_03', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0xabcc, 0x0000, 0x8000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xa2);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x00bf, 0xaacc, 0x0000, 0x8001, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 16);
    expect(peek(32768), equals(0xab));
  });


  // Test instruction eda3
  test('eda3', () {
    // Set up machine initial state
    loadRegisters(0x42c5, 0x6334, 0x1e28, 0x32fa, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xa3);
    poke(0x32fa, 0xb3);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4233, 0x6234, 0x1e28, 0x32fb, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 16);
  });


  // Test instruction eda3_01
  test('eda3_01', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0100, 0x0000, 0x01ff, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xa3);
    poke(0x01ff, 0x00);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0044, 0x0000, 0x0000, 0x0200, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 16);
  });


  // Test instruction eda3_02
  test('eda3_02', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0100, 0x0000, 0x0100, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xa3);
    poke(0x0100, 0x00);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0040, 0x0000, 0x0000, 0x0101, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 16);
  });


  // Test instruction eda3_03
  test('eda3_03', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0100, 0x0000, 0x0107, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xa3);
    poke(0x0107, 0x00);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0044, 0x0000, 0x0000, 0x0108, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 16);
  });


  // Test instruction eda3_04
  test('eda3_04', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0100, 0x0000, 0x01ff, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xa3);
    poke(0x01ff, 0x80);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0046, 0x0000, 0x0000, 0x0200, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 16);
  });


  // Test instruction eda3_05
  test('eda3_05', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0100, 0x0000, 0x01fd, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xa3);
    poke(0x01fd, 0x12);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0055, 0x0000, 0x0000, 0x01fe, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 16);
  });


  // Test instruction eda3_06
  test('eda3_06', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0100, 0x0000, 0x01fe, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xa3);
    poke(0x01fe, 0x12);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0051, 0x0000, 0x0000, 0x01ff, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 16);
  });


  // Test instruction eda3_07
  test('eda3_07', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0200, 0x0000, 0x01ff, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xa3);
    poke(0x01ff, 0x00);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0100, 0x0000, 0x0200, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 16);
  });


  // Test instruction eda3_08
  test('eda3_08', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0800, 0x0000, 0x01fe, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xa3);
    poke(0x01fe, 0x00);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0004, 0x0700, 0x0000, 0x01ff, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 16);
  });


  // Test instruction eda3_09
  test('eda3_09', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x8100, 0x0000, 0x01ff, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xa3);
    poke(0x01ff, 0x00);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0080, 0x8000, 0x0000, 0x0200, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 16);
  });


  // Test instruction eda3_10
  test('eda3_10', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x8200, 0x0000, 0x01ff, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xa3);
    poke(0x01ff, 0x00);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0084, 0x8100, 0x0000, 0x0200, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 16);
  });


  // Test instruction eda3_11
  test('eda3_11', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0xa900, 0x0000, 0x01ff, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xa3);
    poke(0x01ff, 0x00);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x00a8, 0xa800, 0x0000, 0x0200, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 16);
  });


  // Test instruction eda8
  test('eda8', () {
    // Set up machine initial state
    loadRegisters(0x2a8e, 0x1607, 0x5938, 0x12e8, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xa8);
    poke(0x12e8, 0xd8);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2aa4, 0x1606, 0x5937, 0x12e7, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 16);
    expect(peek(22840), equals(0xd8));
  });


  // Test instruction eda9
  test('eda9', () {
    // Set up machine initial state
    loadRegisters(0x1495, 0xfb42, 0x0466, 0x0dbe, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xa9);
    poke(0x0dbe, 0x89);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x14bf, 0xfb41, 0x0466, 0x0dbd, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 16);
  });


  // Test instruction edaa
  test('edaa', () {
    // Set up machine initial state
    loadRegisters(0x2042, 0xd791, 0xa912, 0xa533, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xaa);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2097, 0xd691, 0xa912, 0xa532, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 16);
    expect(peek(42291), equals(0xd7));
  });


  // Test instruction edaa_01
  test('edaa_01', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0101, 0x0000, 0x8000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xaa);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0040, 0x0001, 0x0000, 0x7fff, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 16);
    expect(peek(32768), equals(0x01));
  });


  // Test instruction edaa_02
  test('edaa_02', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x56aa, 0x0000, 0x8000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xaa);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x55aa, 0x0000, 0x7fff, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 16);
    expect(peek(32768), equals(0x56));
  });


  // Test instruction edaa_03
  test('edaa_03', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0xabcc, 0x0000, 0x8000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xaa);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x00bf, 0xaacc, 0x0000, 0x7fff, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 16);
    expect(peek(32768), equals(0xab));
  });


  // Test instruction edab
  test('edab', () {
    // Set up machine initial state
    loadRegisters(0x0037, 0xf334, 0xd3e1, 0x199f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xab);
    poke(0x199f, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x00a4, 0xf234, 0xd3e1, 0x199e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 16);
  });


  // Test instruction edab_01
  test('edab_01', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x5800, 0x0000, 0x007a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xab);
    poke(0x007a, 0x7f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x5700, 0x0000, 0x0079, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 16);
  });


  // Test instruction edab_02
  test('edab_02', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0xab00, 0x0000, 0x00f1, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xab);
    poke(0x00f1, 0xcd);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x00bf, 0xaa00, 0x0000, 0x00f0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 16);
  });


  // Test instruction edb0
  test('edb0', () {
    // Set up machine initial state
    loadRegisters(0x1045, 0x0010, 0xaad8, 0x558e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xb0);
    poke(0x558e, 0x53);
    poke(0x558f, 0x94);
    poke(0x5590, 0x30);
    poke(0x5591, 0x05);
    poke(0x5592, 0x44);
    poke(0x5593, 0x24);
    poke(0x5594, 0x22);
    poke(0x5595, 0xb9);
    poke(0x5596, 0xe9);
    poke(0x5597, 0x77);
    poke(0x5598, 0x23);
    poke(0x5599, 0x71);
    poke(0x559a, 0xe2);
    poke(0x559b, 0x5c);
    poke(0x559c, 0xfb);
    poke(0x559d, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 331) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1049, 0x0000, 0xaae8, 0x559e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x20, false, false, 331);
    expect(peek(43736), equals(0x53));
    expect(peek(43737), equals(0x94));
    expect(peek(43738), equals(0x30));
    expect(peek(43739), equals(0x05));
    expect(peek(43740), equals(0x44));
    expect(peek(43741), equals(0x24));
    expect(peek(43742), equals(0x22));
    expect(peek(43743), equals(0xb9));
    expect(peek(43744), equals(0xe9));
    expect(peek(43745), equals(0x77));
    expect(peek(43746), equals(0x23));
    expect(peek(43747), equals(0x71));
    expect(peek(43748), equals(0xe2));
    expect(peek(43749), equals(0x5c));
    expect(peek(43750), equals(0xfb));
    expect(peek(43751), equals(0x49));
  });


  // Test instruction edb0_1
  test('edb0_1', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0002, 0xc000, 0x8000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x4000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x4000, 0xed);
    poke(0x4001, 0xb0);
    poke(0x8000, 0x12);
    poke(0x8001, 0x34);

    // Execute machine for tState cycles
    while(z80.tStates < 37) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0xc002, 0x8002, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x4002);
    checkSpecialRegisters(0x00, 0x04, false, false, 37);
    expect(peek(49152), equals(0x12));
    expect(peek(49153), equals(0x34));
  });


  // Test instruction edb0_2
  test('edb0_2', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0001, 0xc000, 0x8000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x4000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x4000, 0xed);
    poke(0x4001, 0xb0);
    poke(0x8000, 0x12);
    poke(0x8001, 0x34);

    // Execute machine for tState cycles
    while(z80.tStates < 16) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0020, 0x0000, 0xc001, 0x8001, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x4002);
    checkSpecialRegisters(0x00, 0x02, false, false, 16);
    expect(peek(49152), equals(0x12));
  });


  // Test instruction edb1
  test('edb1', () {
    // Set up machine initial state
    loadRegisters(0xf4dd, 0x0008, 0xe4e0, 0x9825, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xb1);
    poke(0x9825, 0x50);
    poke(0x9826, 0xe5);
    poke(0x9827, 0x41);
    poke(0x9828, 0xf4);
    poke(0x9829, 0x01);
    poke(0x982a, 0x9f);
    poke(0x982b, 0x11);
    poke(0x982c, 0x85);

    // Execute machine for tState cycles
    while(z80.tStates < 79) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf447, 0x0004, 0xe4e0, 0x9829, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x08, false, false, 79);
  });


  // Test instruction edb1_1
  test('edb1_1', () {
    // Set up machine initial state
    loadRegisters(0xf4dd, 0x0008, 0xe4e0, 0x9825, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x8396);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x8396, 0xed);
    poke(0x8397, 0xb1);
    poke(0x9825, 0x50);
    poke(0x9826, 0xe5);
    poke(0x9827, 0x41);
    poke(0x9828, 0xf4);
    poke(0x9829, 0x01);
    poke(0x982a, 0x9f);
    poke(0x982b, 0x11);
    poke(0x982c, 0x85);

    // Execute machine for tState cycles
    while(z80.tStates < 79) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf447, 0x0004, 0xe4e0, 0x9829, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x8398);
    checkSpecialRegisters(0x00, 0x08, false, false, 79);
  });


  // Test instruction edb1_2
  test('edb1_2', () {
    // Set up machine initial state
    loadRegisters(0xf4dd, 0x0008, 0xe4e0, 0x9825, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x8396);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x8396, 0xed);
    poke(0x8397, 0xb1);
    poke(0x9825, 0x50);
    poke(0x9826, 0xe5);
    poke(0x9827, 0x41);
    poke(0x9828, 0xf4);
    poke(0x9829, 0x01);
    poke(0x982a, 0x9f);
    poke(0x982b, 0x11);
    poke(0x982c, 0x85);

    // Execute machine for tState cycles
    while(z80.tStates < 21) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf487, 0x0007, 0xe4e0, 0x9826, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x8396);
    checkSpecialRegisters(0x00, 0x02, false, false, 21);
  });


  // Test instruction edb2
  test('edb2', () {
    // Set up machine initial state
    loadRegisters(0x8a34, 0x0a40, 0xd98c, 0x37ce, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xb2);

    // Execute machine for tState cycles
    while(z80.tStates < 205) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8a40, 0x0040, 0xd98c, 0x37d8, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x14, false, false, 205);
    expect(peek(14286), equals(0x0a));
    expect(peek(14287), equals(0x09));
    expect(peek(14288), equals(0x08));
    expect(peek(14289), equals(0x07));
    expect(peek(14290), equals(0x06));
    expect(peek(14291), equals(0x05));
    expect(peek(14292), equals(0x04));
    expect(peek(14293), equals(0x03));
    expect(peek(14294), equals(0x02));
    expect(peek(14295), equals(0x01));
  });


  // Test instruction edb2_1
  test('edb2_1', () {
    // Set up machine initial state
    loadRegisters(0x8a34, 0x0a40, 0xd98c, 0x37ce, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xb2);

    // Execute machine for tState cycles
    while(z80.tStates < 21) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8a0c, 0x0940, 0xd98c, 0x37cf, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    checkSpecialRegisters(0x00, 0x02, false, false, 21);
    expect(peek(14286), equals(0x0a));
  });


  // Test instruction edb3
  test('edb3', () {
    // Set up machine initial state
    loadRegisters(0x34ab, 0x03e0, 0x41b9, 0x1d7c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xb3);
    poke(0x1d7c, 0x9d);
    poke(0x1d7d, 0x24);
    poke(0x1d7e, 0xaa);

    // Execute machine for tState cycles
    while(z80.tStates < 58) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3453, 0x00e0, 0x41b9, 0x1d7f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x06, false, false, 58);
  });


  // Test instruction edb3_1
  test('edb3_1', () {
    // Set up machine initial state
    loadRegisters(0x34ab, 0x03e0, 0x41b9, 0x1d7c, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xb3);
    poke(0x1d7c, 0x9d);
    poke(0x1d7d, 0x24);
    poke(0x1d7e, 0xaa);

    // Execute machine for tState cycles
    while(z80.tStates < 21) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3417, 0x02e0, 0x41b9, 0x1d7d, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    checkSpecialRegisters(0x00, 0x02, false, false, 21);
  });


  // Test instruction edb8
  test('edb8', () {
    // Set up machine initial state
    loadRegisters(0xe553, 0x0008, 0x68e8, 0x4dcf, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xb8);
    poke(0x4dc8, 0x29);
    poke(0x4dc9, 0x85);
    poke(0x4dca, 0xa7);
    poke(0x4dcb, 0xc3);
    poke(0x4dcc, 0x55);
    poke(0x4dcd, 0x74);
    poke(0x4dce, 0x23);
    poke(0x4dcf, 0x0a);

    // Execute machine for tState cycles
    while(z80.tStates < 163) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe569, 0x0000, 0x68e0, 0x4dc7, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x10, false, false, 163);
    expect(peek(26849), equals(0x29));
    expect(peek(26850), equals(0x85));
    expect(peek(26851), equals(0xa7));
    expect(peek(26852), equals(0xc3));
    expect(peek(26853), equals(0x55));
    expect(peek(26854), equals(0x74));
    expect(peek(26855), equals(0x23));
    expect(peek(26856), equals(0x0a));
  });


  // Test instruction edb8_1
  test('edb8_1', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0002, 0xb5d7, 0x6af0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x1ec1);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x1ec1, 0xed);
    poke(0x1ec2, 0xb8);
    poke(0x6aef, 0xd6);
    poke(0x6af0, 0x70);

    // Execute machine for tState cycles
    while(z80.tStates < 37) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0020, 0x0000, 0xb5d5, 0x6aee, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x1ec3);
    checkSpecialRegisters(0x00, 0x04, false, false, 37);
    expect(peek(46550), equals(0xd6));
    expect(peek(46551), equals(0x70));
  });


  // Test instruction edb8_2
  test('edb8_2', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0001, 0xb5d7, 0x6af0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x1ec1);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x1ec1, 0xed);
    poke(0x1ec2, 0xb8);
    poke(0x6aef, 0xd6);
    poke(0x6af0, 0x70);

    // Execute machine for tState cycles
    while(z80.tStates < 16) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0xb5d6, 0x6aef, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x1ec3);
    checkSpecialRegisters(0x00, 0x02, false, false, 16);
    expect(peek(46551), equals(0x70));
  });


  // Test instruction edb9
  test('edb9', () {
    // Set up machine initial state
    loadRegisters(0xffcd, 0x0008, 0xa171, 0xc749, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xb9);
    poke(0xc742, 0xc6);
    poke(0xc743, 0x09);
    poke(0xc744, 0x85);
    poke(0xc745, 0xec);
    poke(0xc746, 0x5a);
    poke(0xc747, 0x01);
    poke(0xc748, 0x4e);
    poke(0xc749, 0x6c);

    // Execute machine for tState cycles
    while(z80.tStates < 163) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xff0b, 0x0000, 0xa171, 0xc741, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x10, false, false, 163);
  });


  // Test instruction edb9_1
  test('edb9_1', () {
    // Set up machine initial state
    loadRegisters(0xffcd, 0x0008, 0xa171, 0xc749, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x7a45);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x7a45, 0xed);
    poke(0x7a46, 0xb9);
    poke(0xc742, 0xc6);
    poke(0xc743, 0x09);
    poke(0xc744, 0x85);
    poke(0xc745, 0xec);
    poke(0xc746, 0x5a);
    poke(0xc747, 0x01);
    poke(0xc748, 0x4e);
    poke(0xc749, 0x6c);

    // Execute machine for tState cycles
    while(z80.tStates < 163) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xff0b, 0x0000, 0xa171, 0xc741, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x7a47);
    checkSpecialRegisters(0x00, 0x10, false, false, 163);
  });


  // Test instruction edb9_2
  test('edb9_2', () {
    // Set up machine initial state
    loadRegisters(0xffcd, 0x0008, 0xa171, 0xc749, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x7a45);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x7a45, 0xed);
    poke(0x7a46, 0xb9);
    poke(0xc742, 0xc6);
    poke(0xc743, 0x09);
    poke(0xc744, 0x85);
    poke(0xc745, 0xec);
    poke(0xc746, 0x5a);
    poke(0xc747, 0x01);
    poke(0xc748, 0x4e);
    poke(0xc749, 0x6c);

    // Execute machine for tState cycles
    while(z80.tStates < 21) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xffa7, 0x0007, 0xa171, 0xc748, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x7a45);
    checkSpecialRegisters(0x00, 0x02, false, false, 21);
  });


  // Test instruction edba
  test('edba', () {
    // Set up machine initial state
    loadRegisters(0x2567, 0x069f, 0xd40d, 0x6b55, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xba);

    // Execute machine for tState cycles
    while(z80.tStates < 121) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2540, 0x009f, 0xd40d, 0x6b4f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x0c, false, false, 121);
    expect(peek(27472), equals(0x01));
    expect(peek(27473), equals(0x02));
    expect(peek(27474), equals(0x03));
    expect(peek(27475), equals(0x04));
    expect(peek(27476), equals(0x05));
    expect(peek(27477), equals(0x06));
  });


  // Test instruction edba_1
  test('edba_1', () {
    // Set up machine initial state
    loadRegisters(0x2567, 0x069f, 0xd40d, 0x6b55, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xba);

    // Execute machine for tState cycles
    while(z80.tStates < 21) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2500, 0x059f, 0xd40d, 0x6b54, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    checkSpecialRegisters(0x00, 0x02, false, false, 21);
    expect(peek(27477), equals(0x06));
  });


  // Test instruction edbb
  test('edbb', () {
    // Set up machine initial state
    loadRegisters(0x09c4, 0x043b, 0xbe49, 0x1dd0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xbb);
    poke(0x1dcd, 0xf9);
    poke(0x1dce, 0x71);
    poke(0x1dcf, 0xc5);
    poke(0x1dd0, 0xb6);

    // Execute machine for tState cycles
    while(z80.tStates < 79) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0957, 0x003b, 0xbe49, 0x1dcc, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x08, false, false, 79);
  });


  // Test instruction edbb_1
  test('edbb_1', () {
    // Set up machine initial state
    loadRegisters(0x09c4, 0x043b, 0xbe49, 0x1dd0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xed);
    poke(0x0001, 0xbb);
    poke(0x1dcd, 0xf9);
    poke(0x1dce, 0x71);
    poke(0x1dcf, 0xc5);
    poke(0x1dd0, 0xb6);

    // Execute machine for tState cycles
    while(z80.tStates < 21) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0917, 0x033b, 0xbe49, 0x1dcf, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    checkSpecialRegisters(0x00, 0x02, false, false, 21);
  });


  // Test instruction ee
  test('ee', () {
    // Set up machine initial state
    loadRegisters(0x3e00, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xee);
    poke(0x0001, 0xd0);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xeeac, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction ef
  test('ef', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5507, 0x6d33);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x6d33, 0xef);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5505, 0x0028);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
    expect(peek(21765), equals(0x34));
    expect(peek(21766), equals(0x6d));
  });


  // Test instruction f0_1
  test('f0_1', () {
    // Set up machine initial state
    loadRegisters(0x0018, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f7, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xf0);
    poke(0x43f7, 0xe9);
    poke(0x43f8, 0xaf);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0018, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f9, 0xafe9);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
  });


  // Test instruction f0_2
  test('f0_2', () {
    // Set up machine initial state
    loadRegisters(0x0098, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f7, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xf0);
    poke(0x43f7, 0xe9);
    poke(0x43f8, 0xaf);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0098, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f7, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 5);
  });


  // Test instruction f1
  test('f1', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x4143, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xf1);
    poke(0x4143, 0xce);
    poke(0x4144, 0xe8);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe8ce, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x4145, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction f2_1
  test('f2_1', () {
    // Set up machine initial state
    loadRegisters(0x0007, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xf2);
    poke(0x0001, 0x1b);
    poke(0x0002, 0xe1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0007, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xe11b);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction f2_2
  test('f2_2', () {
    // Set up machine initial state
    loadRegisters(0x0087, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xf2);
    poke(0x0001, 0x1b);
    poke(0x0002, 0xe1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0087, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction f3
  test('f3', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = true;
    z80.iff2 = true;
    poke(0x0000, 0xf3);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 4);
  });


  // Test instruction f4_1
  test('f4_1', () {
    // Set up machine initial state
    loadRegisters(0x000e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5698, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xf4);
    poke(0x0001, 0x61);
    poke(0x0002, 0x9c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x000e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5696, 0x9c61);
    checkSpecialRegisters(0x00, 0x01, false, false, 17);
    expect(peek(22166), equals(0x03));
    expect(peek(22167), equals(0x00));
  });


  // Test instruction f4_2
  test('f4_2', () {
    // Set up machine initial state
    loadRegisters(0x008e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5698, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xf4);
    poke(0x0001, 0x61);
    poke(0x0002, 0x9c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x008e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5698, 0x0003);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction f5
  test('f5', () {
    // Set up machine initial state
    loadRegisters(0x53e3, 0x1459, 0x775f, 0x1a2f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xec12, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xf5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x53e3, 0x1459, 0x775f, 0x1a2f, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xec10, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
    expect(peek(60432), equals(0xe3));
    expect(peek(60433), equals(0x53));
  });


  // Test instruction f6
  test('f6', () {
    // Set up machine initial state
    loadRegisters(0x0600, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xf6);
    poke(0x0001, 0xa7);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa7a0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction f7
  test('f7', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5507, 0x6d33);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x6d33, 0xf7);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5505, 0x0030);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
    expect(peek(21765), equals(0x34));
    expect(peek(21766), equals(0x6d));
  });


  // Test instruction f8_1
  test('f8_1', () {
    // Set up machine initial state
    loadRegisters(0x0018, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f7, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xf8);
    poke(0x43f7, 0xe9);
    poke(0x43f8, 0xaf);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0018, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f7, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 5);
  });


  // Test instruction f8_2
  test('f8_2', () {
    // Set up machine initial state
    loadRegisters(0x0098, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f7, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xf8);
    poke(0x43f7, 0xe9);
    poke(0x43f8, 0xaf);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0098, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x43f9, 0xafe9);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
  });


  // Test instruction f9
  test('f9', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0xce32, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xf9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0xce32, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xce32, 0x0001);
    checkSpecialRegisters(0x00, 0x01, false, false, 6);
  });


  // Test instruction fa_1
  test('fa_1', () {
    // Set up machine initial state
    loadRegisters(0x0087, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfa);
    poke(0x0001, 0x1b);
    poke(0x0002, 0xe1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0087, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xe11b);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction fa_2
  test('fa_2', () {
    // Set up machine initial state
    loadRegisters(0x0007, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfa);
    poke(0x0001, 0x1b);
    poke(0x0002, 0xe1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0007, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction fb
  test('fb', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfb);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0001);
    checkSpecialRegisters(0x00, 0x01, true, true, 4);
  });


  // Test instruction fc_1
  test('fc_1', () {
    // Set up machine initial state
    loadRegisters(0x008e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5698, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfc);
    poke(0x0001, 0x61);
    poke(0x0002, 0x9c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x008e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5696, 0x9c61);
    checkSpecialRegisters(0x00, 0x01, false, false, 17);
    expect(peek(22166), equals(0x03));
    expect(peek(22167), equals(0x00));
  });


  // Test instruction fc_2
  test('fc_2', () {
    // Set up machine initial state
    loadRegisters(0x000e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5698, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfc);
    poke(0x0001, 0x61);
    poke(0x0002, 0x9c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x000e, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5698, 0x0003);
    checkSpecialRegisters(0x00, 0x01, false, false, 10);
  });


  // Test instruction fd09
  test('fd09', () {
    // Set up machine initial state
    loadRegisters(0x466a, 0xa623, 0xbab2, 0xd788, 0x0000, 0x0000, 0x0000, 0x0000, 0xc9e8, 0xf698, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x09);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4649, 0xa623, 0xbab2, 0xd788, 0x0000, 0x0000, 0x0000, 0x0000, 0xc9e8, 0x9cbb, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
  });


  // Test instruction fd19
  test('fd19', () {
    // Set up machine initial state
    loadRegisters(0xb3e5, 0x5336, 0x76cb, 0x54e2, 0x0000, 0x0000, 0x0000, 0x0000, 0xb9ce, 0x8624, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x19);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb3ec, 0x5336, 0x76cb, 0x54e2, 0x0000, 0x0000, 0x0000, 0x0000, 0xb9ce, 0xfcef, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
  });


  // Test instruction fd21
  test('fd21', () {
    // Set up machine initial state
    loadRegisters(0xc924, 0x5c83, 0xe0e2, 0xeddb, 0x0000, 0x0000, 0x0000, 0x0000, 0x6e9f, 0xba55, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x21);
    poke(0x0002, 0x46);
    poke(0x0003, 0x47);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc924, 0x5c83, 0xe0e2, 0xeddb, 0x0000, 0x0000, 0x0000, 0x0000, 0x6e9f, 0x4746, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 14);
  });


  // Test instruction fd22
  test('fd22', () {
    // Set up machine initial state
    loadRegisters(0x1235, 0xf0b6, 0xb74c, 0xcc9f, 0x0000, 0x0000, 0x0000, 0x0000, 0x8b00, 0x81e4, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x22);
    poke(0x0002, 0x9a);
    poke(0x0003, 0xe2);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1235, 0xf0b6, 0xb74c, 0xcc9f, 0x0000, 0x0000, 0x0000, 0x0000, 0x8b00, 0x81e4, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
    expect(peek(58010), equals(0xe4));
    expect(peek(58011), equals(0x81));
  });


  // Test instruction fd23
  test('fd23', () {
    // Set up machine initial state
    loadRegisters(0x69f2, 0xc1d3, 0x0f6f, 0x2169, 0x0000, 0x0000, 0x0000, 0x0000, 0xe39e, 0x2605, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x23);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x69f2, 0xc1d3, 0x0f6f, 0x2169, 0x0000, 0x0000, 0x0000, 0x0000, 0xe39e, 0x2606, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 10);
  });


  // Test instruction fd24
  test('fd24', () {
    // Set up machine initial state
    loadRegisters(0x5554, 0x9684, 0xd36a, 0xdac3, 0x0000, 0x0000, 0x0000, 0x0000, 0x7803, 0x6434, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x24);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5520, 0x9684, 0xd36a, 0xdac3, 0x0000, 0x0000, 0x0000, 0x0000, 0x7803, 0x6534, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd25
  test('fd25', () {
    // Set up machine initial state
    loadRegisters(0xcd0b, 0xb5e4, 0xa754, 0x9526, 0x0000, 0x0000, 0x0000, 0x0000, 0x3dcb, 0x03b2, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x25);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xcd03, 0xb5e4, 0xa754, 0x9526, 0x0000, 0x0000, 0x0000, 0x0000, 0x3dcb, 0x02b2, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd26
  test('fd26', () {
    // Set up machine initial state
    loadRegisters(0x2452, 0x300b, 0xb4a1, 0x929d, 0x0000, 0x0000, 0x0000, 0x0000, 0xc259, 0x3f30, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x26);
    poke(0x0002, 0x77);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2452, 0x300b, 0xb4a1, 0x929d, 0x0000, 0x0000, 0x0000, 0x0000, 0xc259, 0x7730, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 11);
  }, tags: 'undocumented');


  // Test instruction fd29
  test('fd29', () {
    // Set up machine initial state
    loadRegisters(0x5812, 0x49d0, 0xec95, 0x011c, 0x0000, 0x0000, 0x0000, 0x0000, 0xec6c, 0x594c, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x29);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5830, 0x49d0, 0xec95, 0x011c, 0x0000, 0x0000, 0x0000, 0x0000, 0xec6c, 0xb298, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
  });


  // Test instruction fd2a
  test('fd2a', () {
    // Set up machine initial state
    loadRegisters(0x0f82, 0x3198, 0x87e3, 0x7c1c, 0x0000, 0x0000, 0x0000, 0x0000, 0x1bb4, 0xeb1a, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x2a);
    poke(0x0002, 0x91);
    poke(0x0003, 0xf9);
    poke(0xf991, 0x92);
    poke(0xf992, 0xbf);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0f82, 0x3198, 0x87e3, 0x7c1c, 0x0000, 0x0000, 0x0000, 0x0000, 0x1bb4, 0xbf92, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  });


  // Test instruction fd2b
  test('fd2b', () {
    // Set up machine initial state
    loadRegisters(0xab27, 0x942f, 0x82fa, 0x6f2f, 0x0000, 0x0000, 0x0000, 0x0000, 0x9438, 0xebbc, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x2b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xab27, 0x942f, 0x82fa, 0x6f2f, 0x0000, 0x0000, 0x0000, 0x0000, 0x9438, 0xebbb, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 10);
  });


  // Test instruction fd2c
  test('fd2c', () {
    // Set up machine initial state
    loadRegisters(0x665d, 0x0ab1, 0x5656, 0xe5a9, 0x0000, 0x0000, 0x0000, 0x0000, 0x5fb9, 0x4df7, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x2c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x66a9, 0x0ab1, 0x5656, 0xe5a9, 0x0000, 0x0000, 0x0000, 0x0000, 0x5fb9, 0x4df8, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd2d
  test('fd2d', () {
    // Set up machine initial state
    loadRegisters(0x32fb, 0xf78a, 0xb906, 0x31d0, 0x0000, 0x0000, 0x0000, 0x0000, 0xc72a, 0xe91c, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x2d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x320b, 0xf78a, 0xb906, 0x31d0, 0x0000, 0x0000, 0x0000, 0x0000, 0xc72a, 0xe91b, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd2e
  test('fd2e', () {
    // Set up machine initial state
    loadRegisters(0x2114, 0x4923, 0x6e65, 0x006c, 0x0000, 0x0000, 0x0000, 0x0000, 0xda39, 0xc0cb, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x2e);
    poke(0x0002, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2114, 0x4923, 0x6e65, 0x006c, 0x0000, 0x0000, 0x0000, 0x0000, 0xda39, 0xc049, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 11);
  }, tags: 'undocumented');


  // Test instruction fd34
  test('fd34', () {
    // Set up machine initial state
    loadRegisters(0xd56a, 0x6f24, 0x7df7, 0x74f0, 0x0000, 0x0000, 0x0000, 0x0000, 0x365a, 0xefc4, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x34);
    poke(0x0002, 0xb8);
    poke(0xef7c, 0xe0);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd5a0, 0x6f24, 0x7df7, 0x74f0, 0x0000, 0x0000, 0x0000, 0x0000, 0x365a, 0xefc4, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(61308), equals(0xe1));
  });


  // Test instruction fd35
  test('fd35', () {
    // Set up machine initial state
    loadRegisters(0x8cda, 0x35d8, 0x7c1a, 0x1c0a, 0x0000, 0x0000, 0x0000, 0x0000, 0x62bb, 0xaec6, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x35);
    poke(0x0002, 0xab);
    poke(0xae71, 0xa6);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8ca2, 0x35d8, 0x7c1a, 0x1c0a, 0x0000, 0x0000, 0x0000, 0x0000, 0x62bb, 0xaec6, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(44657), equals(0xa5));
  });


  // Test instruction fd36
  test('fd36', () {
    // Set up machine initial state
    loadRegisters(0xe0f9, 0xae1f, 0x4aef, 0xc9d5, 0x0000, 0x0000, 0x0000, 0x0000, 0xc0db, 0xbdd4, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x36);
    poke(0x0002, 0x81);
    poke(0x0003, 0xc5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe0f9, 0xae1f, 0x4aef, 0xc9d5, 0x0000, 0x0000, 0x0000, 0x0000, 0xc0db, 0xbdd4, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
    expect(peek(48469), equals(0xc5));
  });


  // Test instruction fd39
  test('fd39', () {
    // Set up machine initial state
    loadRegisters(0x2603, 0x726f, 0x9c7f, 0xcd46, 0x0000, 0x0000, 0x0000, 0x0000, 0xdc45, 0x54d5, 0xdc57, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x39);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2631, 0x726f, 0x9c7f, 0xcd46, 0x0000, 0x0000, 0x0000, 0x0000, 0xdc45, 0x312c, 0xdc57, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
  });


  // Test instruction fd44
  test('fd44', () {
    // Set up machine initial state
    loadRegisters(0x0e58, 0x7192, 0x3580, 0x9be4, 0x0000, 0x0000, 0x0000, 0x0000, 0x1b79, 0x685e, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x44);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0e58, 0x6892, 0x3580, 0x9be4, 0x0000, 0x0000, 0x0000, 0x0000, 0x1b79, 0x685e, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd45
  test('fd45', () {
    // Set up machine initial state
    loadRegisters(0x6555, 0xa488, 0x5ae8, 0xc948, 0x0000, 0x0000, 0x0000, 0x0000, 0xd7b8, 0xa177, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x45);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6555, 0x7788, 0x5ae8, 0xc948, 0x0000, 0x0000, 0x0000, 0x0000, 0xd7b8, 0xa177, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd46
  test('fd46', () {
    // Set up machine initial state
    loadRegisters(0x87f3, 0x17d5, 0x5eea, 0x830b, 0x0000, 0x0000, 0x0000, 0x0000, 0xdcee, 0x3afc, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x46);
    poke(0x0002, 0x4d);
    poke(0x3b49, 0xc9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x87f3, 0xc9d5, 0x5eea, 0x830b, 0x0000, 0x0000, 0x0000, 0x0000, 0xdcee, 0x3afc, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
  });


  // Test instruction fd4c
  test('fd4c', () {
    // Set up machine initial state
    loadRegisters(0x7e6b, 0xbd4b, 0x24b6, 0xff94, 0x0000, 0x0000, 0x0000, 0x0000, 0x862d, 0x01d0, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x4c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7e6b, 0xbd01, 0x24b6, 0xff94, 0x0000, 0x0000, 0x0000, 0x0000, 0x862d, 0x01d0, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd4d
  test('fd4d', () {
    // Set up machine initial state
    loadRegisters(0x50cf, 0xe3fe, 0x998e, 0xdba2, 0x0000, 0x0000, 0x0000, 0x0000, 0xc4f5, 0xc7c9, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x4d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x50cf, 0xe3c9, 0x998e, 0xdba2, 0x0000, 0x0000, 0x0000, 0x0000, 0xc4f5, 0xc7c9, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd4e
  test('fd4e', () {
    // Set up machine initial state
    loadRegisters(0x2c0f, 0x69d7, 0x748a, 0x9290, 0x0000, 0x0000, 0x0000, 0x0000, 0x904f, 0xbb9a, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x4e);
    poke(0x0002, 0x67);
    poke(0xbc01, 0x9d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2c0f, 0x699d, 0x748a, 0x9290, 0x0000, 0x0000, 0x0000, 0x0000, 0x904f, 0xbb9a, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
  });


  // Test instruction fd54
  test('fd54', () {
    // Set up machine initial state
    loadRegisters(0xd7f9, 0xf65b, 0xb001, 0xd4c4, 0x0000, 0x0000, 0x0000, 0x0000, 0x4b8e, 0xd437, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x54);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd7f9, 0xf65b, 0xd401, 0xd4c4, 0x0000, 0x0000, 0x0000, 0x0000, 0x4b8e, 0xd437, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd55
  test('fd55', () {
    // Set up machine initial state
    loadRegisters(0xab98, 0xfdab, 0x254a, 0x010e, 0x0000, 0x0000, 0x0000, 0x0000, 0x126b, 0x13a9, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x55);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xab98, 0xfdab, 0xa94a, 0x010e, 0x0000, 0x0000, 0x0000, 0x0000, 0x126b, 0x13a9, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd56
  test('fd56', () {
    // Set up machine initial state
    loadRegisters(0xd3e8, 0xdf10, 0x5442, 0xb641, 0x0000, 0x0000, 0x0000, 0x0000, 0xa5a0, 0xfda2, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x56);
    poke(0x0002, 0xce);
    poke(0xfd70, 0x78);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd3e8, 0xdf10, 0x7842, 0xb641, 0x0000, 0x0000, 0x0000, 0x0000, 0xa5a0, 0xfda2, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
  });


  // Test instruction fd5c
  test('fd5c', () {
    // Set up machine initial state
    loadRegisters(0x11d5, 0xc489, 0xe220, 0x434e, 0x0000, 0x0000, 0x0000, 0x0000, 0x3244, 0xd8bb, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x5c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x11d5, 0xc489, 0xe2d8, 0x434e, 0x0000, 0x0000, 0x0000, 0x0000, 0x3244, 0xd8bb, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd5d
  test('fd5d', () {
    // Set up machine initial state
    loadRegisters(0xe945, 0xdbae, 0x32ea, 0x4f7e, 0x0000, 0x0000, 0x0000, 0x0000, 0xfa56, 0x074e, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x5d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe945, 0xdbae, 0x324e, 0x4f7e, 0x0000, 0x0000, 0x0000, 0x0000, 0xfa56, 0x074e, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd5e
  test('fd5e', () {
    // Set up machine initial state
    loadRegisters(0x6f3b, 0xe9dc, 0x7a06, 0x14f3, 0x0000, 0x0000, 0x0000, 0x0000, 0xec76, 0x8aaa, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x5e);
    poke(0x0002, 0xc6);
    poke(0x8a70, 0x8c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6f3b, 0xe9dc, 0x7a8c, 0x14f3, 0x0000, 0x0000, 0x0000, 0x0000, 0xec76, 0x8aaa, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
  });


  // Test instruction fd60
  test('fd60', () {
    // Set up machine initial state
    loadRegisters(0x8579, 0x005d, 0xd9ee, 0xfaee, 0x0000, 0x0000, 0x0000, 0x0000, 0x382d, 0x2f95, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x60);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8579, 0x005d, 0xd9ee, 0xfaee, 0x0000, 0x0000, 0x0000, 0x0000, 0x382d, 0x0095, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd61
  test('fd61', () {
    // Set up machine initial state
    loadRegisters(0x5682, 0xdbc3, 0xb495, 0x9799, 0x0000, 0x0000, 0x0000, 0x0000, 0x85b2, 0x3c1e, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x61);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5682, 0xdbc3, 0xb495, 0x9799, 0x0000, 0x0000, 0x0000, 0x0000, 0x85b2, 0xc31e, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd62
  test('fd62', () {
    // Set up machine initial state
    loadRegisters(0x906b, 0xf52e, 0xf3d8, 0x1e8c, 0x0000, 0x0000, 0x0000, 0x0000, 0xddba, 0x9a02, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x62);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x906b, 0xf52e, 0xf3d8, 0x1e8c, 0x0000, 0x0000, 0x0000, 0x0000, 0xddba, 0xf302, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd63
  test('fd63', () {
    // Set up machine initial state
    loadRegisters(0x9d59, 0xbeb9, 0xd826, 0x0eaa, 0x0000, 0x0000, 0x0000, 0x0000, 0x4290, 0xa4b9, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x63);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9d59, 0xbeb9, 0xd826, 0x0eaa, 0x0000, 0x0000, 0x0000, 0x0000, 0x4290, 0x26b9, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd64
  test('fd64', () {
    // Set up machine initial state
    loadRegisters(0x7b0e, 0xe394, 0x8a25, 0xcddf, 0x0000, 0x0000, 0x0000, 0x0000, 0x9784, 0x2116, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x64);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7b0e, 0xe394, 0x8a25, 0xcddf, 0x0000, 0x0000, 0x0000, 0x0000, 0x9784, 0x2116, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd65
  test('fd65', () {
    // Set up machine initial state
    loadRegisters(0xb827, 0xeb4f, 0xf666, 0xc52a, 0x0000, 0x0000, 0x0000, 0x0000, 0x6206, 0x831f, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x65);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb827, 0xeb4f, 0xf666, 0xc52a, 0x0000, 0x0000, 0x0000, 0x0000, 0x6206, 0x1f1f, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd66
  test('fd66', () {
    // Set up machine initial state
    loadRegisters(0x9129, 0xe4ee, 0xe3a3, 0x86ca, 0x0000, 0x0000, 0x0000, 0x0000, 0x4d93, 0x5b24, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x66);
    poke(0x0002, 0x80);
    poke(0x5aa4, 0x77);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9129, 0xe4ee, 0xe3a3, 0x77ca, 0x0000, 0x0000, 0x0000, 0x0000, 0x4d93, 0x5b24, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
  });


  // Test instruction fd67
  test('fd67', () {
    // Set up machine initial state
    loadRegisters(0xdb7a, 0xb40b, 0x7b58, 0x49fd, 0x0000, 0x0000, 0x0000, 0x0000, 0x266f, 0x9e7b, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x67);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xdb7a, 0xb40b, 0x7b58, 0x49fd, 0x0000, 0x0000, 0x0000, 0x0000, 0x266f, 0xdb7b, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd68
  test('fd68', () {
    // Set up machine initial state
    loadRegisters(0x4d1d, 0x4fd9, 0x783e, 0x0745, 0x0000, 0x0000, 0x0000, 0x0000, 0x0c3d, 0x82b5, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x68);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4d1d, 0x4fd9, 0x783e, 0x0745, 0x0000, 0x0000, 0x0000, 0x0000, 0x0c3d, 0x824f, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd69
  test('fd69', () {
    // Set up machine initial state
    loadRegisters(0x1589, 0x5ceb, 0xb5db, 0x922a, 0x0000, 0x0000, 0x0000, 0x0000, 0x3c3a, 0xdc98, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x69);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1589, 0x5ceb, 0xb5db, 0x922a, 0x0000, 0x0000, 0x0000, 0x0000, 0x3c3a, 0xdceb, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd6a
  test('fd6a', () {
    // Set up machine initial state
    loadRegisters(0x607a, 0xe035, 0x5bb9, 0xdac0, 0x0000, 0x0000, 0x0000, 0x0000, 0xfc04, 0xb5b7, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x6a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x607a, 0xe035, 0x5bb9, 0xdac0, 0x0000, 0x0000, 0x0000, 0x0000, 0xfc04, 0xb55b, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd6b
  test('fd6b', () {
    // Set up machine initial state
    loadRegisters(0xdb2a, 0xe244, 0x1182, 0x096f, 0x0000, 0x0000, 0x0000, 0x0000, 0x198e, 0x91a6, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x6b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xdb2a, 0xe244, 0x1182, 0x096f, 0x0000, 0x0000, 0x0000, 0x0000, 0x198e, 0x9182, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd6c
  test('fd6c', () {
    // Set up machine initial state
    loadRegisters(0xa0be, 0x34ef, 0x8fcd, 0x40a7, 0x0000, 0x0000, 0x0000, 0x0000, 0x4481, 0xc215, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x6c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa0be, 0x34ef, 0x8fcd, 0x40a7, 0x0000, 0x0000, 0x0000, 0x0000, 0x4481, 0xc2c2, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd6d
  test('fd6d', () {
    // Set up machine initial state
    loadRegisters(0xfdfc, 0x727a, 0xb839, 0x50a6, 0x0000, 0x0000, 0x0000, 0x0000, 0xe782, 0x02e5, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x6d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xfdfc, 0x727a, 0xb839, 0x50a6, 0x0000, 0x0000, 0x0000, 0x0000, 0xe782, 0x02e5, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd6e
  test('fd6e', () {
    // Set up machine initial state
    loadRegisters(0xcfd4, 0x6ef1, 0xc07d, 0xeb96, 0x0000, 0x0000, 0x0000, 0x0000, 0xb0f9, 0xb0a3, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x6e);
    poke(0x0002, 0x78);
    poke(0xb11b, 0xf8);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xcfd4, 0x6ef1, 0xc07d, 0xebf8, 0x0000, 0x0000, 0x0000, 0x0000, 0xb0f9, 0xb0a3, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
  });


  // Test instruction fd6f
  test('fd6f', () {
    // Set up machine initial state
    loadRegisters(0x8e1d, 0xa138, 0xf20a, 0x298e, 0x0000, 0x0000, 0x0000, 0x0000, 0xb600, 0x0cf7, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x6f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8e1d, 0xa138, 0xf20a, 0x298e, 0x0000, 0x0000, 0x0000, 0x0000, 0xb600, 0x0c8e, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd70
  test('fd70', () {
    // Set up machine initial state
    loadRegisters(0x2677, 0x33c5, 0xc0dc, 0x262f, 0x0000, 0x0000, 0x0000, 0x0000, 0xd3dc, 0x23a1, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x70);
    poke(0x0002, 0x53);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2677, 0x33c5, 0xc0dc, 0x262f, 0x0000, 0x0000, 0x0000, 0x0000, 0xd3dc, 0x23a1, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
    expect(peek(9204), equals(0x33));
  });


  // Test instruction fd71
  test('fd71', () {
    // Set up machine initial state
    loadRegisters(0x892e, 0x04ae, 0xd67f, 0x81ec, 0x0000, 0x0000, 0x0000, 0x0000, 0x7757, 0xbfab, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x71);
    poke(0x0002, 0xb4);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x892e, 0x04ae, 0xd67f, 0x81ec, 0x0000, 0x0000, 0x0000, 0x0000, 0x7757, 0xbfab, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
    expect(peek(48991), equals(0xae));
  });


  // Test instruction fd72
  test('fd72', () {
    // Set up machine initial state
    loadRegisters(0xd2dc, 0xc23c, 0xdd54, 0x6559, 0x0000, 0x0000, 0x0000, 0x0000, 0xb32b, 0x7c80, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x72);
    poke(0x0002, 0xe3);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd2dc, 0xc23c, 0xdd54, 0x6559, 0x0000, 0x0000, 0x0000, 0x0000, 0xb32b, 0x7c80, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
    expect(peek(31843), equals(0xdd));
  });


  // Test instruction fd73
  test('fd73', () {
    // Set up machine initial state
    loadRegisters(0x49ef, 0xbff2, 0x8409, 0x02dd, 0x0000, 0x0000, 0x0000, 0x0000, 0xaf95, 0x8762, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x73);
    poke(0x0002, 0x17);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x49ef, 0xbff2, 0x8409, 0x02dd, 0x0000, 0x0000, 0x0000, 0x0000, 0xaf95, 0x8762, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
    expect(peek(34681), equals(0x09));
  });


  // Test instruction fd74
  test('fd74', () {
    // Set up machine initial state
    loadRegisters(0x9479, 0x9817, 0xfa2e, 0x1fe0, 0x0000, 0x0000, 0x0000, 0x0000, 0xa395, 0x92db, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x74);
    poke(0x0002, 0xf6);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9479, 0x9817, 0xfa2e, 0x1fe0, 0x0000, 0x0000, 0x0000, 0x0000, 0xa395, 0x92db, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
    expect(peek(37585), equals(0x1f));
  });


  // Test instruction fd75
  test('fd75', () {
    // Set up machine initial state
    loadRegisters(0xc8d6, 0x6aa4, 0x180e, 0xe37b, 0x0000, 0x0000, 0x0000, 0x0000, 0x02cf, 0x1724, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x75);
    poke(0x0002, 0xab);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc8d6, 0x6aa4, 0x180e, 0xe37b, 0x0000, 0x0000, 0x0000, 0x0000, 0x02cf, 0x1724, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
    expect(peek(5839), equals(0x7b));
  });


  // Test instruction fd77
  test('fd77', () {
    // Set up machine initial state
    loadRegisters(0x6f9e, 0x7475, 0x78ad, 0x2b8c, 0x0000, 0x0000, 0x0000, 0x0000, 0xc6b7, 0x6b4d, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x77);
    poke(0x0002, 0xf7);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6f9e, 0x7475, 0x78ad, 0x2b8c, 0x0000, 0x0000, 0x0000, 0x0000, 0xc6b7, 0x6b4d, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
    expect(peek(27460), equals(0x6f));
  });


  // Test instruction fd7c
  test('fd7c', () {
    // Set up machine initial state
    loadRegisters(0xf228, 0x93fc, 0xa3d4, 0xdc9e, 0x0000, 0x0000, 0x0000, 0x0000, 0x21ac, 0xc617, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x7c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc628, 0x93fc, 0xa3d4, 0xdc9e, 0x0000, 0x0000, 0x0000, 0x0000, 0x21ac, 0xc617, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd7d
  test('fd7d', () {
    // Set up machine initial state
    loadRegisters(0x93e5, 0x3cbe, 0x02c3, 0x26c2, 0x0000, 0x0000, 0x0000, 0x0000, 0xca81, 0x92b9, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x7d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb9e5, 0x3cbe, 0x02c3, 0x26c2, 0x0000, 0x0000, 0x0000, 0x0000, 0xca81, 0x92b9, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd7e
  test('fd7e', () {
    // Set up machine initial state
    loadRegisters(0x1596, 0xdaba, 0x147b, 0xf362, 0x0000, 0x0000, 0x0000, 0x0000, 0x7110, 0xd45f, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x7e);
    poke(0x0002, 0xe4);
    poke(0xd443, 0xaa);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xaa96, 0xdaba, 0x147b, 0xf362, 0x0000, 0x0000, 0x0000, 0x0000, 0x7110, 0xd45f, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
  });


  // Test instruction fd84
  test('fd84', () {
    // Set up machine initial state
    loadRegisters(0xbfba, 0x7cae, 0xc4da, 0x7aee, 0x0000, 0x0000, 0x0000, 0x0000, 0x43ee, 0xc08e, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x84);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7f2d, 0x7cae, 0xc4da, 0x7aee, 0x0000, 0x0000, 0x0000, 0x0000, 0x43ee, 0xc08e, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd85
  test('fd85', () {
    // Set up machine initial state
    loadRegisters(0x52dd, 0x1dea, 0x324f, 0x84e7, 0x0000, 0x0000, 0x0000, 0x0000, 0xe7a8, 0xf799, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x85);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xeba8, 0x1dea, 0x324f, 0x84e7, 0x0000, 0x0000, 0x0000, 0x0000, 0xe7a8, 0xf799, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd86
  test('fd86', () {
    // Set up machine initial state
    loadRegisters(0xfc9c, 0xb882, 0x43f9, 0x3e15, 0x0000, 0x0000, 0x0000, 0x0000, 0x9781, 0x8b33, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x86);
    poke(0x0002, 0xce);
    poke(0x8b01, 0xe1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xdd89, 0xb882, 0x43f9, 0x3e15, 0x0000, 0x0000, 0x0000, 0x0000, 0x9781, 0x8b33, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
  });


  // Test instruction fd8c
  test('fd8c', () {
    // Set up machine initial state
    loadRegisters(0xfd9c, 0x42b1, 0x5e8a, 0x081c, 0x0000, 0x0000, 0x0000, 0x0000, 0xcb58, 0x3b4e, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x8c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3839, 0x42b1, 0x5e8a, 0x081c, 0x0000, 0x0000, 0x0000, 0x0000, 0xcb58, 0x3b4e, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd8d
  test('fd8d', () {
    // Set up machine initial state
    loadRegisters(0x9301, 0x7750, 0x8ad6, 0x295c, 0x0000, 0x0000, 0x0000, 0x0000, 0x695c, 0x99fb, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x8d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8f89, 0x7750, 0x8ad6, 0x295c, 0x0000, 0x0000, 0x0000, 0x0000, 0x695c, 0x99fb, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd8e
  test('fd8e', () {
    // Set up machine initial state
    loadRegisters(0x41ee, 0x398f, 0xf6dc, 0x06f3, 0x0000, 0x0000, 0x0000, 0x0000, 0xf34a, 0x1aa2, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x8e);
    poke(0x0002, 0x78);
    poke(0x1b1a, 0xc0);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0101, 0x398f, 0xf6dc, 0x06f3, 0x0000, 0x0000, 0x0000, 0x0000, 0xf34a, 0x1aa2, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
  });


  // Test instruction fd94
  test('fd94', () {
    // Set up machine initial state
    loadRegisters(0x0431, 0xd255, 0xb9d6, 0x20bb, 0x0000, 0x0000, 0x0000, 0x0000, 0x1e6a, 0xd5ef, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x94);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2f3b, 0xd255, 0xb9d6, 0x20bb, 0x0000, 0x0000, 0x0000, 0x0000, 0x1e6a, 0xd5ef, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd95
  test('fd95', () {
    // Set up machine initial state
    loadRegisters(0x8b5d, 0xb455, 0x2388, 0xec1e, 0x0000, 0x0000, 0x0000, 0x0000, 0x7637, 0xcb97, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x95);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf4a3, 0xb455, 0x2388, 0xec1e, 0x0000, 0x0000, 0x0000, 0x0000, 0x7637, 0xcb97, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd96
  test('fd96', () {
    // Set up machine initial state
    loadRegisters(0xa0c6, 0x22ac, 0x0413, 0x4b13, 0x0000, 0x0000, 0x0000, 0x0000, 0xb44e, 0xc08b, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x96);
    poke(0x0002, 0x55);
    poke(0xc0e0, 0x7b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2536, 0x22ac, 0x0413, 0x4b13, 0x0000, 0x0000, 0x0000, 0x0000, 0xb44e, 0xc08b, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
  });


  // Test instruction fd9c
  test('fd9c', () {
    // Set up machine initial state
    loadRegisters(0xa44a, 0x3ecf, 0xced3, 0x66ec, 0x0000, 0x0000, 0x0000, 0x0000, 0x4bff, 0xb133, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x9c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf3a3, 0x3ecf, 0xced3, 0x66ec, 0x0000, 0x0000, 0x0000, 0x0000, 0x4bff, 0xb133, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd9d
  test('fd9d', () {
    // Set up machine initial state
    loadRegisters(0x06c0, 0x8bd0, 0x131b, 0x3094, 0x0000, 0x0000, 0x0000, 0x0000, 0xafc3, 0x7409, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x9d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xfdbb, 0x8bd0, 0x131b, 0x3094, 0x0000, 0x0000, 0x0000, 0x0000, 0xafc3, 0x7409, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fd9e
  test('fd9e', () {
    // Set up machine initial state
    loadRegisters(0xb983, 0x981f, 0xbb8e, 0xd6d5, 0x0000, 0x0000, 0x0000, 0x0000, 0x5c3b, 0xf66c, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0x9e);
    poke(0x0002, 0xf9);
    poke(0xf665, 0xf3);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc583, 0x981f, 0xbb8e, 0xd6d5, 0x0000, 0x0000, 0x0000, 0x0000, 0x5c3b, 0xf66c, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
  });


  // Test instruction fda4
  test('fda4', () {
    // Set up machine initial state
    loadRegisters(0xb079, 0x79c0, 0x2c7c, 0x3e06, 0x0000, 0x0000, 0x0000, 0x0000, 0x7399, 0x037a, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xa4);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0054, 0x79c0, 0x2c7c, 0x3e06, 0x0000, 0x0000, 0x0000, 0x0000, 0x7399, 0x037a, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fda5
  test('fda5', () {
    // Set up machine initial state
    loadRegisters(0x01d2, 0x654d, 0x9653, 0x2b33, 0x0000, 0x0000, 0x0000, 0x0000, 0x61a4, 0x8f88, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xa5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0054, 0x654d, 0x9653, 0x2b33, 0x0000, 0x0000, 0x0000, 0x0000, 0x61a4, 0x8f88, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fda6
  test('fda6', () {
    // Set up machine initial state
    loadRegisters(0xddb8, 0x40bb, 0x3742, 0x6ff1, 0x0000, 0x0000, 0x0000, 0x0000, 0xad28, 0x659b, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xa6);
    poke(0x0002, 0x53);
    poke(0x65ee, 0x95);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9594, 0x40bb, 0x3742, 0x6ff1, 0x0000, 0x0000, 0x0000, 0x0000, 0xad28, 0x659b, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
  });


  // Test instruction fdac
  test('fdac', () {
    // Set up machine initial state
    loadRegisters(0x7a43, 0x72e3, 0xdd4d, 0x1b62, 0x0000, 0x0000, 0x0000, 0x0000, 0x4753, 0x5d63, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xac);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2724, 0x72e3, 0xdd4d, 0x1b62, 0x0000, 0x0000, 0x0000, 0x0000, 0x4753, 0x5d63, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fdad
  test('fdad', () {
    // Set up machine initial state
    loadRegisters(0x7d8e, 0x2573, 0x19cc, 0x78fb, 0x0000, 0x0000, 0x0000, 0x0000, 0x5248, 0x8391, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xad);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xeca8, 0x2573, 0x19cc, 0x78fb, 0x0000, 0x0000, 0x0000, 0x0000, 0x5248, 0x8391, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fdae
  test('fdae', () {
    // Set up machine initial state
    loadRegisters(0xa0da, 0xbc27, 0x257b, 0x5489, 0x0000, 0x0000, 0x0000, 0x0000, 0xfa59, 0x81f8, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xae);
    poke(0x0002, 0x09);
    poke(0x8201, 0xcb);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6b28, 0xbc27, 0x257b, 0x5489, 0x0000, 0x0000, 0x0000, 0x0000, 0xfa59, 0x81f8, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
  });


  // Test instruction fdb4
  test('fdb4', () {
    // Set up machine initial state
    loadRegisters(0x4f95, 0x3461, 0xf173, 0x8ad3, 0x0000, 0x0000, 0x0000, 0x0000, 0xc1a2, 0x8265, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xb4);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xcf8c, 0x3461, 0xf173, 0x8ad3, 0x0000, 0x0000, 0x0000, 0x0000, 0xc1a2, 0x8265, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fdb5
  test('fdb5', () {
    // Set up machine initial state
    loadRegisters(0x17f6, 0xe6ea, 0xf919, 0x327c, 0x0000, 0x0000, 0x0000, 0x0000, 0x4299, 0x9733, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xb5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3720, 0xe6ea, 0xf919, 0x327c, 0x0000, 0x0000, 0x0000, 0x0000, 0x4299, 0x9733, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fdb6
  test('fdb6', () {
    // Set up machine initial state
    loadRegisters(0xdb37, 0x3509, 0xd6ca, 0xb16a, 0x0000, 0x0000, 0x0000, 0x0000, 0xa099, 0xdf6d, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xb6);
    poke(0x0002, 0x4b);
    poke(0xdfb8, 0x64);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xffac, 0x3509, 0xd6ca, 0xb16a, 0x0000, 0x0000, 0x0000, 0x0000, 0xa099, 0xdf6d, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
  });


  // Test instruction fdbc
  test('fdbc', () {
    // Set up machine initial state
    loadRegisters(0xb4fc, 0x9302, 0xe35d, 0x31bc, 0x0000, 0x0000, 0x0000, 0x0000, 0x5c12, 0x1c92, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xbc);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb49a, 0x9302, 0xe35d, 0x31bc, 0x0000, 0x0000, 0x0000, 0x0000, 0x5c12, 0x1c92, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fdbd
  test('fdbd', () {
    // Set up machine initial state
    loadRegisters(0x391c, 0x7b82, 0xdfeb, 0x03ee, 0x0000, 0x0000, 0x0000, 0x0000, 0xbe7b, 0xb30f, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xbd);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x391a, 0x7b82, 0xdfeb, 0x03ee, 0x0000, 0x0000, 0x0000, 0x0000, 0xbe7b, 0xb30f, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  }, tags: 'undocumented');


  // Test instruction fdbe
  test('fdbe', () {
    // Set up machine initial state
    loadRegisters(0x0970, 0x0b31, 0xf4ad, 0x9d4c, 0x0000, 0x0000, 0x0000, 0x0000, 0xb95a, 0xa96b, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xbe);
    poke(0x0002, 0x6b);
    poke(0xa9d6, 0xc0);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0903, 0x0b31, 0xf4ad, 0x9d4c, 0x0000, 0x0000, 0x0000, 0x0000, 0xb95a, 0xa96b, 0x0000, 0x0003);
    checkSpecialRegisters(0x00, 0x02, false, false, 19);
  });


  // Test instruction fdcb00
  test('fdcb00', () {
    // Set up machine initial state
    loadRegisters(0x85ac, 0x46d0, 0xa135, 0x20c5, 0x0000, 0x0000, 0x0000, 0x0000, 0xb8de, 0x2776, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x0b);
    poke(0x0003, 0x00);
    poke(0x2781, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x85a4, 0xa0d0, 0xa135, 0x20c5, 0x0000, 0x0000, 0x0000, 0x0000, 0xb8de, 0x2776, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(10113), equals(0xa0));
  }, tags: 'undocumented');


  // Test instruction fdcb01
  test('fdcb01', () {
    // Set up machine initial state
    loadRegisters(0x577c, 0x2b76, 0x3576, 0x280a, 0x0000, 0x0000, 0x0000, 0x0000, 0xae22, 0x5c35, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xc8);
    poke(0x0003, 0x01);
    poke(0x5bfd, 0xcb);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5781, 0x2b97, 0x3576, 0x280a, 0x0000, 0x0000, 0x0000, 0x0000, 0xae22, 0x5c35, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(23549), equals(0x97));
  }, tags: 'undocumented');


  // Test instruction fdcb02
  test('fdcb02', () {
    // Set up machine initial state
    loadRegisters(0xdc23, 0x2b37, 0x83c8, 0x5dd9, 0x0000, 0x0000, 0x0000, 0x0000, 0xb2d2, 0x3df2, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x14);
    poke(0x0003, 0x02);
    poke(0x3e06, 0x58);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xdca0, 0x2b37, 0xb0c8, 0x5dd9, 0x0000, 0x0000, 0x0000, 0x0000, 0xb2d2, 0x3df2, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(15878), equals(0xb0));
  }, tags: 'undocumented');


  // Test instruction fdcb03
  test('fdcb03', () {
    // Set up machine initial state
    loadRegisters(0x57ee, 0xc179, 0xb2b6, 0x7058, 0x0000, 0x0000, 0x0000, 0x0000, 0x3f2e, 0x57e7, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x3a);
    poke(0x0003, 0x03);
    poke(0x5821, 0x1a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5720, 0xc179, 0xb234, 0x7058, 0x0000, 0x0000, 0x0000, 0x0000, 0x3f2e, 0x57e7, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(22561), equals(0x34));
  }, tags: 'undocumented');


  // Test instruction fdcb04
  test('fdcb04', () {
    // Set up machine initial state
    loadRegisters(0xed18, 0x3f03, 0x3327, 0xf35a, 0x0000, 0x0000, 0x0000, 0x0000, 0xcbf2, 0x5071, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x67);
    poke(0x0003, 0x04);
    poke(0x50d8, 0x92);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xed21, 0x3f03, 0x3327, 0x255a, 0x0000, 0x0000, 0x0000, 0x0000, 0xcbf2, 0x5071, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(20696), equals(0x25));
  }, tags: 'undocumented');


  // Test instruction fdcb05
  test('fdcb05', () {
    // Set up machine initial state
    loadRegisters(0x7a39, 0x0858, 0xdb6c, 0xdbe0, 0x0000, 0x0000, 0x0000, 0x0000, 0x157a, 0xb25b, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x1e);
    poke(0x0003, 0x05);
    poke(0xb279, 0x66);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7a8c, 0x0858, 0xdb6c, 0xdbcc, 0x0000, 0x0000, 0x0000, 0x0000, 0x157a, 0xb25b, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(45689), equals(0xcc));
  }, tags: 'undocumented');


  // Test instruction fdcb06
  test('fdcb06', () {
    // Set up machine initial state
    loadRegisters(0xf285, 0x89a2, 0xe78f, 0xef74, 0x0000, 0x0000, 0x0000, 0x0000, 0x140d, 0xff27, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x72);
    poke(0x0003, 0x06);
    poke(0xff99, 0xf1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf2a1, 0x89a2, 0xe78f, 0xef74, 0x0000, 0x0000, 0x0000, 0x0000, 0x140d, 0xff27, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(65433), equals(0xe3));
  });


  // Test instruction fdcb07
  test('fdcb07', () {
    // Set up machine initial state
    loadRegisters(0x8cce, 0xf3a7, 0x3a6e, 0x8f0a, 0x0000, 0x0000, 0x0000, 0x0000, 0x8423, 0x07eb, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x24);
    poke(0x0003, 0x07);
    poke(0x080f, 0xae);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5d09, 0xf3a7, 0x3a6e, 0x8f0a, 0x0000, 0x0000, 0x0000, 0x0000, 0x8423, 0x07eb, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(2063), equals(0x5d));
  }, tags: 'undocumented');


  // Test instruction fdcb08
  test('fdcb08', () {
    // Set up machine initial state
    loadRegisters(0xa611, 0xe8ec, 0xc958, 0x7bda, 0x0000, 0x0000, 0x0000, 0x0000, 0x194d, 0x6137, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x25);
    poke(0x0003, 0x08);
    poke(0x615c, 0x83);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa681, 0xc1ec, 0xc958, 0x7bda, 0x0000, 0x0000, 0x0000, 0x0000, 0x194d, 0x6137, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(24924), equals(0xc1));
  }, tags: 'undocumented');


  // Test instruction fdcb09
  test('fdcb09', () {
    // Set up machine initial state
    loadRegisters(0x54b1, 0xfa1a, 0x84e8, 0x4fa5, 0x0000, 0x0000, 0x0000, 0x0000, 0x1ad3, 0x19da, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xa0);
    poke(0x0003, 0x09);
    poke(0x197a, 0x27);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5485, 0xfa93, 0x84e8, 0x4fa5, 0x0000, 0x0000, 0x0000, 0x0000, 0x1ad3, 0x19da, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(6522), equals(0x93));
  }, tags: 'undocumented');


  // Test instruction fdcb0a
  test('fdcb0a', () {
    // Set up machine initial state
    loadRegisters(0xb3ef, 0xa2bb, 0xe5d6, 0x9617, 0x0000, 0x0000, 0x0000, 0x0000, 0xf946, 0xeef6, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xe1);
    poke(0x0003, 0x0a);
    poke(0xeed7, 0x19);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb389, 0xa2bb, 0x8cd6, 0x9617, 0x0000, 0x0000, 0x0000, 0x0000, 0xf946, 0xeef6, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(61143), equals(0x8c));
  }, tags: 'undocumented');


  // Test instruction fdcb0b
  test('fdcb0b', () {
    // Set up machine initial state
    loadRegisters(0xae10, 0x8c4e, 0xe159, 0x1c54, 0x0000, 0x0000, 0x0000, 0x0000, 0xe108, 0xc68f, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x0c);
    poke(0x0003, 0x0b);
    poke(0xc69b, 0xf2);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xae28, 0x8c4e, 0xe179, 0x1c54, 0x0000, 0x0000, 0x0000, 0x0000, 0xe108, 0xc68f, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(50843), equals(0x79));
  }, tags: 'undocumented');


  // Test instruction fdcb0c
  test('fdcb0c', () {
    // Set up machine initial state
    loadRegisters(0x8719, 0x6b16, 0x4c3b, 0x180a, 0x0000, 0x0000, 0x0000, 0x0000, 0x175a, 0x8c9d, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xd7);
    poke(0x0003, 0x0c);
    poke(0x8c74, 0xae);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8700, 0x6b16, 0x4c3b, 0x570a, 0x0000, 0x0000, 0x0000, 0x0000, 0x175a, 0x8c9d, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(35956), equals(0x57));
  }, tags: 'undocumented');


  // Test instruction fdcb0d
  test('fdcb0d', () {
    // Set up machine initial state
    loadRegisters(0x1204, 0xe0cb, 0x3ab1, 0x2416, 0x0000, 0x0000, 0x0000, 0x0000, 0x1de4, 0xfe2d, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x11);
    poke(0x0003, 0x0d);
    poke(0xfe3e, 0x1b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x128d, 0xe0cb, 0x3ab1, 0x248d, 0x0000, 0x0000, 0x0000, 0x0000, 0x1de4, 0xfe2d, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(65086), equals(0x8d));
  }, tags: 'undocumented');


  // Test instruction fdcb0e
  test('fdcb0e', () {
    // Set up machine initial state
    loadRegisters(0x8da4, 0x8f91, 0xfc5a, 0x5e2c, 0x0000, 0x0000, 0x0000, 0x0000, 0xb2f2, 0xf223, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x0c);
    poke(0x0003, 0x0e);
    poke(0xf22f, 0xf7);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8da9, 0x8f91, 0xfc5a, 0x5e2c, 0x0000, 0x0000, 0x0000, 0x0000, 0xb2f2, 0xf223, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(61999), equals(0xfb));
  });


  // Test instruction fdcb0f
  test('fdcb0f', () {
    // Set up machine initial state
    loadRegisters(0xfbb0, 0x2ac9, 0xec6b, 0x6511, 0x0000, 0x0000, 0x0000, 0x0000, 0xc93a, 0xce38, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x15);
    poke(0x0003, 0x0f);
    poke(0xce4d, 0x44);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2224, 0x2ac9, 0xec6b, 0x6511, 0x0000, 0x0000, 0x0000, 0x0000, 0xc93a, 0xce38, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(52813), equals(0x22));
  }, tags: 'undocumented');


  // Test instruction fdcb10
  test('fdcb10', () {
    // Set up machine initial state
    loadRegisters(0x259d, 0x3852, 0x590d, 0xac66, 0x0000, 0x0000, 0x0000, 0x0000, 0x144f, 0x42a2, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x7a);
    poke(0x0003, 0x10);
    poke(0x431c, 0x1c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x252c, 0x3952, 0x590d, 0xac66, 0x0000, 0x0000, 0x0000, 0x0000, 0x144f, 0x42a2, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(17180), equals(0x39));
  }, tags: 'undocumented');


  // Test instruction fdcb11
  test('fdcb11', () {
    // Set up machine initial state
    loadRegisters(0xbc60, 0x61c1, 0xf5f8, 0xaf24, 0x0000, 0x0000, 0x0000, 0x0000, 0x4019, 0x9c90, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x7b);
    poke(0x0003, 0x11);
    poke(0x9d0b, 0x5e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xbca8, 0x61bc, 0xf5f8, 0xaf24, 0x0000, 0x0000, 0x0000, 0x0000, 0x4019, 0x9c90, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(40203), equals(0xbc));
  }, tags: 'undocumented');


  // Test instruction fdcb12
  test('fdcb12', () {
    // Set up machine initial state
    loadRegisters(0x4e45, 0x3a25, 0x3417, 0xbcc7, 0x0000, 0x0000, 0x0000, 0x0000, 0x0d7e, 0x8537, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x61);
    poke(0x0003, 0x12);
    poke(0x8598, 0xa7);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4e09, 0x3a25, 0x4f17, 0xbcc7, 0x0000, 0x0000, 0x0000, 0x0000, 0x0d7e, 0x8537, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(34200), equals(0x4f));
  }, tags: 'undocumented');


  // Test instruction fdcb13
  test('fdcb13', () {
    // Set up machine initial state
    loadRegisters(0xb224, 0xb79b, 0x84f1, 0xff7d, 0x0000, 0x0000, 0x0000, 0x0000, 0x414c, 0xe798, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xb3);
    poke(0x0003, 0x13);
    poke(0xe74b, 0xb3);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb225, 0xb79b, 0x8466, 0xff7d, 0x0000, 0x0000, 0x0000, 0x0000, 0x414c, 0xe798, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(59211), equals(0x66));
  }, tags: 'undocumented');


  // Test instruction fdcb14
  test('fdcb14', () {
    // Set up machine initial state
    loadRegisters(0xabbb, 0x451a, 0xfc65, 0x14a1, 0x0000, 0x0000, 0x0000, 0x0000, 0x0f4d, 0xd93c, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xc4);
    poke(0x0003, 0x14);
    poke(0xd900, 0x06);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xab08, 0x451a, 0xfc65, 0x0da1, 0x0000, 0x0000, 0x0000, 0x0000, 0x0f4d, 0xd93c, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(55552), equals(0x0d));
  }, tags: 'undocumented');


  // Test instruction fdcb15
  test('fdcb15', () {
    // Set up machine initial state
    loadRegisters(0x2864, 0x9532, 0x8631, 0x751c, 0x0000, 0x0000, 0x0000, 0x0000, 0xe327, 0x2d7b, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x17);
    poke(0x0003, 0x15);
    poke(0x2d92, 0x12);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2824, 0x9532, 0x8631, 0x7524, 0x0000, 0x0000, 0x0000, 0x0000, 0xe327, 0x2d7b, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(11666), equals(0x24));
  }, tags: 'undocumented');


  // Test instruction fdcb16
  test('fdcb16', () {
    // Set up machine initial state
    loadRegisters(0x0c3c, 0xdcd7, 0xadcc, 0x196d, 0x0000, 0x0000, 0x0000, 0x0000, 0x87e2, 0xf0b4, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x23);
    poke(0x0003, 0x16);
    poke(0xf0d7, 0x89);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0c05, 0xdcd7, 0xadcc, 0x196d, 0x0000, 0x0000, 0x0000, 0x0000, 0x87e2, 0xf0b4, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(61655), equals(0x12));
  });


  // Test instruction fdcb17
  test('fdcb17', () {
    // Set up machine initial state
    loadRegisters(0xaf5b, 0xd016, 0x066e, 0x6638, 0x0000, 0x0000, 0x0000, 0x0000, 0x5e92, 0x2013, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x8a);
    poke(0x0003, 0x17);
    poke(0x1f9d, 0xb8);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7125, 0xd016, 0x066e, 0x6638, 0x0000, 0x0000, 0x0000, 0x0000, 0x5e92, 0x2013, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(8093), equals(0x71));
  }, tags: 'undocumented');


  // Test instruction fdcb18
  test('fdcb18', () {
    // Set up machine initial state
    loadRegisters(0x23f3, 0x4517, 0x16e0, 0x6894, 0x0000, 0x0000, 0x0000, 0x0000, 0xb908, 0x3216, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xc0);
    poke(0x0003, 0x18);
    poke(0x31d6, 0xfa);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x23a8, 0xfd17, 0x16e0, 0x6894, 0x0000, 0x0000, 0x0000, 0x0000, 0xb908, 0x3216, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(12758), equals(0xfd));
  }, tags: 'undocumented');


  // Test instruction fdcb19
  test('fdcb19', () {
    // Set up machine initial state
    loadRegisters(0x11ed, 0xc2b8, 0xa9f3, 0x2014, 0x0000, 0x0000, 0x0000, 0x0000, 0x6db0, 0x4d2e, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xa2);
    poke(0x0003, 0x19);
    poke(0x4cd0, 0x4b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x11a5, 0xc2a5, 0xa9f3, 0x2014, 0x0000, 0x0000, 0x0000, 0x0000, 0x6db0, 0x4d2e, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(19664), equals(0xa5));
  }, tags: 'undocumented');


  // Test instruction fdcb1a
  test('fdcb1a', () {
    // Set up machine initial state
    loadRegisters(0xbc5c, 0x6168, 0xe541, 0xb630, 0x0000, 0x0000, 0x0000, 0x0000, 0x0207, 0x40d3, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x78);
    poke(0x0003, 0x1a);
    poke(0x414b, 0x44);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xbc24, 0x6168, 0x2241, 0xb630, 0x0000, 0x0000, 0x0000, 0x0000, 0x0207, 0x40d3, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(16715), equals(0x22));
  }, tags: 'undocumented');


  // Test instruction fdcb1b
  test('fdcb1b', () {
    // Set up machine initial state
    loadRegisters(0x7a28, 0x1286, 0xfe50, 0xc42d, 0x0000, 0x0000, 0x0000, 0x0000, 0xe290, 0x71b0, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x16);
    poke(0x0003, 0x1b);
    poke(0x71c6, 0xb8);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7a0c, 0x1286, 0xfe5c, 0xc42d, 0x0000, 0x0000, 0x0000, 0x0000, 0xe290, 0x71b0, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(29126), equals(0x5c));
  }, tags: 'undocumented');


  // Test instruction fdcb1c
  test('fdcb1c', () {
    // Set up machine initial state
    loadRegisters(0x932b, 0x097b, 0x6928, 0x83a3, 0x0000, 0x0000, 0x0000, 0x0000, 0xff2d, 0xdf62, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x86);
    poke(0x0003, 0x1c);
    poke(0xdee8, 0x8f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9381, 0x097b, 0x6928, 0xc7a3, 0x0000, 0x0000, 0x0000, 0x0000, 0xff2d, 0xdf62, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(57064), equals(0xc7));
  }, tags: 'undocumented');


  // Test instruction fdcb1d
  test('fdcb1d', () {
    // Set up machine initial state
    loadRegisters(0x97b1, 0x2b30, 0x2645, 0x04ef, 0x0000, 0x0000, 0x0000, 0x0000, 0x186a, 0xd667, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x27);
    poke(0x0003, 0x1d);
    poke(0xd68e, 0xb7);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x978d, 0x2b30, 0x2645, 0x04db, 0x0000, 0x0000, 0x0000, 0x0000, 0x186a, 0xd667, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(54926), equals(0xdb));
  }, tags: 'undocumented');


  // Test instruction fdcb1e
  test('fdcb1e', () {
    // Set up machine initial state
    loadRegisters(0x2f39, 0x2470, 0xb521, 0x6ca3, 0x0000, 0x0000, 0x0000, 0x0000, 0x1066, 0xda38, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x3a);
    poke(0x0003, 0x1e);
    poke(0xda72, 0x25);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2f81, 0x2470, 0xb521, 0x6ca3, 0x0000, 0x0000, 0x0000, 0x0000, 0x1066, 0xda38, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(55922), equals(0x92));
  });


  // Test instruction fdcb1f
  test('fdcb1f', () {
    // Set up machine initial state
    loadRegisters(0x4cdd, 0x49a3, 0xda18, 0x3afd, 0x0000, 0x0000, 0x0000, 0x0000, 0xa4f1, 0x2095, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x7b);
    poke(0x0003, 0x1f);
    poke(0x2110, 0x04);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8284, 0x49a3, 0xda18, 0x3afd, 0x0000, 0x0000, 0x0000, 0x0000, 0xa4f1, 0x2095, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(8464), equals(0x82));
  }, tags: 'undocumented');


  // Test instruction fdcb20
  test('fdcb20', () {
    // Set up machine initial state
    loadRegisters(0x3d74, 0x3a8f, 0x206f, 0x8894, 0x0000, 0x0000, 0x0000, 0x0000, 0xddab, 0xda25, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x7a);
    poke(0x0003, 0x20);
    poke(0xda9f, 0x89);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3d05, 0x128f, 0x206f, 0x8894, 0x0000, 0x0000, 0x0000, 0x0000, 0xddab, 0xda25, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(55967), equals(0x12));
  }, tags: 'undocumented');


  // Test instruction fdcb21
  test('fdcb21', () {
    // Set up machine initial state
    loadRegisters(0x1674, 0x6025, 0x641a, 0x6598, 0x0000, 0x0000, 0x0000, 0x0000, 0x473b, 0xde36, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x7b);
    poke(0x0003, 0x21);
    poke(0xdeb1, 0x23);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1600, 0x6046, 0x641a, 0x6598, 0x0000, 0x0000, 0x0000, 0x0000, 0x473b, 0xde36, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(57009), equals(0x46));
  }, tags: 'undocumented');


  // Test instruction fdcb22
  test('fdcb22', () {
    // Set up machine initial state
    loadRegisters(0xada9, 0xefb2, 0x6f03, 0xe732, 0x0000, 0x0000, 0x0000, 0x0000, 0xc11d, 0x8926, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x9a);
    poke(0x0003, 0x22);
    poke(0x88c0, 0xd4);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xada9, 0xefb2, 0xa803, 0xe732, 0x0000, 0x0000, 0x0000, 0x0000, 0xc11d, 0x8926, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(35008), equals(0xa8));
  }, tags: 'undocumented');


  // Test instruction fdcb23
  test('fdcb23', () {
    // Set up machine initial state
    loadRegisters(0x21e9, 0xd678, 0xa71b, 0x25d7, 0x0000, 0x0000, 0x0000, 0x0000, 0x4ca8, 0x5255, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xf5);
    poke(0x0003, 0x23);
    poke(0x524a, 0x65);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x218c, 0xd678, 0xa7ca, 0x25d7, 0x0000, 0x0000, 0x0000, 0x0000, 0x4ca8, 0x5255, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(21066), equals(0xca));
  }, tags: 'undocumented');


  // Test instruction fdcb24
  test('fdcb24', () {
    // Set up machine initial state
    loadRegisters(0x1c51, 0xda3e, 0xcc7c, 0xcb19, 0x0000, 0x0000, 0x0000, 0x0000, 0x572c, 0xaffe, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xb4);
    poke(0x0003, 0x24);
    poke(0xafb2, 0x7e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1cac, 0xda3e, 0xcc7c, 0xfc19, 0x0000, 0x0000, 0x0000, 0x0000, 0x572c, 0xaffe, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(44978), equals(0xfc));
  }, tags: 'undocumented');


  // Test instruction fdcb25
  test('fdcb25', () {
    // Set up machine initial state
    loadRegisters(0x954e, 0x097c, 0xa341, 0x89e0, 0x0000, 0x0000, 0x0000, 0x0000, 0x435d, 0x23e9, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xa6);
    poke(0x0003, 0x25);
    poke(0x238f, 0x26);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9508, 0x097c, 0xa341, 0x894c, 0x0000, 0x0000, 0x0000, 0x0000, 0x435d, 0x23e9, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(9103), equals(0x4c));
  }, tags: 'undocumented');


  // Test instruction fdcb26
  test('fdcb26', () {
    // Set up machine initial state
    loadRegisters(0x5844, 0x0e19, 0xd277, 0xbf7f, 0x0000, 0x0000, 0x0000, 0x0000, 0x6504, 0xd4e4, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xbd);
    poke(0x0003, 0x26);
    poke(0xd4a1, 0xbf);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x582d, 0x0e19, 0xd277, 0xbf7f, 0x0000, 0x0000, 0x0000, 0x0000, 0x6504, 0xd4e4, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(54433), equals(0x7e));
  });


  // Test instruction fdcb27
  test('fdcb27', () {
    // Set up machine initial state
    loadRegisters(0x8e0d, 0x8c06, 0x2c4c, 0xd7c8, 0x0000, 0x0000, 0x0000, 0x0000, 0x9239, 0x8d42, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x59);
    poke(0x0003, 0x27);
    poke(0x8d9b, 0xa7);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4e0d, 0x8c06, 0x2c4c, 0xd7c8, 0x0000, 0x0000, 0x0000, 0x0000, 0x9239, 0x8d42, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(36251), equals(0x4e));
  }, tags: 'undocumented');


  // Test instruction fdcb28
  test('fdcb28', () {
    // Set up machine initial state
    loadRegisters(0x4122, 0xaf9b, 0x7745, 0x76f5, 0x0000, 0x0000, 0x0000, 0x0000, 0xa1bb, 0xab43, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x83);
    poke(0x0003, 0x28);
    poke(0xaac6, 0x5d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x412d, 0x2e9b, 0x7745, 0x76f5, 0x0000, 0x0000, 0x0000, 0x0000, 0xa1bb, 0xab43, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(43718), equals(0x2e));
  }, tags: 'undocumented');


  // Test instruction fdcb29
  test('fdcb29', () {
    // Set up machine initial state
    loadRegisters(0x0b21, 0xaffd, 0xfea6, 0x9478, 0x0000, 0x0000, 0x0000, 0x0000, 0x32bb, 0x0343, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x7d);
    poke(0x0003, 0x29);
    poke(0x03c0, 0x84);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0b80, 0xafc2, 0xfea6, 0x9478, 0x0000, 0x0000, 0x0000, 0x0000, 0x32bb, 0x0343, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(960), equals(0xc2));
  }, tags: 'undocumented');


  // Test instruction fdcb2a
  test('fdcb2a', () {
    // Set up machine initial state
    loadRegisters(0xf236, 0x8c31, 0x5932, 0x7feb, 0x0000, 0x0000, 0x0000, 0x0000, 0x7db7, 0xabe7, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xf9);
    poke(0x0003, 0x2a);
    poke(0xabe0, 0xdd);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf2ad, 0x8c31, 0xee32, 0x7feb, 0x0000, 0x0000, 0x0000, 0x0000, 0x7db7, 0xabe7, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(44000), equals(0xee));
  }, tags: 'undocumented');


  // Test instruction fdcb2b
  test('fdcb2b', () {
    // Set up machine initial state
    loadRegisters(0x2450, 0x6945, 0xdcfc, 0xd643, 0x0000, 0x0000, 0x0000, 0x0000, 0x5be1, 0x4a94, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x4b);
    poke(0x0003, 0x2b);
    poke(0x4adf, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2425, 0x6945, 0xdc24, 0xd643, 0x0000, 0x0000, 0x0000, 0x0000, 0x5be1, 0x4a94, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(19167), equals(0x24));
  }, tags: 'undocumented');


  // Test instruction fdcb2c
  test('fdcb2c', () {
    // Set up machine initial state
    loadRegisters(0x117f, 0xb32b, 0xe530, 0x255a, 0x0000, 0x0000, 0x0000, 0x0000, 0x2416, 0xccd1, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xe6);
    poke(0x0003, 0x2c);
    poke(0xccb7, 0x3c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x110c, 0xb32b, 0xe530, 0x1e5a, 0x0000, 0x0000, 0x0000, 0x0000, 0x2416, 0xccd1, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(52407), equals(0x1e));
  }, tags: 'undocumented');


  // Test instruction fdcb2d
  test('fdcb2d', () {
    // Set up machine initial state
    loadRegisters(0xd0c3, 0x344b, 0x1bb0, 0x3eab, 0x0000, 0x0000, 0x0000, 0x0000, 0xfe11, 0xe4e6, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x5f);
    poke(0x0003, 0x2d);
    poke(0xe545, 0x78);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd02c, 0x344b, 0x1bb0, 0x3e3c, 0x0000, 0x0000, 0x0000, 0x0000, 0xfe11, 0xe4e6, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(58693), equals(0x3c));
  }, tags: 'undocumented');


  // Test instruction fdcb2e
  test('fdcb2e', () {
    // Set up machine initial state
    loadRegisters(0xf4ee, 0xb832, 0x4b7f, 0xe2b7, 0x0000, 0x0000, 0x0000, 0x0000, 0x9386, 0x42fd, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x06);
    poke(0x0003, 0x2e);
    poke(0x4303, 0xad);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf481, 0xb832, 0x4b7f, 0xe2b7, 0x0000, 0x0000, 0x0000, 0x0000, 0x9386, 0x42fd, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(17155), equals(0xd6));
  });


  // Test instruction fdcb2f
  test('fdcb2f', () {
    // Set up machine initial state
    loadRegisters(0xff86, 0xf2c2, 0x9f2f, 0xc946, 0x0000, 0x0000, 0x0000, 0x0000, 0x5fe0, 0x16b8, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x29);
    poke(0x0003, 0x2f);
    poke(0x16e1, 0x18);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0c0c, 0xf2c2, 0x9f2f, 0xc946, 0x0000, 0x0000, 0x0000, 0x0000, 0x5fe0, 0x16b8, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(5857), equals(0x0c));
  }, tags: 'undocumented');


  // Test instruction fdcb30
  test('fdcb30', () {
    // Set up machine initial state
    loadRegisters(0xacf6, 0xe832, 0xf9ed, 0xcabc, 0x0000, 0x0000, 0x0000, 0x0000, 0xfabd, 0xd646, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x1b);
    poke(0x0003, 0x30);
    poke(0xd661, 0xa5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xac0d, 0x4b32, 0xf9ed, 0xcabc, 0x0000, 0x0000, 0x0000, 0x0000, 0xfabd, 0xd646, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(54881), equals(0x4b));
  }, tags: 'undocumented');


  // Test instruction fdcb31
  test('fdcb31', () {
    // Set up machine initial state
    loadRegisters(0x2b96, 0x5134, 0x83a7, 0x7eee, 0x0000, 0x0000, 0x0000, 0x0000, 0x7750, 0xbfe0, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xf0);
    poke(0x0003, 0x31);
    poke(0xbfd0, 0xf1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2ba1, 0x51e3, 0x83a7, 0x7eee, 0x0000, 0x0000, 0x0000, 0x0000, 0x7750, 0xbfe0, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(49104), equals(0xe3));
  }, tags: 'undocumented');


  // Test instruction fdcb32
  test('fdcb32', () {
    // Set up machine initial state
    loadRegisters(0xb2bc, 0xa4b1, 0xb685, 0xf66e, 0x0000, 0x0000, 0x0000, 0x0000, 0xa9a1, 0x5ade, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xc5);
    poke(0x0003, 0x32);
    poke(0x5aa3, 0x59);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb2a0, 0xa4b1, 0xb385, 0xf66e, 0x0000, 0x0000, 0x0000, 0x0000, 0xa9a1, 0x5ade, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(23203), equals(0xb3));
  }, tags: 'undocumented');


  // Test instruction fdcb33
  test('fdcb33', () {
    // Set up machine initial state
    loadRegisters(0x9c6d, 0x2c90, 0xd0a9, 0x2be3, 0x0000, 0x0000, 0x0000, 0x0000, 0x2691, 0x1964, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x7f);
    poke(0x0003, 0x33);
    poke(0x19e3, 0xda);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9ca1, 0x2c90, 0xd0b5, 0x2be3, 0x0000, 0x0000, 0x0000, 0x0000, 0x2691, 0x1964, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(6627), equals(0xb5));
  }, tags: 'undocumented');


  // Test instruction fdcb34
  test('fdcb34', () {
    // Set up machine initial state
    loadRegisters(0x6029, 0xfbcd, 0x5348, 0xf947, 0x0000, 0x0000, 0x0000, 0x0000, 0x5338, 0x5696, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xd2);
    poke(0x0003, 0x34);
    poke(0x5668, 0xd4);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x60ad, 0xfbcd, 0x5348, 0xa947, 0x0000, 0x0000, 0x0000, 0x0000, 0x5338, 0x5696, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(22120), equals(0xa9));
  }, tags: 'undocumented');


  // Test instruction fdcb35
  test('fdcb35', () {
    // Set up machine initial state
    loadRegisters(0x96a9, 0x21c6, 0x4cb6, 0xb40b, 0x0000, 0x0000, 0x0000, 0x0000, 0x673a, 0x00f8, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x71);
    poke(0x0003, 0x35);
    poke(0x0169, 0x0b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9604, 0x21c6, 0x4cb6, 0xb417, 0x0000, 0x0000, 0x0000, 0x0000, 0x673a, 0x00f8, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(361), equals(0x17));
  }, tags: 'undocumented');


  // Test instruction fdcb36
  test('fdcb36', () {
    // Set up machine initial state
    loadRegisters(0xdc6f, 0x0892, 0x3cc7, 0x1494, 0x0000, 0x0000, 0x0000, 0x0000, 0x8598, 0x1ade, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xda);
    poke(0x0003, 0x36);
    poke(0x1ab8, 0x3c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xdc28, 0x0892, 0x3cc7, 0x1494, 0x0000, 0x0000, 0x0000, 0x0000, 0x8598, 0x1ade, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(6840), equals(0x79));
  }, tags: 'undocumented');


  // Test instruction fdcb37
  test('fdcb37', () {
    // Set up machine initial state
    loadRegisters(0xd2b3, 0x4524, 0x208f, 0x076f, 0x0000, 0x0000, 0x0000, 0x0000, 0xad10, 0xe7ec, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xcb);
    poke(0x0003, 0x37);
    poke(0xe7b7, 0x9f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3f2d, 0x4524, 0x208f, 0x076f, 0x0000, 0x0000, 0x0000, 0x0000, 0xad10, 0xe7ec, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(59319), equals(0x3f));
  }, tags: 'undocumented');


  // Test instruction fdcb38
  test('fdcb38', () {
    // Set up machine initial state
    loadRegisters(0x4f07, 0x0050, 0x40c6, 0x4fb7, 0x0000, 0x0000, 0x0000, 0x0000, 0xf37e, 0xd096, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x8e);
    poke(0x0003, 0x38);
    poke(0xd024, 0x0d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4f05, 0x0650, 0x40c6, 0x4fb7, 0x0000, 0x0000, 0x0000, 0x0000, 0xf37e, 0xd096, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(53284), equals(0x06));
  }, tags: 'undocumented');


  // Test instruction fdcb39
  test('fdcb39', () {
    // Set up machine initial state
    loadRegisters(0xbcc2, 0xf5b5, 0x8dee, 0xe514, 0x0000, 0x0000, 0x0000, 0x0000, 0x48bc, 0xf433, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x7f);
    poke(0x0003, 0x39);
    poke(0xf4b2, 0xf5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xbc29, 0xf57a, 0x8dee, 0xe514, 0x0000, 0x0000, 0x0000, 0x0000, 0x48bc, 0xf433, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(62642), equals(0x7a));
  }, tags: 'undocumented');


  // Test instruction fdcb3a
  test('fdcb3a', () {
    // Set up machine initial state
    loadRegisters(0xd012, 0x2ef5, 0x2910, 0x9ca5, 0x0000, 0x0000, 0x0000, 0x0000, 0xb155, 0xcb03, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x1d);
    poke(0x0003, 0x3a);
    poke(0xcb20, 0xa8);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd000, 0x2ef5, 0x5410, 0x9ca5, 0x0000, 0x0000, 0x0000, 0x0000, 0xb155, 0xcb03, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(52000), equals(0x54));
  }, tags: 'undocumented');


  // Test instruction fdcb3b
  test('fdcb3b', () {
    // Set up machine initial state
    loadRegisters(0x503d, 0xa85b, 0xcfbb, 0xde8c, 0x0000, 0x0000, 0x0000, 0x0000, 0x9c5b, 0xd263, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x05);
    poke(0x0003, 0x3b);
    poke(0xd268, 0xb2);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x500c, 0xa85b, 0xcf59, 0xde8c, 0x0000, 0x0000, 0x0000, 0x0000, 0x9c5b, 0xd263, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(53864), equals(0x59));
  }, tags: 'undocumented');


  // Test instruction fdcb3c
  test('fdcb3c', () {
    // Set up machine initial state
    loadRegisters(0x97f0, 0x4456, 0x0b52, 0xfdad, 0x0000, 0x0000, 0x0000, 0x0000, 0x6d2a, 0xa80f, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xae);
    poke(0x0003, 0x3c);
    poke(0xa7bd, 0x96);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x970c, 0x4456, 0x0b52, 0x4bad, 0x0000, 0x0000, 0x0000, 0x0000, 0x6d2a, 0xa80f, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(42941), equals(0x4b));
  }, tags: 'undocumented');


  // Test instruction fdcb3d
  test('fdcb3d', () {
    // Set up machine initial state
    loadRegisters(0x7d44, 0x9303, 0xe12b, 0xbff6, 0x0000, 0x0000, 0x0000, 0x0000, 0x4c0f, 0xe52a, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x13);
    poke(0x0003, 0x3d);
    poke(0xe53d, 0xfb);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7d2d, 0x9303, 0xe12b, 0xbf7d, 0x0000, 0x0000, 0x0000, 0x0000, 0x4c0f, 0xe52a, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(58685), equals(0x7d));
  }, tags: 'undocumented');


  // Test instruction fdcb3e
  test('fdcb3e', () {
    // Set up machine initial state
    loadRegisters(0x0d95, 0x3e02, 0x8f74, 0x0f82, 0x0000, 0x0000, 0x0000, 0x0000, 0x85df, 0xb2d1, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x2e);
    poke(0x0003, 0x3e);
    poke(0xb2ff, 0x50);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0d2c, 0x3e02, 0x8f74, 0x0f82, 0x0000, 0x0000, 0x0000, 0x0000, 0x85df, 0xb2d1, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(45823), equals(0x28));
  });


  // Test instruction fdcb3f
  test('fdcb3f', () {
    // Set up machine initial state
    loadRegisters(0x89e3, 0x12f6, 0x426c, 0x52d4, 0x0000, 0x0000, 0x0000, 0x0000, 0xd9f7, 0xc1ac, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x21);
    poke(0x0003, 0x3f);
    poke(0xc1cd, 0x78);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3c2c, 0x12f6, 0x426c, 0x52d4, 0x0000, 0x0000, 0x0000, 0x0000, 0xd9f7, 0xc1ac, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(49613), equals(0x3c));
  }, tags: 'undocumented');


  // Test instruction fdcb40
  test('fdcb40', () {
    // Set up machine initial state
    loadRegisters(0x5408, 0x2c34, 0x6784, 0xb376, 0x0000, 0x0000, 0x0000, 0x0000, 0x8ff9, 0x4195, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x3b);
    poke(0x0003, 0x40);
    poke(0x41d0, 0x0d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5410, 0x2c34, 0x6784, 0xb376, 0x0000, 0x0000, 0x0000, 0x0000, 0x8ff9, 0x4195, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb41
  test('fdcb41', () {
    // Set up machine initial state
    loadRegisters(0x8c35, 0x5a58, 0xb71c, 0x6777, 0x0000, 0x0000, 0x0000, 0x0000, 0xdeca, 0x03cb, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xcc);
    poke(0x0003, 0x41);
    poke(0x0397, 0xe9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8c11, 0x5a58, 0xb71c, 0x6777, 0x0000, 0x0000, 0x0000, 0x0000, 0xdeca, 0x03cb, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb42
  test('fdcb42', () {
    // Set up machine initial state
    loadRegisters(0x5535, 0x9c29, 0x2feb, 0x97ff, 0x0000, 0x0000, 0x0000, 0x0000, 0x7f17, 0x9f56, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x01);
    poke(0x0003, 0x42);
    poke(0x9f57, 0xa8);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x555d, 0x9c29, 0x2feb, 0x97ff, 0x0000, 0x0000, 0x0000, 0x0000, 0x7f17, 0x9f56, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb43
  test('fdcb43', () {
    // Set up machine initial state
    loadRegisters(0xb404, 0xe58c, 0xe62e, 0x2a32, 0x0000, 0x0000, 0x0000, 0x0000, 0x7130, 0x1fd1, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x08);
    poke(0x0003, 0x43);
    poke(0x1fd9, 0xaa);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb45c, 0xe58c, 0xe62e, 0x2a32, 0x0000, 0x0000, 0x0000, 0x0000, 0x7130, 0x1fd1, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb44
  test('fdcb44', () {
    // Set up machine initial state
    loadRegisters(0xa954, 0x68f4, 0x9fa4, 0x7f66, 0x0000, 0x0000, 0x0000, 0x0000, 0x0209, 0xf4f3, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x03);
    poke(0x0003, 0x44);
    poke(0xf4f6, 0x89);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa930, 0x68f4, 0x9fa4, 0x7f66, 0x0000, 0x0000, 0x0000, 0x0000, 0x0209, 0xf4f3, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb45
  test('fdcb45', () {
    // Set up machine initial state
    loadRegisters(0x73e5, 0x8dde, 0x5e4f, 0x84a7, 0x0000, 0x0000, 0x0000, 0x0000, 0x4e24, 0x93ed, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x8d);
    poke(0x0003, 0x45);
    poke(0x937a, 0x8d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7311, 0x8dde, 0x5e4f, 0x84a7, 0x0000, 0x0000, 0x0000, 0x0000, 0x4e24, 0x93ed, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb46
  test('fdcb46', () {
    // Set up machine initial state
    loadRegisters(0x0e5a, 0xb1f9, 0x475f, 0xebfc, 0x0000, 0x0000, 0x0000, 0x0000, 0x7765, 0x63b1, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x8c);
    poke(0x0003, 0x46);
    poke(0x633d, 0xfe);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0e74, 0xb1f9, 0x475f, 0xebfc, 0x0000, 0x0000, 0x0000, 0x0000, 0x7765, 0x63b1, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  });


  // Test instruction fdcb47
  test('fdcb47', () {
    // Set up machine initial state
    loadRegisters(0x9b3d, 0x7f38, 0x0753, 0xd5e7, 0x0000, 0x0000, 0x0000, 0x0000, 0xb9c3, 0x6e0e, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x96);
    poke(0x0003, 0x47);
    poke(0x6da4, 0xd6);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9b7d, 0x7f38, 0x0753, 0xd5e7, 0x0000, 0x0000, 0x0000, 0x0000, 0xb9c3, 0x6e0e, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb48
  test('fdcb48', () {
    // Set up machine initial state
    loadRegisters(0x7d94, 0x50a9, 0x2511, 0x8f9f, 0x0000, 0x0000, 0x0000, 0x0000, 0xb612, 0xaba9, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x44);
    poke(0x0003, 0x48);
    poke(0xabed, 0xb0);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7d7c, 0x50a9, 0x2511, 0x8f9f, 0x0000, 0x0000, 0x0000, 0x0000, 0xb612, 0xaba9, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb49
  test('fdcb49', () {
    // Set up machine initial state
    loadRegisters(0x691e, 0x3a39, 0xb834, 0x74b6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0eb7, 0x3e21, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x4e);
    poke(0x0003, 0x49);
    poke(0x3e6f, 0xa9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x697c, 0x3a39, 0xb834, 0x74b6, 0x0000, 0x0000, 0x0000, 0x0000, 0x0eb7, 0x3e21, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb4a
  test('fdcb4a', () {
    // Set up machine initial state
    loadRegisters(0x31e3, 0x68e0, 0xfe2f, 0xa2c4, 0x0000, 0x0000, 0x0000, 0x0000, 0xac96, 0xe7db, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x52);
    poke(0x0003, 0x4a);
    poke(0xe82d, 0xda);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3139, 0x68e0, 0xfe2f, 0xa2c4, 0x0000, 0x0000, 0x0000, 0x0000, 0xac96, 0xe7db, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb4b
  test('fdcb4b', () {
    // Set up machine initial state
    loadRegisters(0x09a1, 0x2453, 0x9186, 0xa32a, 0x0000, 0x0000, 0x0000, 0x0000, 0x71af, 0x883f, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xea);
    poke(0x0003, 0x4b);
    poke(0x8829, 0x4e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0919, 0x2453, 0x9186, 0xa32a, 0x0000, 0x0000, 0x0000, 0x0000, 0x71af, 0x883f, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb4c
  test('fdcb4c', () {
    // Set up machine initial state
    loadRegisters(0x4a52, 0x1e5b, 0xbe2e, 0x3ee4, 0x0000, 0x0000, 0x0000, 0x0000, 0xaf79, 0x7f22, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xee);
    poke(0x0003, 0x4c);
    poke(0x7f10, 0x70);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4a7c, 0x1e5b, 0xbe2e, 0x3ee4, 0x0000, 0x0000, 0x0000, 0x0000, 0xaf79, 0x7f22, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb4d
  test('fdcb4d', () {
    // Set up machine initial state
    loadRegisters(0x9f87, 0x6c8f, 0x34f4, 0x5a79, 0x0000, 0x0000, 0x0000, 0x0000, 0xd3cc, 0xa770, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x29);
    poke(0x0003, 0x4d);
    poke(0xa799, 0x78);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9f75, 0x6c8f, 0x34f4, 0x5a79, 0x0000, 0x0000, 0x0000, 0x0000, 0xd3cc, 0xa770, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb4e
  test('fdcb4e', () {
    // Set up machine initial state
    loadRegisters(0x30cb, 0x5626, 0x52bc, 0x5503, 0x0000, 0x0000, 0x0000, 0x0000, 0x303b, 0xe1c8, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x20);
    poke(0x0003, 0x4e);
    poke(0xe1e8, 0xaa);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3031, 0x5626, 0x52bc, 0x5503, 0x0000, 0x0000, 0x0000, 0x0000, 0x303b, 0xe1c8, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  });


  // Test instruction fdcb4f
  test('fdcb4f', () {
    // Set up machine initial state
    loadRegisters(0x6088, 0xe079, 0x7152, 0x671f, 0x0000, 0x0000, 0x0000, 0x0000, 0x8c22, 0x1cf8, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x9d);
    poke(0x0003, 0x4f);
    poke(0x1c95, 0x18);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x605c, 0xe079, 0x7152, 0x671f, 0x0000, 0x0000, 0x0000, 0x0000, 0x8c22, 0x1cf8, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb50
  test('fdcb50', () {
    // Set up machine initial state
    loadRegisters(0x8cde, 0x1409, 0x6d69, 0xe5b2, 0x0000, 0x0000, 0x0000, 0x0000, 0x4a0c, 0xc75f, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x6b);
    poke(0x0003, 0x50);
    poke(0xc7ca, 0xfe);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8c10, 0x1409, 0x6d69, 0xe5b2, 0x0000, 0x0000, 0x0000, 0x0000, 0x4a0c, 0xc75f, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb51
  test('fdcb51', () {
    // Set up machine initial state
    loadRegisters(0x8f59, 0x40cb, 0x9543, 0x9b3a, 0x0000, 0x0000, 0x0000, 0x0000, 0x1942, 0x3495, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x86);
    poke(0x0003, 0x51);
    poke(0x341b, 0x13);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8f75, 0x40cb, 0x9543, 0x9b3a, 0x0000, 0x0000, 0x0000, 0x0000, 0x1942, 0x3495, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb52
  test('fdcb52', () {
    // Set up machine initial state
    loadRegisters(0x8905, 0x3e41, 0x7ab4, 0x37f6, 0x0000, 0x0000, 0x0000, 0x0000, 0xf82d, 0x8b0d, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xe6);
    poke(0x0003, 0x52);
    poke(0x8af3, 0x87);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8919, 0x3e41, 0x7ab4, 0x37f6, 0x0000, 0x0000, 0x0000, 0x0000, 0xf82d, 0x8b0d, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb53
  test('fdcb53', () {
    // Set up machine initial state
    loadRegisters(0xefde, 0xe345, 0x09a3, 0xf0b2, 0x0000, 0x0000, 0x0000, 0x0000, 0xc378, 0x7ee1, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xd1);
    poke(0x0003, 0x53);
    poke(0x7eb2, 0xe4);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xef38, 0xe345, 0x09a3, 0xf0b2, 0x0000, 0x0000, 0x0000, 0x0000, 0xc378, 0x7ee1, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb54
  test('fdcb54', () {
    // Set up machine initial state
    loadRegisters(0x72a6, 0xcb82, 0xd966, 0x2fc6, 0x0000, 0x0000, 0x0000, 0x0000, 0x3c00, 0x5b6b, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x08);
    poke(0x0003, 0x54);
    poke(0x5b73, 0x07);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7218, 0xcb82, 0xd966, 0x2fc6, 0x0000, 0x0000, 0x0000, 0x0000, 0x3c00, 0x5b6b, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb55
  test('fdcb55', () {
    // Set up machine initial state
    loadRegisters(0x855c, 0xc23b, 0x6aab, 0x9b00, 0x0000, 0x0000, 0x0000, 0x0000, 0xfe93, 0xb4b2, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x54);
    poke(0x0003, 0x55);
    poke(0xb506, 0x46);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8530, 0xc23b, 0x6aab, 0x9b00, 0x0000, 0x0000, 0x0000, 0x0000, 0xfe93, 0xb4b2, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb56
  test('fdcb56', () {
    // Set up machine initial state
    loadRegisters(0xf5ad, 0xf9f6, 0x1e8c, 0x9e08, 0x0000, 0x0000, 0x0000, 0x0000, 0x716a, 0x6932, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x6f);
    poke(0x0003, 0x56);
    poke(0x69a1, 0xdf);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf539, 0xf9f6, 0x1e8c, 0x9e08, 0x0000, 0x0000, 0x0000, 0x0000, 0x716a, 0x6932, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  });


  // Test instruction fdcb57
  test('fdcb57', () {
    // Set up machine initial state
    loadRegisters(0x37d7, 0xb7dc, 0xbe1c, 0x38ea, 0x0000, 0x0000, 0x0000, 0x0000, 0x5e82, 0xa3bb, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x3c);
    poke(0x0003, 0x57);
    poke(0xa3f7, 0x6c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3731, 0xb7dc, 0xbe1c, 0x38ea, 0x0000, 0x0000, 0x0000, 0x0000, 0x5e82, 0xa3bb, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb58
  test('fdcb58', () {
    // Set up machine initial state
    loadRegisters(0x752c, 0x7296, 0x3ea5, 0x1143, 0x0000, 0x0000, 0x0000, 0x0000, 0xd7cc, 0x1e94, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x4e);
    poke(0x0003, 0x58);
    poke(0x1ee2, 0xf6);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x755c, 0x7296, 0x3ea5, 0x1143, 0x0000, 0x0000, 0x0000, 0x0000, 0xd7cc, 0x1e94, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb59
  test('fdcb59', () {
    // Set up machine initial state
    loadRegisters(0x8056, 0xbf2a, 0x1809, 0xed31, 0x0000, 0x0000, 0x0000, 0x0000, 0xfe2b, 0xfad3, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x2e);
    poke(0x0003, 0x59);
    poke(0xfb01, 0x6f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8038, 0xbf2a, 0x1809, 0xed31, 0x0000, 0x0000, 0x0000, 0x0000, 0xfe2b, 0xfad3, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb5a
  test('fdcb5a', () {
    // Set up machine initial state
    loadRegisters(0xcc74, 0xa108, 0x65d4, 0x6f66, 0x0000, 0x0000, 0x0000, 0x0000, 0x0008, 0x7bb8, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x88);
    poke(0x0003, 0x5a);
    poke(0x7b40, 0x6e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xcc38, 0xa108, 0x65d4, 0x6f66, 0x0000, 0x0000, 0x0000, 0x0000, 0x0008, 0x7bb8, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb5b
  test('fdcb5b', () {
    // Set up machine initial state
    loadRegisters(0x5cf1, 0xb3bd, 0x25bd, 0x98cf, 0x0000, 0x0000, 0x0000, 0x0000, 0x2ba1, 0x315c, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xe7);
    poke(0x0003, 0x5b);
    poke(0x3143, 0xb1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5c75, 0xb3bd, 0x25bd, 0x98cf, 0x0000, 0x0000, 0x0000, 0x0000, 0x2ba1, 0x315c, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb5c
  test('fdcb5c', () {
    // Set up machine initial state
    loadRegisters(0xb3e0, 0xd43d, 0xd9c0, 0xb04d, 0x0000, 0x0000, 0x0000, 0x0000, 0x21a9, 0x543e, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x74);
    poke(0x0003, 0x5c);
    poke(0x54b2, 0xe3);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb354, 0xd43d, 0xd9c0, 0xb04d, 0x0000, 0x0000, 0x0000, 0x0000, 0x21a9, 0x543e, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb5d
  test('fdcb5d', () {
    // Set up machine initial state
    loadRegisters(0x9f49, 0x43dd, 0xccb3, 0x085a, 0x0000, 0x0000, 0x0000, 0x0000, 0xf130, 0x3b84, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xdc);
    poke(0x0003, 0x5d);
    poke(0x3b60, 0xef);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9f39, 0x43dd, 0xccb3, 0x085a, 0x0000, 0x0000, 0x0000, 0x0000, 0xf130, 0x3b84, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb5e
  test('fdcb5e', () {
    // Set up machine initial state
    loadRegisters(0x6f89, 0xeff5, 0x993b, 0x22b5, 0x0000, 0x0000, 0x0000, 0x0000, 0x0f30, 0xe165, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xe2);
    poke(0x0003, 0x5e);
    poke(0xe147, 0x17);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6f75, 0xeff5, 0x993b, 0x22b5, 0x0000, 0x0000, 0x0000, 0x0000, 0x0f30, 0xe165, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  });


  // Test instruction fdcb5f
  test('fdcb5f', () {
    // Set up machine initial state
    loadRegisters(0xd72a, 0xa57a, 0xaca6, 0x667e, 0x0000, 0x0000, 0x0000, 0x0000, 0x5c33, 0xf81b, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xab);
    poke(0x0003, 0x5f);
    poke(0xf7c6, 0xe2);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd774, 0xa57a, 0xaca6, 0x667e, 0x0000, 0x0000, 0x0000, 0x0000, 0x5c33, 0xf81b, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb60
  test('fdcb60', () {
    // Set up machine initial state
    loadRegisters(0x15e9, 0x8d30, 0x43f4, 0xc65e, 0x0000, 0x0000, 0x0000, 0x0000, 0x1e34, 0x8c44, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x85);
    poke(0x0003, 0x60);
    poke(0x8bc9, 0xb9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1519, 0x8d30, 0x43f4, 0xc65e, 0x0000, 0x0000, 0x0000, 0x0000, 0x1e34, 0x8c44, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb61
  test('fdcb61', () {
    // Set up machine initial state
    loadRegisters(0x7bd1, 0xd421, 0x5570, 0xcb85, 0x0000, 0x0000, 0x0000, 0x0000, 0x32ec, 0x92e4, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xbe);
    poke(0x0003, 0x61);
    poke(0x92a2, 0x28);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7b55, 0xd421, 0x5570, 0xcb85, 0x0000, 0x0000, 0x0000, 0x0000, 0x32ec, 0x92e4, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb62
  test('fdcb62', () {
    // Set up machine initial state
    loadRegisters(0xba2f, 0x4fbb, 0x67a7, 0xc5db, 0x0000, 0x0000, 0x0000, 0x0000, 0x470b, 0x7eb1, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x9d);
    poke(0x0003, 0x62);
    poke(0x7e4e, 0x1a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xba39, 0x4fbb, 0x67a7, 0xc5db, 0x0000, 0x0000, 0x0000, 0x0000, 0x470b, 0x7eb1, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb63
  test('fdcb63', () {
    // Set up machine initial state
    loadRegisters(0xc0a1, 0x2cc2, 0xce12, 0xe77c, 0x0000, 0x0000, 0x0000, 0x0000, 0x71c5, 0x1713, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xf4);
    poke(0x0003, 0x63);
    poke(0x1707, 0x3b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc011, 0x2cc2, 0xce12, 0xe77c, 0x0000, 0x0000, 0x0000, 0x0000, 0x71c5, 0x1713, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb64
  test('fdcb64', () {
    // Set up machine initial state
    loadRegisters(0x0c1f, 0x7847, 0x2494, 0x71eb, 0x0000, 0x0000, 0x0000, 0x0000, 0x315c, 0xb336, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x35);
    poke(0x0003, 0x64);
    poke(0xb36b, 0x8c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0c75, 0x7847, 0x2494, 0x71eb, 0x0000, 0x0000, 0x0000, 0x0000, 0x315c, 0xb336, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb65
  test('fdcb65', () {
    // Set up machine initial state
    loadRegisters(0x5245, 0xa82d, 0x1112, 0x8f09, 0x0000, 0x0000, 0x0000, 0x0000, 0x672a, 0x89f4, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x37);
    poke(0x0003, 0x65);
    poke(0x8a2b, 0x08);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x525d, 0xa82d, 0x1112, 0x8f09, 0x0000, 0x0000, 0x0000, 0x0000, 0x672a, 0x89f4, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb66
  test('fdcb66', () {
    // Set up machine initial state
    loadRegisters(0x583f, 0xc13e, 0xb136, 0x6bc5, 0x0000, 0x0000, 0x0000, 0x0000, 0x3ef9, 0x6948, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x9d);
    poke(0x0003, 0x66);
    poke(0x68e5, 0x90);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5839, 0xc13e, 0xb136, 0x6bc5, 0x0000, 0x0000, 0x0000, 0x0000, 0x3ef9, 0x6948, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  });


  // Test instruction fdcb67
  test('fdcb67', () {
    // Set up machine initial state
    loadRegisters(0x31b6, 0x0f7d, 0x48b5, 0xcc5f, 0x0000, 0x0000, 0x0000, 0x0000, 0x2103, 0x6572, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xcb);
    poke(0x0003, 0x67);
    poke(0x653d, 0x15);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3130, 0x0f7d, 0x48b5, 0xcc5f, 0x0000, 0x0000, 0x0000, 0x0000, 0x2103, 0x6572, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb68
  test('fdcb68', () {
    // Set up machine initial state
    loadRegisters(0xe330, 0x39fb, 0xa03a, 0x59bc, 0x0000, 0x0000, 0x0000, 0x0000, 0xe04a, 0x03be, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xca);
    poke(0x0003, 0x68);
    poke(0x0388, 0x83);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe354, 0x39fb, 0xa03a, 0x59bc, 0x0000, 0x0000, 0x0000, 0x0000, 0xe04a, 0x03be, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb69
  test('fdcb69', () {
    // Set up machine initial state
    loadRegisters(0x1896, 0x5bc2, 0xd4d9, 0x4e8a, 0x0000, 0x0000, 0x0000, 0x0000, 0x3716, 0xa603, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xe2);
    poke(0x0003, 0x69);
    poke(0xa5e5, 0x01);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1874, 0x5bc2, 0xd4d9, 0x4e8a, 0x0000, 0x0000, 0x0000, 0x0000, 0x3716, 0xa603, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb6a
  test('fdcb6a', () {
    // Set up machine initial state
    loadRegisters(0x5bc9, 0x0099, 0x34f8, 0x3e96, 0x0000, 0x0000, 0x0000, 0x0000, 0xf251, 0x93be, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xae);
    poke(0x0003, 0x6a);
    poke(0x936c, 0x33);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5b11, 0x0099, 0x34f8, 0x3e96, 0x0000, 0x0000, 0x0000, 0x0000, 0xf251, 0x93be, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb6b
  test('fdcb6b', () {
    // Set up machine initial state
    loadRegisters(0xbbe5, 0x9e6c, 0xabd1, 0x515f, 0x0000, 0x0000, 0x0000, 0x0000, 0x73db, 0xaa2f, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x1f);
    poke(0x0003, 0x6b);
    poke(0xaa4e, 0x7c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xbb39, 0x9e6c, 0xabd1, 0x515f, 0x0000, 0x0000, 0x0000, 0x0000, 0x73db, 0xaa2f, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb6c
  test('fdcb6c', () {
    // Set up machine initial state
    loadRegisters(0x144b, 0x3af2, 0x8f80, 0x7be5, 0x0000, 0x0000, 0x0000, 0x0000, 0xc379, 0x86ba, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x0d);
    poke(0x0003, 0x6c);
    poke(0x86c7, 0x25);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1411, 0x3af2, 0x8f80, 0x7be5, 0x0000, 0x0000, 0x0000, 0x0000, 0xc379, 0x86ba, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb6d
  test('fdcb6d', () {
    // Set up machine initial state
    loadRegisters(0x6392, 0xd077, 0x668d, 0x6e4a, 0x0000, 0x0000, 0x0000, 0x0000, 0xb0a8, 0x62c8, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xf0);
    poke(0x0003, 0x6d);
    poke(0x62b8, 0xe3);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6330, 0xd077, 0x668d, 0x6e4a, 0x0000, 0x0000, 0x0000, 0x0000, 0xb0a8, 0x62c8, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb6e
  test('fdcb6e', () {
    // Set up machine initial state
    loadRegisters(0x2da0, 0xf872, 0x692d, 0x92c4, 0x0000, 0x0000, 0x0000, 0x0000, 0x36b5, 0x4210, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x93);
    poke(0x0003, 0x6e);
    poke(0x41a3, 0x1e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2d54, 0xf872, 0x692d, 0x92c4, 0x0000, 0x0000, 0x0000, 0x0000, 0x36b5, 0x4210, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  });


  // Test instruction fdcb6f
  test('fdcb6f', () {
    // Set up machine initial state
    loadRegisters(0xdf7b, 0xc7aa, 0x9002, 0x86b8, 0x0000, 0x0000, 0x0000, 0x0000, 0x1347, 0x004e, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x20);
    poke(0x0003, 0x6f);
    poke(0x006e, 0x37);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xdf11, 0xc7aa, 0x9002, 0x86b8, 0x0000, 0x0000, 0x0000, 0x0000, 0x1347, 0x004e, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb70
  test('fdcb70', () {
    // Set up machine initial state
    loadRegisters(0x6ea9, 0x018d, 0x5075, 0xcf4e, 0x0000, 0x0000, 0x0000, 0x0000, 0xcd2b, 0x3e68, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xd9);
    poke(0x0003, 0x70);
    poke(0x3e41, 0xc9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6e39, 0x018d, 0x5075, 0xcf4e, 0x0000, 0x0000, 0x0000, 0x0000, 0xcd2b, 0x3e68, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb71
  test('fdcb71', () {
    // Set up machine initial state
    loadRegisters(0x1b48, 0xe3af, 0x94d5, 0x0996, 0x0000, 0x0000, 0x0000, 0x0000, 0xcad5, 0x999a, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x27);
    poke(0x0003, 0x71);
    poke(0x99c1, 0x3e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1b5c, 0xe3af, 0x94d5, 0x0996, 0x0000, 0x0000, 0x0000, 0x0000, 0xcad5, 0x999a, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb72
  test('fdcb72', () {
    // Set up machine initial state
    loadRegisters(0xe83b, 0x26b1, 0x8608, 0xf3cb, 0x0000, 0x0000, 0x0000, 0x0000, 0x6323, 0xfd31, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x98);
    poke(0x0003, 0x72);
    poke(0xfcc9, 0x4f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe839, 0x26b1, 0x8608, 0xf3cb, 0x0000, 0x0000, 0x0000, 0x0000, 0x6323, 0xfd31, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb73
  test('fdcb73', () {
    // Set up machine initial state
    loadRegisters(0x101b, 0x446c, 0xc2f9, 0xb9b1, 0x0000, 0x0000, 0x0000, 0x0000, 0x0820, 0xf5d8, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x7a);
    poke(0x0003, 0x73);
    poke(0xf652, 0x31);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1075, 0x446c, 0xc2f9, 0xb9b1, 0x0000, 0x0000, 0x0000, 0x0000, 0x0820, 0xf5d8, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb74
  test('fdcb74', () {
    // Set up machine initial state
    loadRegisters(0x6847, 0x38c2, 0x0ea4, 0x0825, 0x0000, 0x0000, 0x0000, 0x0000, 0xd255, 0x5e4a, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x4b);
    poke(0x0003, 0x74);
    poke(0x5e95, 0xfe);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6819, 0x38c2, 0x0ea4, 0x0825, 0x0000, 0x0000, 0x0000, 0x0000, 0xd255, 0x5e4a, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb75
  test('fdcb75', () {
    // Set up machine initial state
    loadRegisters(0x56f2, 0xc034, 0x6e11, 0xd35e, 0x0000, 0x0000, 0x0000, 0x0000, 0xe702, 0x60be, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x57);
    poke(0x0003, 0x75);
    poke(0x6115, 0x21);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5674, 0xc034, 0x6e11, 0xd35e, 0x0000, 0x0000, 0x0000, 0x0000, 0xe702, 0x60be, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb76
  test('fdcb76', () {
    // Set up machine initial state
    loadRegisters(0x7375, 0xcaff, 0xdd80, 0xc8ed, 0x0000, 0x0000, 0x0000, 0x0000, 0x7e39, 0x6623, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x53);
    poke(0x0003, 0x76);
    poke(0x6676, 0x3a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7375, 0xcaff, 0xdd80, 0xc8ed, 0x0000, 0x0000, 0x0000, 0x0000, 0x7e39, 0x6623, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  });


  // Test instruction fdcb77
  test('fdcb77', () {
    // Set up machine initial state
    loadRegisters(0xab10, 0x983e, 0x0bdc, 0x3b46, 0x0000, 0x0000, 0x0000, 0x0000, 0xae51, 0x8841, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x02);
    poke(0x0003, 0x77);
    poke(0x8843, 0xd8);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xab18, 0x983e, 0x0bdc, 0x3b46, 0x0000, 0x0000, 0x0000, 0x0000, 0xae51, 0x8841, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb78
  test('fdcb78', () {
    // Set up machine initial state
    loadRegisters(0x2765, 0xce2f, 0x4824, 0x6930, 0x0000, 0x0000, 0x0000, 0x0000, 0xae69, 0xfecb, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x7d);
    poke(0x0003, 0x78);
    poke(0xff48, 0xec);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x27b9, 0xce2f, 0x4824, 0x6930, 0x0000, 0x0000, 0x0000, 0x0000, 0xae69, 0xfecb, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb79
  test('fdcb79', () {
    // Set up machine initial state
    loadRegisters(0xb428, 0x6355, 0x7896, 0x8a7c, 0x0000, 0x0000, 0x0000, 0x0000, 0x9090, 0x1cae, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x23);
    poke(0x0003, 0x79);
    poke(0x1cd1, 0x87);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb498, 0x6355, 0x7896, 0x8a7c, 0x0000, 0x0000, 0x0000, 0x0000, 0x9090, 0x1cae, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb7a
  test('fdcb7a', () {
    // Set up machine initial state
    loadRegisters(0x59f4, 0xca21, 0x1482, 0x3fae, 0x0000, 0x0000, 0x0000, 0x0000, 0xc6c9, 0xd923, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x42);
    poke(0x0003, 0x7a);
    poke(0xd965, 0xb3);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5998, 0xca21, 0x1482, 0x3fae, 0x0000, 0x0000, 0x0000, 0x0000, 0xc6c9, 0xd923, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb7b
  test('fdcb7b', () {
    // Set up machine initial state
    loadRegisters(0x6314, 0x0240, 0x5efa, 0x5e7b, 0x0000, 0x0000, 0x0000, 0x0000, 0x3e50, 0x0a83, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x17);
    poke(0x0003, 0x7b);
    poke(0x0a9a, 0xbd);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6398, 0x0240, 0x5efa, 0x5e7b, 0x0000, 0x0000, 0x0000, 0x0000, 0x3e50, 0x0a83, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb7c
  test('fdcb7c', () {
    // Set up machine initial state
    loadRegisters(0x22a6, 0xaff4, 0xb89b, 0x4dca, 0x0000, 0x0000, 0x0000, 0x0000, 0x0ac2, 0xd371, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xf1);
    poke(0x0003, 0x7c);
    poke(0xd362, 0x1b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2254, 0xaff4, 0xb89b, 0x4dca, 0x0000, 0x0000, 0x0000, 0x0000, 0x0ac2, 0xd371, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb7d
  test('fdcb7d', () {
    // Set up machine initial state
    loadRegisters(0x1c95, 0xd615, 0x825a, 0x5e64, 0x0000, 0x0000, 0x0000, 0x0000, 0x32fb, 0xac3b, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x9f);
    poke(0x0003, 0x7d);
    poke(0xabda, 0x8a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1cb9, 0xd615, 0x825a, 0x5e64, 0x0000, 0x0000, 0x0000, 0x0000, 0x32fb, 0xac3b, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb7e
  test('fdcb7e', () {
    // Set up machine initial state
    loadRegisters(0x503c, 0x8dfe, 0x1019, 0x6778, 0x0000, 0x0000, 0x0000, 0x0000, 0xf7df, 0x9484, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x40);
    poke(0x0003, 0x7e);
    poke(0x94c4, 0x9e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5090, 0x8dfe, 0x1019, 0x6778, 0x0000, 0x0000, 0x0000, 0x0000, 0xf7df, 0x9484, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  });


  // Test instruction fdcb7f
  test('fdcb7f', () {
    // Set up machine initial state
    loadRegisters(0x1b07, 0x9ec3, 0x14be, 0x5ebe, 0x0000, 0x0000, 0x0000, 0x0000, 0x1178, 0xce69, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xa2);
    poke(0x0003, 0x7f);
    poke(0xce0b, 0x47);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1b5d, 0x9ec3, 0x14be, 0x5ebe, 0x0000, 0x0000, 0x0000, 0x0000, 0x1178, 0xce69, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 20);
  }, tags: 'undocumented');


  // Test instruction fdcb80
  test('fdcb80', () {
    // Set up machine initial state
    loadRegisters(0xe196, 0x72ea, 0x507e, 0x6457, 0x0000, 0x0000, 0x0000, 0x0000, 0xab75, 0x920d, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x8b);
    poke(0x0003, 0x80);
    poke(0x9198, 0xa9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe196, 0xa8ea, 0x507e, 0x6457, 0x0000, 0x0000, 0x0000, 0x0000, 0xab75, 0x920d, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(37272), equals(0xa8));
  }, tags: 'undocumented');


  // Test instruction fdcb81
  test('fdcb81', () {
    // Set up machine initial state
    loadRegisters(0x3d3d, 0xb255, 0x8759, 0x0cb0, 0x0000, 0x0000, 0x0000, 0x0000, 0xe078, 0x82a5, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x55);
    poke(0x0003, 0x81);
    poke(0x82fa, 0xfa);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3d3d, 0xb2fa, 0x8759, 0x0cb0, 0x0000, 0x0000, 0x0000, 0x0000, 0xe078, 0x82a5, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcb82
  test('fdcb82', () {
    // Set up machine initial state
    loadRegisters(0x4e10, 0x5d8d, 0x27a0, 0xffff, 0x0000, 0x0000, 0x0000, 0x0000, 0xee0a, 0x5dd8, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x9c);
    poke(0x0003, 0x82);
    poke(0x5d74, 0x9d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4e10, 0x5d8d, 0x9ca0, 0xffff, 0x0000, 0x0000, 0x0000, 0x0000, 0xee0a, 0x5dd8, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(23924), equals(0x9c));
  }, tags: 'undocumented');


  // Test instruction fdcb83
  test('fdcb83', () {
    // Set up machine initial state
    loadRegisters(0x3c7f, 0xfd81, 0x47fb, 0x9f12, 0x0000, 0x0000, 0x0000, 0x0000, 0xcbf9, 0x374a, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x28);
    poke(0x0003, 0x83);
    poke(0x3772, 0xd5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3c7f, 0xfd81, 0x47d4, 0x9f12, 0x0000, 0x0000, 0x0000, 0x0000, 0xcbf9, 0x374a, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(14194), equals(0xd4));
  }, tags: 'undocumented');


  // Test instruction fdcb84
  test('fdcb84', () {
    // Set up machine initial state
    loadRegisters(0x6872, 0x81b1, 0x1e7a, 0xe37e, 0x0000, 0x0000, 0x0000, 0x0000, 0x9b4c, 0xf1c3, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xaa);
    poke(0x0003, 0x84);
    poke(0xf16d, 0xea);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6872, 0x81b1, 0x1e7a, 0xea7e, 0x0000, 0x0000, 0x0000, 0x0000, 0x9b4c, 0xf1c3, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcb85
  test('fdcb85', () {
    // Set up machine initial state
    loadRegisters(0x25b3, 0x5694, 0x57cd, 0xf34d, 0x0000, 0x0000, 0x0000, 0x0000, 0x8ed2, 0x0433, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x6c);
    poke(0x0003, 0x85);
    poke(0x049f, 0xe0);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x25b3, 0x5694, 0x57cd, 0xf3e0, 0x0000, 0x0000, 0x0000, 0x0000, 0x8ed2, 0x0433, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcb86
  test('fdcb86', () {
    // Set up machine initial state
    loadRegisters(0x152b, 0x8ce1, 0x818d, 0x40f2, 0x0000, 0x0000, 0x0000, 0x0000, 0x9b7a, 0x2a50, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x7e);
    poke(0x0003, 0x86);
    poke(0x2ace, 0x36);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x152b, 0x8ce1, 0x818d, 0x40f2, 0x0000, 0x0000, 0x0000, 0x0000, 0x9b7a, 0x2a50, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  });


  // Test instruction fdcb87
  test('fdcb87', () {
    // Set up machine initial state
    loadRegisters(0xfe1d, 0x5353, 0x618d, 0x3266, 0x0000, 0x0000, 0x0000, 0x0000, 0x1a53, 0x246a, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x59);
    poke(0x0003, 0x87);
    poke(0x24c3, 0x65);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x641d, 0x5353, 0x618d, 0x3266, 0x0000, 0x0000, 0x0000, 0x0000, 0x1a53, 0x246a, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(9411), equals(0x64));
  }, tags: 'undocumented');


  // Test instruction fdcb88
  test('fdcb88', () {
    // Set up machine initial state
    loadRegisters(0x7d14, 0xa0ec, 0x1e47, 0x76e1, 0x0000, 0x0000, 0x0000, 0x0000, 0x3871, 0xc60d, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xd4);
    poke(0x0003, 0x88);
    poke(0xc5e1, 0xd6);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7d14, 0xd4ec, 0x1e47, 0x76e1, 0x0000, 0x0000, 0x0000, 0x0000, 0x3871, 0xc60d, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(50657), equals(0xd4));
  }, tags: 'undocumented');


  // Test instruction fdcb89
  test('fdcb89', () {
    // Set up machine initial state
    loadRegisters(0x86c3, 0x50a6, 0x8592, 0xd6ca, 0x0000, 0x0000, 0x0000, 0x0000, 0x947b, 0x0a01, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xc3);
    poke(0x0003, 0x89);
    poke(0x09c4, 0xb0);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x86c3, 0x50b0, 0x8592, 0xd6ca, 0x0000, 0x0000, 0x0000, 0x0000, 0x947b, 0x0a01, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcb8a
  test('fdcb8a', () {
    // Set up machine initial state
    loadRegisters(0x599c, 0x961a, 0x55f9, 0x8470, 0x0000, 0x0000, 0x0000, 0x0000, 0xd2a5, 0xd4d2, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xf9);
    poke(0x0003, 0x8a);
    poke(0xd4cb, 0xd8);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x599c, 0x961a, 0xd8f9, 0x8470, 0x0000, 0x0000, 0x0000, 0x0000, 0xd2a5, 0xd4d2, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcb8b
  test('fdcb8b', () {
    // Set up machine initial state
    loadRegisters(0x2715, 0xa209, 0xab47, 0x3eac, 0x0000, 0x0000, 0x0000, 0x0000, 0xf352, 0xc71e, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xed);
    poke(0x0003, 0x8b);
    poke(0xc70b, 0xdc);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2715, 0xa209, 0xabdc, 0x3eac, 0x0000, 0x0000, 0x0000, 0x0000, 0xf352, 0xc71e, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcb8c
  test('fdcb8c', () {
    // Set up machine initial state
    loadRegisters(0x2818, 0x4259, 0xa9b0, 0xe7a0, 0x0000, 0x0000, 0x0000, 0x0000, 0x6471, 0xa202, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x97);
    poke(0x0003, 0x8c);
    poke(0xa199, 0x67);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2818, 0x4259, 0xa9b0, 0x65a0, 0x0000, 0x0000, 0x0000, 0x0000, 0x6471, 0xa202, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(41369), equals(0x65));
  }, tags: 'undocumented');


  // Test instruction fdcb8d
  test('fdcb8d', () {
    // Set up machine initial state
    loadRegisters(0x14e3, 0xc330, 0x9aa2, 0x8418, 0x0000, 0x0000, 0x0000, 0x0000, 0x0d4f, 0x5669, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xc9);
    poke(0x0003, 0x8d);
    poke(0x5632, 0x9a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x14e3, 0xc330, 0x9aa2, 0x8498, 0x0000, 0x0000, 0x0000, 0x0000, 0x0d4f, 0x5669, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(22066), equals(0x98));
  }, tags: 'undocumented');


  // Test instruction fdcb8e
  test('fdcb8e', () {
    // Set up machine initial state
    loadRegisters(0xcb79, 0x0fff, 0xb244, 0xc902, 0x0000, 0x0000, 0x0000, 0x0000, 0x6246, 0x4c81, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xc2);
    poke(0x0003, 0x8e);
    poke(0x4c43, 0x7f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xcb79, 0x0fff, 0xb244, 0xc902, 0x0000, 0x0000, 0x0000, 0x0000, 0x6246, 0x4c81, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(19523), equals(0x7d));
  });


  // Test instruction fdcb8f
  test('fdcb8f', () {
    // Set up machine initial state
    loadRegisters(0x66b4, 0x5fbb, 0x6c9b, 0xd0e3, 0x0000, 0x0000, 0x0000, 0x0000, 0xac5a, 0x6b51, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xd4);
    poke(0x0003, 0x8f);
    poke(0x6b25, 0x59);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x59b4, 0x5fbb, 0x6c9b, 0xd0e3, 0x0000, 0x0000, 0x0000, 0x0000, 0xac5a, 0x6b51, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcb90
  test('fdcb90', () {
    // Set up machine initial state
    loadRegisters(0x1305, 0x1ce1, 0xd627, 0x7402, 0x0000, 0x0000, 0x0000, 0x0000, 0xb470, 0xd7f5, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xfd);
    poke(0x0003, 0x90);
    poke(0xd7f2, 0x70);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1305, 0x70e1, 0xd627, 0x7402, 0x0000, 0x0000, 0x0000, 0x0000, 0xb470, 0xd7f5, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcb91
  test('fdcb91', () {
    // Set up machine initial state
    loadRegisters(0x10df, 0xc48f, 0x0213, 0xfc7e, 0x0000, 0x0000, 0x0000, 0x0000, 0xbfab, 0x47d2, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xbf);
    poke(0x0003, 0x91);
    poke(0x4791, 0x0e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x10df, 0xc40a, 0x0213, 0xfc7e, 0x0000, 0x0000, 0x0000, 0x0000, 0xbfab, 0x47d2, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(18321), equals(0x0a));
  }, tags: 'undocumented');


  // Test instruction fdcb92
  test('fdcb92', () {
    // Set up machine initial state
    loadRegisters(0x6a11, 0xf89e, 0xf49d, 0xc115, 0x0000, 0x0000, 0x0000, 0x0000, 0xbc5d, 0x313a, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x0b);
    poke(0x0003, 0x92);
    poke(0x3145, 0xf6);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6a11, 0xf89e, 0xf29d, 0xc115, 0x0000, 0x0000, 0x0000, 0x0000, 0xbc5d, 0x313a, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(12613), equals(0xf2));
  }, tags: 'undocumented');


  // Test instruction fdcb93
  test('fdcb93', () {
    // Set up machine initial state
    loadRegisters(0x61e5, 0xcc2c, 0x959a, 0xb52b, 0x0000, 0x0000, 0x0000, 0x0000, 0xfa64, 0x2940, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x52);
    poke(0x0003, 0x93);
    poke(0x2992, 0x38);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x61e5, 0xcc2c, 0x9538, 0xb52b, 0x0000, 0x0000, 0x0000, 0x0000, 0xfa64, 0x2940, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcb94
  test('fdcb94', () {
    // Set up machine initial state
    loadRegisters(0x31b4, 0x3e5a, 0xfb3d, 0xab83, 0x0000, 0x0000, 0x0000, 0x0000, 0xa801, 0xfe1c, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x95);
    poke(0x0003, 0x94);
    poke(0xfdb1, 0x48);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x31b4, 0x3e5a, 0xfb3d, 0x4883, 0x0000, 0x0000, 0x0000, 0x0000, 0xa801, 0xfe1c, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcb95
  test('fdcb95', () {
    // Set up machine initial state
    loadRegisters(0x337e, 0x63a7, 0x2918, 0xed6b, 0x0000, 0x0000, 0x0000, 0x0000, 0xb12c, 0xe776, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x90);
    poke(0x0003, 0x95);
    poke(0xe706, 0xeb);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x337e, 0x63a7, 0x2918, 0xedeb, 0x0000, 0x0000, 0x0000, 0x0000, 0xb12c, 0xe776, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcb96
  test('fdcb96', () {
    // Set up machine initial state
    loadRegisters(0x5d99, 0xd9ec, 0xb6d0, 0x5ed5, 0x0000, 0x0000, 0x0000, 0x0000, 0x5d9d, 0xe6cf, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x9e);
    poke(0x0003, 0x96);
    poke(0xe66d, 0xfc);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5d99, 0xd9ec, 0xb6d0, 0x5ed5, 0x0000, 0x0000, 0x0000, 0x0000, 0x5d9d, 0xe6cf, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(58989), equals(0xf8));
  });


  // Test instruction fdcb97
  test('fdcb97', () {
    // Set up machine initial state
    loadRegisters(0xccb6, 0x8406, 0x72c6, 0x1ba7, 0x0000, 0x0000, 0x0000, 0x0000, 0x6dca, 0x187f, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x64);
    poke(0x0003, 0x97);
    poke(0x18e3, 0x9d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x99b6, 0x8406, 0x72c6, 0x1ba7, 0x0000, 0x0000, 0x0000, 0x0000, 0x6dca, 0x187f, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(6371), equals(0x99));
  }, tags: 'undocumented');


  // Test instruction fdcb98
  test('fdcb98', () {
    // Set up machine initial state
    loadRegisters(0x0495, 0x312f, 0x8000, 0xb749, 0x0000, 0x0000, 0x0000, 0x0000, 0xe9cb, 0x43b8, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xda);
    poke(0x0003, 0x98);
    poke(0x4392, 0x15);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0495, 0x152f, 0x8000, 0xb749, 0x0000, 0x0000, 0x0000, 0x0000, 0xe9cb, 0x43b8, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcb99
  test('fdcb99', () {
    // Set up machine initial state
    loadRegisters(0x2824, 0xa485, 0xa30b, 0xb286, 0x0000, 0x0000, 0x0000, 0x0000, 0x10b0, 0xd86c, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x78);
    poke(0x0003, 0x99);
    poke(0xd8e4, 0xb5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2824, 0xa4b5, 0xa30b, 0xb286, 0x0000, 0x0000, 0x0000, 0x0000, 0x10b0, 0xd86c, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcb9a
  test('fdcb9a', () {
    // Set up machine initial state
    loadRegisters(0xb0cc, 0xc40c, 0xdc1a, 0x014a, 0x0000, 0x0000, 0x0000, 0x0000, 0x2ff9, 0xd717, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x9c);
    poke(0x0003, 0x9a);
    poke(0xd6b3, 0x9d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb0cc, 0xc40c, 0x951a, 0x014a, 0x0000, 0x0000, 0x0000, 0x0000, 0x2ff9, 0xd717, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(54963), equals(0x95));
  }, tags: 'undocumented');


  // Test instruction fdcb9b
  test('fdcb9b', () {
    // Set up machine initial state
    loadRegisters(0xd092, 0xa6c2, 0x7900, 0x5448, 0x0000, 0x0000, 0x0000, 0x0000, 0xfab0, 0xcb1e, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x83);
    poke(0x0003, 0x9b);
    poke(0xcaa1, 0x95);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd092, 0xa6c2, 0x7995, 0x5448, 0x0000, 0x0000, 0x0000, 0x0000, 0xfab0, 0xcb1e, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcb9c
  test('fdcb9c', () {
    // Set up machine initial state
    loadRegisters(0xb58d, 0x1ed1, 0xe93b, 0x9e0c, 0x0000, 0x0000, 0x0000, 0x0000, 0x5605, 0x03b3, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x1e);
    poke(0x0003, 0x9c);
    poke(0x03d1, 0x78);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb58d, 0x1ed1, 0xe93b, 0x700c, 0x0000, 0x0000, 0x0000, 0x0000, 0x5605, 0x03b3, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(977), equals(0x70));
  }, tags: 'undocumented');


  // Test instruction fdcb9d
  test('fdcb9d', () {
    // Set up machine initial state
    loadRegisters(0xc7e9, 0x18d3, 0x8eed, 0xbd7d, 0x0000, 0x0000, 0x0000, 0x0000, 0x9a7f, 0xc087, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xe6);
    poke(0x0003, 0x9d);
    poke(0xc06d, 0x53);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc7e9, 0x18d3, 0x8eed, 0xbd53, 0x0000, 0x0000, 0x0000, 0x0000, 0x9a7f, 0xc087, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcb9e
  test('fdcb9e', () {
    // Set up machine initial state
    loadRegisters(0x81c7, 0x71df, 0x45d5, 0x0ca7, 0x0000, 0x0000, 0x0000, 0x0000, 0x648f, 0x41bd, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xeb);
    poke(0x0003, 0x9e);
    poke(0x41a8, 0x61);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x81c7, 0x71df, 0x45d5, 0x0ca7, 0x0000, 0x0000, 0x0000, 0x0000, 0x648f, 0x41bd, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  });


  // Test instruction fdcb9f
  test('fdcb9f', () {
    // Set up machine initial state
    loadRegisters(0xebf5, 0xdc9f, 0xd490, 0x15be, 0x0000, 0x0000, 0x0000, 0x0000, 0x0e12, 0x9d49, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x50);
    poke(0x0003, 0x9f);
    poke(0x9d99, 0x89);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x81f5, 0xdc9f, 0xd490, 0x15be, 0x0000, 0x0000, 0x0000, 0x0000, 0x0e12, 0x9d49, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(40345), equals(0x81));
  }, tags: 'undocumented');


  // Test instruction fdcba0
  test('fdcba0', () {
    // Set up machine initial state
    loadRegisters(0x8ccb, 0x0057, 0xbc19, 0xe543, 0x0000, 0x0000, 0x0000, 0x0000, 0x8c5d, 0xd68d, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x76);
    poke(0x0003, 0xa0);
    poke(0xd703, 0xd4);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8ccb, 0xc457, 0xbc19, 0xe543, 0x0000, 0x0000, 0x0000, 0x0000, 0x8c5d, 0xd68d, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(55043), equals(0xc4));
  }, tags: 'undocumented');


  // Test instruction fdcba1
  test('fdcba1', () {
    // Set up machine initial state
    loadRegisters(0xeee6, 0x6da4, 0x3a20, 0x8bba, 0x0000, 0x0000, 0x0000, 0x0000, 0x1de7, 0x66c8, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x31);
    poke(0x0003, 0xa1);
    poke(0x66f9, 0xec);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xeee6, 0x6dec, 0x3a20, 0x8bba, 0x0000, 0x0000, 0x0000, 0x0000, 0x1de7, 0x66c8, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcba2
  test('fdcba2', () {
    // Set up machine initial state
    loadRegisters(0x3f89, 0x5120, 0x0bd1, 0xe669, 0x0000, 0x0000, 0x0000, 0x0000, 0x2993, 0x04bf, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x0e);
    poke(0x0003, 0xa2);
    poke(0x04cd, 0x47);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3f89, 0x5120, 0x47d1, 0xe669, 0x0000, 0x0000, 0x0000, 0x0000, 0x2993, 0x04bf, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcba3
  test('fdcba3', () {
    // Set up machine initial state
    loadRegisters(0x4439, 0x6b8b, 0x6178, 0x1246, 0x0000, 0x0000, 0x0000, 0x0000, 0x4cdb, 0xad77, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x05);
    poke(0x0003, 0xa3);
    poke(0xad7c, 0x59);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4439, 0x6b8b, 0x6149, 0x1246, 0x0000, 0x0000, 0x0000, 0x0000, 0x4cdb, 0xad77, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(44412), equals(0x49));
  }, tags: 'undocumented');


  // Test instruction fdcba4
  test('fdcba4', () {
    // Set up machine initial state
    loadRegisters(0x3385, 0x261e, 0xa487, 0xb3bd, 0x0000, 0x0000, 0x0000, 0x0000, 0x4b8f, 0xc0cd, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x66);
    poke(0x0003, 0xa4);
    poke(0xc133, 0xc5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3385, 0x261e, 0xa487, 0xc5bd, 0x0000, 0x0000, 0x0000, 0x0000, 0x4b8f, 0xc0cd, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcba5
  test('fdcba5', () {
    // Set up machine initial state
    loadRegisters(0x6e70, 0xb7ed, 0x22cd, 0xaedc, 0x0000, 0x0000, 0x0000, 0x0000, 0x46de, 0xf1a1, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xa0);
    poke(0x0003, 0xa5);
    poke(0xf141, 0x44);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6e70, 0xb7ed, 0x22cd, 0xae44, 0x0000, 0x0000, 0x0000, 0x0000, 0x46de, 0xf1a1, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcba6
  test('fdcba6', () {
    // Set up machine initial state
    loadRegisters(0x814b, 0x6408, 0x3dcb, 0x971f, 0x0000, 0x0000, 0x0000, 0x0000, 0x5716, 0x93f3, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x76);
    poke(0x0003, 0xa6);
    poke(0x9469, 0xbc);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x814b, 0x6408, 0x3dcb, 0x971f, 0x0000, 0x0000, 0x0000, 0x0000, 0x5716, 0x93f3, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(37993), equals(0xac));
  });


  // Test instruction fdcba7
  test('fdcba7', () {
    // Set up machine initial state
    loadRegisters(0xa4c2, 0x679e, 0xc313, 0x61df, 0x0000, 0x0000, 0x0000, 0x0000, 0x67e6, 0x79c4, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x66);
    poke(0x0003, 0xa7);
    poke(0x7a2a, 0x2e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2ec2, 0x679e, 0xc313, 0x61df, 0x0000, 0x0000, 0x0000, 0x0000, 0x67e6, 0x79c4, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcba8
  test('fdcba8', () {
    // Set up machine initial state
    loadRegisters(0x537c, 0x1fed, 0x6cbb, 0xbd26, 0x0000, 0x0000, 0x0000, 0x0000, 0xc638, 0x0d46, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xa9);
    poke(0x0003, 0xa8);
    poke(0x0cef, 0xb7);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x537c, 0x97ed, 0x6cbb, 0xbd26, 0x0000, 0x0000, 0x0000, 0x0000, 0xc638, 0x0d46, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(3311), equals(0x97));
  }, tags: 'undocumented');


  // Test instruction fdcba9
  test('fdcba9', () {
    // Set up machine initial state
    loadRegisters(0xba5a, 0x3076, 0xcdd7, 0x298d, 0x0000, 0x0000, 0x0000, 0x0000, 0x59ab, 0x0f54, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x2b);
    poke(0x0003, 0xa9);
    poke(0x0f7f, 0x8f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xba5a, 0x308f, 0xcdd7, 0x298d, 0x0000, 0x0000, 0x0000, 0x0000, 0x59ab, 0x0f54, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbaa
  test('fdcbaa', () {
    // Set up machine initial state
    loadRegisters(0x406a, 0x2ed6, 0xfa8c, 0xc633, 0x0000, 0x0000, 0x0000, 0x0000, 0x87cb, 0xb3d1, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x0b);
    poke(0x0003, 0xaa);
    poke(0xb3dc, 0x3a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x406a, 0x2ed6, 0x1a8c, 0xc633, 0x0000, 0x0000, 0x0000, 0x0000, 0x87cb, 0xb3d1, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(46044), equals(0x1a));
  }, tags: 'undocumented');


  // Test instruction fdcbab
  test('fdcbab', () {
    // Set up machine initial state
    loadRegisters(0xda61, 0x0521, 0xa123, 0xc7fa, 0x0000, 0x0000, 0x0000, 0x0000, 0xb71a, 0x8ece, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xa9);
    poke(0x0003, 0xab);
    poke(0x8e77, 0x1f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xda61, 0x0521, 0xa11f, 0xc7fa, 0x0000, 0x0000, 0x0000, 0x0000, 0xb71a, 0x8ece, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbac
  test('fdcbac', () {
    // Set up machine initial state
    loadRegisters(0x34a3, 0x81ce, 0x07d6, 0xf3a4, 0x0000, 0x0000, 0x0000, 0x0000, 0x430b, 0x0525, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x23);
    poke(0x0003, 0xac);
    poke(0x0548, 0x9c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x34a3, 0x81ce, 0x07d6, 0x9ca4, 0x0000, 0x0000, 0x0000, 0x0000, 0x430b, 0x0525, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbad
  test('fdcbad', () {
    // Set up machine initial state
    loadRegisters(0x5010, 0x918e, 0xddbc, 0x4f89, 0x0000, 0x0000, 0x0000, 0x0000, 0x88c5, 0x948f, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x4e);
    poke(0x0003, 0xad);
    poke(0x94dd, 0x37);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5010, 0x918e, 0xddbc, 0x4f17, 0x0000, 0x0000, 0x0000, 0x0000, 0x88c5, 0x948f, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(38109), equals(0x17));
  }, tags: 'undocumented');


  // Test instruction fdcbae
  test('fdcbae', () {
    // Set up machine initial state
    loadRegisters(0xec0d, 0xb57e, 0x18c6, 0x7b01, 0x0000, 0x0000, 0x0000, 0x0000, 0xbac6, 0x0c1d, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x0c);
    poke(0x0003, 0xae);
    poke(0x0c29, 0xa9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xec0d, 0xb57e, 0x18c6, 0x7b01, 0x0000, 0x0000, 0x0000, 0x0000, 0xbac6, 0x0c1d, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(3113), equals(0x89));
  });


  // Test instruction fdcbaf
  test('fdcbaf', () {
    // Set up machine initial state
    loadRegisters(0xb322, 0x6731, 0xdaad, 0x8d38, 0x0000, 0x0000, 0x0000, 0x0000, 0xdd8f, 0x26eb, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x0d);
    poke(0x0003, 0xaf);
    poke(0x26f8, 0x44);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4422, 0x6731, 0xdaad, 0x8d38, 0x0000, 0x0000, 0x0000, 0x0000, 0xdd8f, 0x26eb, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbb0
  test('fdcbb0', () {
    // Set up machine initial state
    loadRegisters(0xb984, 0x796c, 0x44b1, 0xfef9, 0x0000, 0x0000, 0x0000, 0x0000, 0x4069, 0xa0cb, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x5a);
    poke(0x0003, 0xb0);
    poke(0xa125, 0x76);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb984, 0x366c, 0x44b1, 0xfef9, 0x0000, 0x0000, 0x0000, 0x0000, 0x4069, 0xa0cb, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(41253), equals(0x36));
  }, tags: 'undocumented');


  // Test instruction fdcbb1
  test('fdcbb1', () {
    // Set up machine initial state
    loadRegisters(0x59c3, 0xab13, 0x42ee, 0xb764, 0x0000, 0x0000, 0x0000, 0x0000, 0x8f7f, 0xf398, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x82);
    poke(0x0003, 0xb1);
    poke(0xf31a, 0x79);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x59c3, 0xab39, 0x42ee, 0xb764, 0x0000, 0x0000, 0x0000, 0x0000, 0x8f7f, 0xf398, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(62234), equals(0x39));
  }, tags: 'undocumented');


  // Test instruction fdcbb2
  test('fdcbb2', () {
    // Set up machine initial state
    loadRegisters(0xf310, 0xceec, 0xbbfb, 0x3569, 0x0000, 0x0000, 0x0000, 0x0000, 0x4a6f, 0x33f9, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x23);
    poke(0x0003, 0xb2);
    poke(0x341c, 0x7b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xf310, 0xceec, 0x3bfb, 0x3569, 0x0000, 0x0000, 0x0000, 0x0000, 0x4a6f, 0x33f9, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(13340), equals(0x3b));
  }, tags: 'undocumented');


  // Test instruction fdcbb3
  test('fdcbb3', () {
    // Set up machine initial state
    loadRegisters(0x9c05, 0x0f92, 0xbd3b, 0x553d, 0x0000, 0x0000, 0x0000, 0x0000, 0xc75e, 0x51d2, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x6c);
    poke(0x0003, 0xb3);
    poke(0x523e, 0x37);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9c05, 0x0f92, 0xbd37, 0x553d, 0x0000, 0x0000, 0x0000, 0x0000, 0xc75e, 0x51d2, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbb4
  test('fdcbb4', () {
    // Set up machine initial state
    loadRegisters(0x3e55, 0x1338, 0x638d, 0x353c, 0x0000, 0x0000, 0x0000, 0x0000, 0x44ad, 0x4d17, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xc5);
    poke(0x0003, 0xb4);
    poke(0x4cdc, 0xe9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3e55, 0x1338, 0x638d, 0xa93c, 0x0000, 0x0000, 0x0000, 0x0000, 0x44ad, 0x4d17, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(19676), equals(0xa9));
  }, tags: 'undocumented');


  // Test instruction fdcbb5
  test('fdcbb5', () {
    // Set up machine initial state
    loadRegisters(0x2f3a, 0xb709, 0x4167, 0x57be, 0x0000, 0x0000, 0x0000, 0x0000, 0xb543, 0x8edd, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x50);
    poke(0x0003, 0xb5);
    poke(0x8f2d, 0x0f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2f3a, 0xb709, 0x4167, 0x570f, 0x0000, 0x0000, 0x0000, 0x0000, 0xb543, 0x8edd, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbb6
  test('fdcbb6', () {
    // Set up machine initial state
    loadRegisters(0xa887, 0x519b, 0xc91b, 0xcc91, 0x0000, 0x0000, 0x0000, 0x0000, 0xa416, 0x1e16, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x3a);
    poke(0x0003, 0xb6);
    poke(0x1e50, 0x13);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xa887, 0x519b, 0xc91b, 0xcc91, 0x0000, 0x0000, 0x0000, 0x0000, 0xa416, 0x1e16, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  });


  // Test instruction fdcbb7
  test('fdcbb7', () {
    // Set up machine initial state
    loadRegisters(0x1335, 0xa599, 0x9fbf, 0xc111, 0x0000, 0x0000, 0x0000, 0x0000, 0x8bc5, 0x00a9, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xc0);
    poke(0x0003, 0xb7);
    poke(0x0069, 0x38);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3835, 0xa599, 0x9fbf, 0xc111, 0x0000, 0x0000, 0x0000, 0x0000, 0x8bc5, 0x00a9, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbb8
  test('fdcbb8', () {
    // Set up machine initial state
    loadRegisters(0xd146, 0x1138, 0x1a45, 0x8259, 0x0000, 0x0000, 0x0000, 0x0000, 0x6a03, 0xd087, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x31);
    poke(0x0003, 0xb8);
    poke(0xd0b8, 0x17);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd146, 0x1738, 0x1a45, 0x8259, 0x0000, 0x0000, 0x0000, 0x0000, 0x6a03, 0xd087, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbb9
  test('fdcbb9', () {
    // Set up machine initial state
    loadRegisters(0x757b, 0x0b9e, 0x767b, 0x2ad1, 0x0000, 0x0000, 0x0000, 0x0000, 0x1498, 0xb84e, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x3b);
    poke(0x0003, 0xb9);
    poke(0xb889, 0xb4);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x757b, 0x0b34, 0x767b, 0x2ad1, 0x0000, 0x0000, 0x0000, 0x0000, 0x1498, 0xb84e, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(47241), equals(0x34));
  }, tags: 'undocumented');


  // Test instruction fdcbba
  test('fdcbba', () {
    // Set up machine initial state
    loadRegisters(0x43ef, 0x1c58, 0xdda3, 0x4519, 0x0000, 0x0000, 0x0000, 0x0000, 0xb67b, 0x383f, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x38);
    poke(0x0003, 0xba);
    poke(0x3877, 0xd6);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x43ef, 0x1c58, 0x56a3, 0x4519, 0x0000, 0x0000, 0x0000, 0x0000, 0xb67b, 0x383f, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(14455), equals(0x56));
  }, tags: 'undocumented');


  // Test instruction fdcbbb
  test('fdcbbb', () {
    // Set up machine initial state
    loadRegisters(0xdccb, 0x7ab3, 0x7615, 0x4161, 0x0000, 0x0000, 0x0000, 0x0000, 0x2942, 0xe2fe, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x07);
    poke(0x0003, 0xbb);
    poke(0xe305, 0x6e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xdccb, 0x7ab3, 0x766e, 0x4161, 0x0000, 0x0000, 0x0000, 0x0000, 0x2942, 0xe2fe, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbbc
  test('fdcbbc', () {
    // Set up machine initial state
    loadRegisters(0x0e07, 0x34f5, 0x0995, 0xcc42, 0x0000, 0x0000, 0x0000, 0x0000, 0x9d42, 0xaf0c, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xf8);
    poke(0x0003, 0xbc);
    poke(0xaf04, 0xcf);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0e07, 0x34f5, 0x0995, 0x4f42, 0x0000, 0x0000, 0x0000, 0x0000, 0x9d42, 0xaf0c, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(44804), equals(0x4f));
  }, tags: 'undocumented');


  // Test instruction fdcbbd
  test('fdcbbd', () {
    // Set up machine initial state
    loadRegisters(0x30ef, 0xe60c, 0x9bf0, 0xa1bf, 0x0000, 0x0000, 0x0000, 0x0000, 0xbd1c, 0xdf0d, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xaa);
    poke(0x0003, 0xbd);
    poke(0xdeb7, 0x8d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x30ef, 0xe60c, 0x9bf0, 0xa10d, 0x0000, 0x0000, 0x0000, 0x0000, 0xbd1c, 0xdf0d, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(57015), equals(0x0d));
  }, tags: 'undocumented');


  // Test instruction fdcbbe
  test('fdcbbe', () {
    // Set up machine initial state
    loadRegisters(0x1133, 0xbef6, 0x5059, 0x1089, 0x0000, 0x0000, 0x0000, 0x0000, 0xd558, 0x3d0f, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xc8);
    poke(0x0003, 0xbe);
    poke(0x3cd7, 0xa1);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1133, 0xbef6, 0x5059, 0x1089, 0x0000, 0x0000, 0x0000, 0x0000, 0xd558, 0x3d0f, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(15575), equals(0x21));
  });


  // Test instruction fdcbbf
  test('fdcbbf', () {
    // Set up machine initial state
    loadRegisters(0x83d6, 0xc893, 0x8db8, 0x716b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0956, 0xbde7, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xfd);
    poke(0x0003, 0xbf);
    poke(0xbde4, 0xac);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x2cd6, 0xc893, 0x8db8, 0x716b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0956, 0xbde7, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(48612), equals(0x2c));
  }, tags: 'undocumented');


  // Test instruction fdcbc0
  test('fdcbc0', () {
    // Set up machine initial state
    loadRegisters(0x3666, 0x676c, 0x35e5, 0xdb0a, 0x0000, 0x0000, 0x0000, 0x0000, 0xea93, 0x2b31, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x0a);
    poke(0x0003, 0xc0);
    poke(0x2b3b, 0xec);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3666, 0xed6c, 0x35e5, 0xdb0a, 0x0000, 0x0000, 0x0000, 0x0000, 0xea93, 0x2b31, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(11067), equals(0xed));
  }, tags: 'undocumented');


  // Test instruction fdcbc1
  test('fdcbc1', () {
    // Set up machine initial state
    loadRegisters(0x3902, 0xd498, 0xaf62, 0x9821, 0x0000, 0x0000, 0x0000, 0x0000, 0x48b8, 0xbd67, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x87);
    poke(0x0003, 0xc1);
    poke(0xbcee, 0xee);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3902, 0xd4ef, 0xaf62, 0x9821, 0x0000, 0x0000, 0x0000, 0x0000, 0x48b8, 0xbd67, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(48366), equals(0xef));
  }, tags: 'undocumented');


  // Test instruction fdcbc2
  test('fdcbc2', () {
    // Set up machine initial state
    loadRegisters(0xad26, 0x5a6d, 0x6762, 0x16c9, 0x0000, 0x0000, 0x0000, 0x0000, 0x495a, 0x5b2c, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x8d);
    poke(0x0003, 0xc2);
    poke(0x5ab9, 0xc2);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xad26, 0x5a6d, 0xc362, 0x16c9, 0x0000, 0x0000, 0x0000, 0x0000, 0x495a, 0x5b2c, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(23225), equals(0xc3));
  }, tags: 'undocumented');


  // Test instruction fdcbc3
  test('fdcbc3', () {
    // Set up machine initial state
    loadRegisters(0x3e6c, 0x9a74, 0xa2ee, 0x9838, 0x0000, 0x0000, 0x0000, 0x0000, 0xeafa, 0xe666, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x5a);
    poke(0x0003, 0xc3);
    poke(0xe6c0, 0x4f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3e6c, 0x9a74, 0xa24f, 0x9838, 0x0000, 0x0000, 0x0000, 0x0000, 0xeafa, 0xe666, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbc4
  test('fdcbc4', () {
    // Set up machine initial state
    loadRegisters(0xbf68, 0xd00b, 0x5283, 0x51c2, 0x0000, 0x0000, 0x0000, 0x0000, 0x517c, 0x5d10, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x89);
    poke(0x0003, 0xc4);
    poke(0x5c99, 0x61);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xbf68, 0xd00b, 0x5283, 0x61c2, 0x0000, 0x0000, 0x0000, 0x0000, 0x517c, 0x5d10, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbc5
  test('fdcbc5', () {
    // Set up machine initial state
    loadRegisters(0x127b, 0xdb6a, 0x00b9, 0x5138, 0x0000, 0x0000, 0x0000, 0x0000, 0x98f6, 0x02bb, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xa9);
    poke(0x0003, 0xc5);
    poke(0x0264, 0xcd);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x127b, 0xdb6a, 0x00b9, 0x51cd, 0x0000, 0x0000, 0x0000, 0x0000, 0x98f6, 0x02bb, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbc6
  test('fdcbc6', () {
    // Set up machine initial state
    loadRegisters(0x35da, 0x98c2, 0x3f57, 0x44a4, 0x0000, 0x0000, 0x0000, 0x0000, 0x2771, 0x76c4, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xee);
    poke(0x0003, 0xc6);
    poke(0x76b2, 0x82);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x35da, 0x98c2, 0x3f57, 0x44a4, 0x0000, 0x0000, 0x0000, 0x0000, 0x2771, 0x76c4, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(30386), equals(0x83));
  });


  // Test instruction fdcbc7
  test('fdcbc7', () {
    // Set up machine initial state
    loadRegisters(0x763f, 0xb86f, 0x12d3, 0x7e2d, 0x0000, 0x0000, 0x0000, 0x0000, 0xd870, 0xf30b, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x9e);
    poke(0x0003, 0xc7);
    poke(0xf2a9, 0xd7);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd73f, 0xb86f, 0x12d3, 0x7e2d, 0x0000, 0x0000, 0x0000, 0x0000, 0xd870, 0xf30b, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbc8
  test('fdcbc8', () {
    // Set up machine initial state
    loadRegisters(0x1f81, 0xc7c0, 0x85da, 0x3cdd, 0x0000, 0x0000, 0x0000, 0x0000, 0xd854, 0xc412, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x10);
    poke(0x0003, 0xc8);
    poke(0xc422, 0xe9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1f81, 0xebc0, 0x85da, 0x3cdd, 0x0000, 0x0000, 0x0000, 0x0000, 0xd854, 0xc412, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(50210), equals(0xeb));
  }, tags: 'undocumented');


  // Test instruction fdcbc9
  test('fdcbc9', () {
    // Set up machine initial state
    loadRegisters(0xed19, 0x3f88, 0x1370, 0xe084, 0x0000, 0x0000, 0x0000, 0x0000, 0x4fdd, 0x8b42, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x61);
    poke(0x0003, 0xc9);
    poke(0x8ba3, 0xb7);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xed19, 0x3fb7, 0x1370, 0xe084, 0x0000, 0x0000, 0x0000, 0x0000, 0x4fdd, 0x8b42, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbca
  test('fdcbca', () {
    // Set up machine initial state
    loadRegisters(0xc7e5, 0x233b, 0x2312, 0xf7f9, 0x0000, 0x0000, 0x0000, 0x0000, 0xe417, 0x5190, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x1a);
    poke(0x0003, 0xca);
    poke(0x51aa, 0x90);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc7e5, 0x233b, 0x9212, 0xf7f9, 0x0000, 0x0000, 0x0000, 0x0000, 0xe417, 0x5190, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(20906), equals(0x92));
  }, tags: 'undocumented');


  // Test instruction fdcbcb
  test('fdcbcb', () {
    // Set up machine initial state
    loadRegisters(0xbdba, 0xa964, 0xea38, 0x9422, 0x0000, 0x0000, 0x0000, 0x0000, 0xfca3, 0x9a72, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x5e);
    poke(0x0003, 0xcb);
    poke(0x9ad0, 0x70);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xbdba, 0xa964, 0xea72, 0x9422, 0x0000, 0x0000, 0x0000, 0x0000, 0xfca3, 0x9a72, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(39632), equals(0x72));
  }, tags: 'undocumented');


  // Test instruction fdcbcc
  test('fdcbcc', () {
    // Set up machine initial state
    loadRegisters(0x0f4f, 0x0261, 0x21b0, 0x2097, 0x0000, 0x0000, 0x0000, 0x0000, 0x575d, 0x14f9, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x2d);
    poke(0x0003, 0xcc);
    poke(0x1526, 0x4e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0f4f, 0x0261, 0x21b0, 0x4e97, 0x0000, 0x0000, 0x0000, 0x0000, 0x575d, 0x14f9, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbcd
  test('fdcbcd', () {
    // Set up machine initial state
    loadRegisters(0x1b79, 0x8f9f, 0x31bf, 0x9ca6, 0x0000, 0x0000, 0x0000, 0x0000, 0x7ecb, 0xbbe9, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xa1);
    poke(0x0003, 0xcd);
    poke(0xbb8a, 0x66);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1b79, 0x8f9f, 0x31bf, 0x9c66, 0x0000, 0x0000, 0x0000, 0x0000, 0x7ecb, 0xbbe9, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbce
  test('fdcbce', () {
    // Set up machine initial state
    loadRegisters(0x8e13, 0x968e, 0x1784, 0x0a0a, 0x0000, 0x0000, 0x0000, 0x0000, 0x1e87, 0xb8a2, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x36);
    poke(0x0003, 0xce);
    poke(0xb8d8, 0x45);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8e13, 0x968e, 0x1784, 0x0a0a, 0x0000, 0x0000, 0x0000, 0x0000, 0x1e87, 0xb8a2, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(47320), equals(0x47));
  });


  // Test instruction fdcbcf
  test('fdcbcf', () {
    // Set up machine initial state
    loadRegisters(0x8d0a, 0xa073, 0xc4ba, 0x5b69, 0x0000, 0x0000, 0x0000, 0x0000, 0x3b47, 0xc29c, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x70);
    poke(0x0003, 0xcf);
    poke(0xc30c, 0x7a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7a0a, 0xa073, 0xc4ba, 0x5b69, 0x0000, 0x0000, 0x0000, 0x0000, 0x3b47, 0xc29c, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbd0
  test('fdcbd0', () {
    // Set up machine initial state
    loadRegisters(0xe2bb, 0x8635, 0x650c, 0x689a, 0x0000, 0x0000, 0x0000, 0x0000, 0x1294, 0x3beb, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xbc);
    poke(0x0003, 0xd0);
    poke(0x3ba7, 0x20);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe2bb, 0x2435, 0x650c, 0x689a, 0x0000, 0x0000, 0x0000, 0x0000, 0x1294, 0x3beb, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(15271), equals(0x24));
  }, tags: 'undocumented');


  // Test instruction fdcbd1
  test('fdcbd1', () {
    // Set up machine initial state
    loadRegisters(0x5df8, 0xf701, 0x9494, 0x4967, 0x0000, 0x0000, 0x0000, 0x0000, 0xad00, 0x8c65, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x11);
    poke(0x0003, 0xd1);
    poke(0x8c76, 0xb9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5df8, 0xf7bd, 0x9494, 0x4967, 0x0000, 0x0000, 0x0000, 0x0000, 0xad00, 0x8c65, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(35958), equals(0xbd));
  }, tags: 'undocumented');


  // Test instruction fdcbd2
  test('fdcbd2', () {
    // Set up machine initial state
    loadRegisters(0x9876, 0x4bd9, 0x3148, 0x665a, 0x0000, 0x0000, 0x0000, 0x0000, 0x7eac, 0xc051, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xfb);
    poke(0x0003, 0xd2);
    poke(0xc04c, 0x51);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9876, 0x4bd9, 0x5548, 0x665a, 0x0000, 0x0000, 0x0000, 0x0000, 0x7eac, 0xc051, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(49228), equals(0x55));
  }, tags: 'undocumented');


  // Test instruction fdcbd3
  test('fdcbd3', () {
    // Set up machine initial state
    loadRegisters(0x8f90, 0xbacd, 0xe87a, 0x538f, 0x0000, 0x0000, 0x0000, 0x0000, 0xfe5a, 0x0a87, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x3e);
    poke(0x0003, 0xd3);
    poke(0x0ac5, 0xe0);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8f90, 0xbacd, 0xe8e4, 0x538f, 0x0000, 0x0000, 0x0000, 0x0000, 0xfe5a, 0x0a87, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(2757), equals(0xe4));
  }, tags: 'undocumented');


  // Test instruction fdcbd4
  test('fdcbd4', () {
    // Set up machine initial state
    loadRegisters(0x15e2, 0x1820, 0x5588, 0xe67f, 0x0000, 0x0000, 0x0000, 0x0000, 0x7193, 0x9478, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x36);
    poke(0x0003, 0xd4);
    poke(0x94ae, 0x7d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x15e2, 0x1820, 0x5588, 0x7d7f, 0x0000, 0x0000, 0x0000, 0x0000, 0x7193, 0x9478, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbd5
  test('fdcbd5', () {
    // Set up machine initial state
    loadRegisters(0x1409, 0x6535, 0xc371, 0xabe2, 0x0000, 0x0000, 0x0000, 0x0000, 0x2e10, 0x8608, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x48);
    poke(0x0003, 0xd5);
    poke(0x8650, 0x98);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1409, 0x6535, 0xc371, 0xab9c, 0x0000, 0x0000, 0x0000, 0x0000, 0x2e10, 0x8608, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(34384), equals(0x9c));
  }, tags: 'undocumented');


  // Test instruction fdcbd6
  test('fdcbd6', () {
    // Set up machine initial state
    loadRegisters(0x7801, 0x78b6, 0xd191, 0x054a, 0x0000, 0x0000, 0x0000, 0x0000, 0x2065, 0x6aa3, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xc9);
    poke(0x0003, 0xd6);
    poke(0x6a6c, 0x7c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7801, 0x78b6, 0xd191, 0x054a, 0x0000, 0x0000, 0x0000, 0x0000, 0x2065, 0x6aa3, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  });


  // Test instruction fdcbd7
  test('fdcbd7', () {
    // Set up machine initial state
    loadRegisters(0x1b6a, 0x266e, 0x387f, 0x7fcb, 0x0000, 0x0000, 0x0000, 0x0000, 0x1941, 0x36ab, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xbe);
    poke(0x0003, 0xd7);
    poke(0x3669, 0x95);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x956a, 0x266e, 0x387f, 0x7fcb, 0x0000, 0x0000, 0x0000, 0x0000, 0x1941, 0x36ab, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbd8
  test('fdcbd8', () {
    // Set up machine initial state
    loadRegisters(0x7b1b, 0xa191, 0xefee, 0x55b9, 0x0000, 0x0000, 0x0000, 0x0000, 0xf789, 0x43f8, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xbc);
    poke(0x0003, 0xd8);
    poke(0x43b4, 0xd8);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7b1b, 0xd891, 0xefee, 0x55b9, 0x0000, 0x0000, 0x0000, 0x0000, 0xf789, 0x43f8, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbd9
  test('fdcbd9', () {
    // Set up machine initial state
    loadRegisters(0x0faf, 0x4eda, 0xc556, 0x6ed3, 0x0000, 0x0000, 0x0000, 0x0000, 0x3fc3, 0x0a66, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x16);
    poke(0x0003, 0xd9);
    poke(0x0a7c, 0xf4);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0faf, 0x4efc, 0xc556, 0x6ed3, 0x0000, 0x0000, 0x0000, 0x0000, 0x3fc3, 0x0a66, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(2684), equals(0xfc));
  }, tags: 'undocumented');


  // Test instruction fdcbda
  test('fdcbda', () {
    // Set up machine initial state
    loadRegisters(0x9ea1, 0x8186, 0xc045, 0xd6e0, 0x0000, 0x0000, 0x0000, 0x0000, 0x34d3, 0xd0f0, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xe8);
    poke(0x0003, 0xda);
    poke(0xd0d8, 0x6b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9ea1, 0x8186, 0x6b45, 0xd6e0, 0x0000, 0x0000, 0x0000, 0x0000, 0x34d3, 0xd0f0, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbdb
  test('fdcbdb', () {
    // Set up machine initial state
    loadRegisters(0x5ee0, 0xbdea, 0xd00e, 0x513f, 0x0000, 0x0000, 0x0000, 0x0000, 0x690a, 0x8c29, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x7a);
    poke(0x0003, 0xdb);
    poke(0x8ca3, 0x15);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5ee0, 0xbdea, 0xd01d, 0x513f, 0x0000, 0x0000, 0x0000, 0x0000, 0x690a, 0x8c29, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(36003), equals(0x1d));
  }, tags: 'undocumented');


  // Test instruction fdcbdc
  test('fdcbdc', () {
    // Set up machine initial state
    loadRegisters(0x5cfa, 0x2e2b, 0x1d17, 0xdbf6, 0x0000, 0x0000, 0x0000, 0x0000, 0xa4f2, 0x593a, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x64);
    poke(0x0003, 0xdc);
    poke(0x599e, 0x15);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5cfa, 0x2e2b, 0x1d17, 0x1df6, 0x0000, 0x0000, 0x0000, 0x0000, 0xa4f2, 0x593a, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(22942), equals(0x1d));
  }, tags: 'undocumented');


  // Test instruction fdcbdd
  test('fdcbdd', () {
    // Set up machine initial state
    loadRegisters(0x8773, 0x70a6, 0x83ce, 0x52b8, 0x0000, 0x0000, 0x0000, 0x0000, 0x35da, 0x1d94, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x75);
    poke(0x0003, 0xdd);
    poke(0x1e09, 0x28);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8773, 0x70a6, 0x83ce, 0x5228, 0x0000, 0x0000, 0x0000, 0x0000, 0x35da, 0x1d94, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbde
  test('fdcbde', () {
    // Set up machine initial state
    loadRegisters(0x8310, 0xfa01, 0x6c69, 0x252a, 0x0000, 0x0000, 0x0000, 0x0000, 0x5291, 0xc9e0, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x17);
    poke(0x0003, 0xde);
    poke(0xc9f7, 0x41);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8310, 0xfa01, 0x6c69, 0x252a, 0x0000, 0x0000, 0x0000, 0x0000, 0x5291, 0xc9e0, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(51703), equals(0x49));
  });


  // Test instruction fdcbdf
  test('fdcbdf', () {
    // Set up machine initial state
    loadRegisters(0x780d, 0xa722, 0xe78e, 0x50ba, 0x0000, 0x0000, 0x0000, 0x0000, 0x9d67, 0xeac3, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x93);
    poke(0x0003, 0xdf);
    poke(0xea56, 0xef);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xef0d, 0xa722, 0xe78e, 0x50ba, 0x0000, 0x0000, 0x0000, 0x0000, 0x9d67, 0xeac3, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbe0
  test('fdcbe0', () {
    // Set up machine initial state
    loadRegisters(0x10ef, 0x4101, 0x2ca5, 0xf752, 0x0000, 0x0000, 0x0000, 0x0000, 0x4747, 0x1507, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x56);
    poke(0x0003, 0xe0);
    poke(0x155d, 0xb9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x10ef, 0xb901, 0x2ca5, 0xf752, 0x0000, 0x0000, 0x0000, 0x0000, 0x4747, 0x1507, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbe1
  test('fdcbe1', () {
    // Set up machine initial state
    loadRegisters(0xe4cb, 0x6f72, 0x1c11, 0x1426, 0x0000, 0x0000, 0x0000, 0x0000, 0x189b, 0x0e0d, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xd1);
    poke(0x0003, 0xe1);
    poke(0x0dde, 0x16);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe4cb, 0x6f16, 0x1c11, 0x1426, 0x0000, 0x0000, 0x0000, 0x0000, 0x189b, 0x0e0d, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbe2
  test('fdcbe2', () {
    // Set up machine initial state
    loadRegisters(0x11a9, 0xbae8, 0x938b, 0xbac4, 0x0000, 0x0000, 0x0000, 0x0000, 0xd8ed, 0xe49c, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x50);
    poke(0x0003, 0xe2);
    poke(0xe4ec, 0xc2);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x11a9, 0xbae8, 0xd28b, 0xbac4, 0x0000, 0x0000, 0x0000, 0x0000, 0xd8ed, 0xe49c, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(58604), equals(0xd2));
  }, tags: 'undocumented');


  // Test instruction fdcbe3
  test('fdcbe3', () {
    // Set up machine initial state
    loadRegisters(0x8832, 0x952b, 0x02b2, 0x26ef, 0x0000, 0x0000, 0x0000, 0x0000, 0xfb55, 0xada8, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xca);
    poke(0x0003, 0xe3);
    poke(0xad72, 0xba);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x8832, 0x952b, 0x02ba, 0x26ef, 0x0000, 0x0000, 0x0000, 0x0000, 0xfb55, 0xada8, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbe4
  test('fdcbe4', () {
    // Set up machine initial state
    loadRegisters(0x3989, 0x4142, 0x89e2, 0x785b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0bf7, 0x5474, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x62);
    poke(0x0003, 0xe4);
    poke(0x54d6, 0x7b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3989, 0x4142, 0x89e2, 0x7b5b, 0x0000, 0x0000, 0x0000, 0x0000, 0x0bf7, 0x5474, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbe5
  test('fdcbe5', () {
    // Set up machine initial state
    loadRegisters(0xe5c5, 0xb86d, 0x41bb, 0x315e, 0x0000, 0x0000, 0x0000, 0x0000, 0x1a78, 0xa52d, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xda);
    poke(0x0003, 0xe5);
    poke(0xa507, 0x4c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe5c5, 0xb86d, 0x41bb, 0x315c, 0x0000, 0x0000, 0x0000, 0x0000, 0x1a78, 0xa52d, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(42247), equals(0x5c));
  }, tags: 'undocumented');


  // Test instruction fdcbe6
  test('fdcbe6', () {
    // Set up machine initial state
    loadRegisters(0xfd89, 0xd888, 0x1e2f, 0xddf5, 0x0000, 0x0000, 0x0000, 0x0000, 0x42f5, 0x8b06, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x76);
    poke(0x0003, 0xe6);
    poke(0x8b7c, 0x45);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xfd89, 0xd888, 0x1e2f, 0xddf5, 0x0000, 0x0000, 0x0000, 0x0000, 0x42f5, 0x8b06, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(35708), equals(0x55));
  });


  // Test instruction fdcbe7
  test('fdcbe7', () {
    // Set up machine initial state
    loadRegisters(0x2025, 0xd3e9, 0xd4b6, 0xaa30, 0x0000, 0x0000, 0x0000, 0x0000, 0x88bd, 0xb597, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x11);
    poke(0x0003, 0xe7);
    poke(0xb5a8, 0xa6);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb625, 0xd3e9, 0xd4b6, 0xaa30, 0x0000, 0x0000, 0x0000, 0x0000, 0x88bd, 0xb597, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(46504), equals(0xb6));
  }, tags: 'undocumented');


  // Test instruction fdcbe8
  test('fdcbe8', () {
    // Set up machine initial state
    loadRegisters(0x514d, 0xc2ab, 0x37b5, 0x57de, 0x0000, 0x0000, 0x0000, 0x0000, 0xa4ec, 0x0a77, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xed);
    poke(0x0003, 0xe8);
    poke(0x0a64, 0xd0);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x514d, 0xf0ab, 0x37b5, 0x57de, 0x0000, 0x0000, 0x0000, 0x0000, 0xa4ec, 0x0a77, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(2660), equals(0xf0));
  }, tags: 'undocumented');


  // Test instruction fdcbe9
  test('fdcbe9', () {
    // Set up machine initial state
    loadRegisters(0x974e, 0xd28e, 0xd5cb, 0x6bd4, 0x0000, 0x0000, 0x0000, 0x0000, 0x158a, 0xa84e, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x35);
    poke(0x0003, 0xe9);
    poke(0xa883, 0x2f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x974e, 0xd22f, 0xd5cb, 0x6bd4, 0x0000, 0x0000, 0x0000, 0x0000, 0x158a, 0xa84e, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbea
  test('fdcbea', () {
    // Set up machine initial state
    loadRegisters(0x3ef4, 0x3fc6, 0x4a44, 0xe9a4, 0x0000, 0x0000, 0x0000, 0x0000, 0xc877, 0x7593, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x93);
    poke(0x0003, 0xea);
    poke(0x7526, 0x1b);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x3ef4, 0x3fc6, 0x3b44, 0xe9a4, 0x0000, 0x0000, 0x0000, 0x0000, 0xc877, 0x7593, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(29990), equals(0x3b));
  }, tags: 'undocumented');


  // Test instruction fdcbeb
  test('fdcbeb', () {
    // Set up machine initial state
    loadRegisters(0x798f, 0x5e9b, 0x940e, 0x2e52, 0x0000, 0x0000, 0x0000, 0x0000, 0xd6ad, 0x2411, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xd0);
    poke(0x0003, 0xeb);
    poke(0x23e1, 0x47);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x798f, 0x5e9b, 0x9467, 0x2e52, 0x0000, 0x0000, 0x0000, 0x0000, 0xd6ad, 0x2411, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(9185), equals(0x67));
  }, tags: 'undocumented');


  // Test instruction fdcbec
  test('fdcbec', () {
    // Set up machine initial state
    loadRegisters(0x38a4, 0x07c0, 0x6cee, 0xe715, 0x0000, 0x0000, 0x0000, 0x0000, 0xf160, 0xd2eb, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xf3);
    poke(0x0003, 0xec);
    poke(0xd2de, 0x49);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x38a4, 0x07c0, 0x6cee, 0x6915, 0x0000, 0x0000, 0x0000, 0x0000, 0xf160, 0xd2eb, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(53982), equals(0x69));
  }, tags: 'undocumented');


  // Test instruction fdcbed
  test('fdcbed', () {
    // Set up machine initial state
    loadRegisters(0xe0bc, 0x70c1, 0xde35, 0x81c5, 0x0000, 0x0000, 0x0000, 0x0000, 0xd57f, 0x0eab, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x58);
    poke(0x0003, 0xed);
    poke(0x0f03, 0x10);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xe0bc, 0x70c1, 0xde35, 0x8130, 0x0000, 0x0000, 0x0000, 0x0000, 0xd57f, 0x0eab, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(3843), equals(0x30));
  }, tags: 'undocumented');


  // Test instruction fdcbee
  test('fdcbee', () {
    // Set up machine initial state
    loadRegisters(0x5fcb, 0x9007, 0x1736, 0xaca8, 0x0000, 0x0000, 0x0000, 0x0000, 0x4bab, 0x42bc, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x02);
    poke(0x0003, 0xee);
    poke(0x42be, 0xd0);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5fcb, 0x9007, 0x1736, 0xaca8, 0x0000, 0x0000, 0x0000, 0x0000, 0x4bab, 0x42bc, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(17086), equals(0xf0));
  });


  // Test instruction fdcbef
  test('fdcbef', () {
    // Set up machine initial state
    loadRegisters(0x4ee3, 0xd344, 0xcb5b, 0xaeb5, 0x0000, 0x0000, 0x0000, 0x0000, 0xde5f, 0x2272, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x58);
    poke(0x0003, 0xef);
    poke(0x22ca, 0x09);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x29e3, 0xd344, 0xcb5b, 0xaeb5, 0x0000, 0x0000, 0x0000, 0x0000, 0xde5f, 0x2272, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(8906), equals(0x29));
  }, tags: 'undocumented');


  // Test instruction fdcbf0
  test('fdcbf0', () {
    // Set up machine initial state
    loadRegisters(0x1080, 0xb270, 0x1b5b, 0xa9b7, 0x0000, 0x0000, 0x0000, 0x0000, 0xe89d, 0xee9e, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x45);
    poke(0x0003, 0xf0);
    poke(0xeee3, 0x2c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1080, 0x6c70, 0x1b5b, 0xa9b7, 0x0000, 0x0000, 0x0000, 0x0000, 0xe89d, 0xee9e, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(61155), equals(0x6c));
  }, tags: 'undocumented');


  // Test instruction fdcbf1
  test('fdcbf1', () {
    // Set up machine initial state
    loadRegisters(0x1702, 0xc43b, 0xd138, 0x316f, 0x0000, 0x0000, 0x0000, 0x0000, 0x8067, 0x4783, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x2f);
    poke(0x0003, 0xf1);
    poke(0x47b2, 0xdc);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1702, 0xc4dc, 0xd138, 0x316f, 0x0000, 0x0000, 0x0000, 0x0000, 0x8067, 0x4783, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbf2
  test('fdcbf2', () {
    // Set up machine initial state
    loadRegisters(0x732a, 0x4cd1, 0x77fe, 0x4814, 0x0000, 0x0000, 0x0000, 0x0000, 0x42f1, 0xea97, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x2c);
    poke(0x0003, 0xf2);
    poke(0xeac3, 0x5e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x732a, 0x4cd1, 0x5efe, 0x4814, 0x0000, 0x0000, 0x0000, 0x0000, 0x42f1, 0xea97, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbf3
  test('fdcbf3', () {
    // Set up machine initial state
    loadRegisters(0x6b97, 0x59d3, 0xf546, 0x7530, 0x0000, 0x0000, 0x0000, 0x0000, 0x6670, 0x7d90, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x38);
    poke(0x0003, 0xf3);
    poke(0x7dc8, 0x0c);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6b97, 0x59d3, 0xf54c, 0x7530, 0x0000, 0x0000, 0x0000, 0x0000, 0x6670, 0x7d90, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(32200), equals(0x4c));
  }, tags: 'undocumented');


  // Test instruction fdcbf4
  test('fdcbf4', () {
    // Set up machine initial state
    loadRegisters(0x7af0, 0xa81f, 0x5d3a, 0x799b, 0x0000, 0x0000, 0x0000, 0x0000, 0xe12b, 0x309c, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xd0);
    poke(0x0003, 0xf4);
    poke(0x306c, 0x0e);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7af0, 0xa81f, 0x5d3a, 0x4e9b, 0x0000, 0x0000, 0x0000, 0x0000, 0xe12b, 0x309c, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(12396), equals(0x4e));
  }, tags: 'undocumented');


  // Test instruction fdcbf5
  test('fdcbf5', () {
    // Set up machine initial state
    loadRegisters(0x1370, 0xf6b2, 0xaaa2, 0x7f0a, 0x0000, 0x0000, 0x0000, 0x0000, 0xc9f6, 0x6b1f, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x55);
    poke(0x0003, 0xf5);
    poke(0x6b74, 0xf8);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1370, 0xf6b2, 0xaaa2, 0x7ff8, 0x0000, 0x0000, 0x0000, 0x0000, 0xc9f6, 0x6b1f, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbf6
  test('fdcbf6', () {
    // Set up machine initial state
    loadRegisters(0x7c43, 0xfcd1, 0x34bd, 0xf4ab, 0x0000, 0x0000, 0x0000, 0x0000, 0xef33, 0xc61a, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x56);
    poke(0x0003, 0xf6);
    poke(0xc670, 0x5d);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x7c43, 0xfcd1, 0x34bd, 0xf4ab, 0x0000, 0x0000, 0x0000, 0x0000, 0xef33, 0xc61a, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  });


  // Test instruction fdcbf7
  test('fdcbf7', () {
    // Set up machine initial state
    loadRegisters(0xe6da, 0x231a, 0x7bb1, 0x800d, 0x0000, 0x0000, 0x0000, 0x0000, 0xe37e, 0x5789, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x9e);
    poke(0x0003, 0xf7);
    poke(0x5727, 0x66);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x66da, 0x231a, 0x7bb1, 0x800d, 0x0000, 0x0000, 0x0000, 0x0000, 0xe37e, 0x5789, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbf8
  test('fdcbf8', () {
    // Set up machine initial state
    loadRegisters(0xfa29, 0xee74, 0xd7c4, 0xafaf, 0x0000, 0x0000, 0x0000, 0x0000, 0x512c, 0xde7a, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x54);
    poke(0x0003, 0xf8);
    poke(0xdece, 0x7a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xfa29, 0xfa74, 0xd7c4, 0xafaf, 0x0000, 0x0000, 0x0000, 0x0000, 0x512c, 0xde7a, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(57038), equals(0xfa));
  }, tags: 'undocumented');


  // Test instruction fdcbf9
  test('fdcbf9', () {
    // Set up machine initial state
    loadRegisters(0x4662, 0xa71b, 0x5065, 0xed06, 0x0000, 0x0000, 0x0000, 0x0000, 0x279e, 0x99e3, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x30);
    poke(0x0003, 0xf9);
    poke(0x9a13, 0xc6);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4662, 0xa7c6, 0x5065, 0xed06, 0x0000, 0x0000, 0x0000, 0x0000, 0x279e, 0x99e3, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbfa
  test('fdcbfa', () {
    // Set up machine initial state
    loadRegisters(0x9426, 0x53ec, 0x5016, 0x6c99, 0x0000, 0x0000, 0x0000, 0x0000, 0x8b99, 0xbd79, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x09);
    poke(0x0003, 0xfa);
    poke(0xbd82, 0xf4);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9426, 0x53ec, 0xf416, 0x6c99, 0x0000, 0x0000, 0x0000, 0x0000, 0x8b99, 0xbd79, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbfb
  test('fdcbfb', () {
    // Set up machine initial state
    loadRegisters(0x5343, 0xb212, 0x09ca, 0xe3c6, 0x0000, 0x0000, 0x0000, 0x0000, 0xcd2b, 0xf875, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xba);
    poke(0x0003, 0xfb);
    poke(0xf82f, 0xed);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x5343, 0xb212, 0x09ed, 0xe3c6, 0x0000, 0x0000, 0x0000, 0x0000, 0xcd2b, 0xf875, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fdcbfc
  test('fdcbfc', () {
    // Set up machine initial state
    loadRegisters(0x0965, 0x4392, 0xca25, 0x2baa, 0x0000, 0x0000, 0x0000, 0x0000, 0xf023, 0x6623, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x56);
    poke(0x0003, 0xfc);
    poke(0x6679, 0x65);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0965, 0x4392, 0xca25, 0xe5aa, 0x0000, 0x0000, 0x0000, 0x0000, 0xf023, 0x6623, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(26233), equals(0xe5));
  }, tags: 'undocumented');


  // Test instruction fdcbfd
  test('fdcbfd', () {
    // Set up machine initial state
    loadRegisters(0x1751, 0x233c, 0x6214, 0xd119, 0x0000, 0x0000, 0x0000, 0x0000, 0xc415, 0x5d2b, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x25);
    poke(0x0003, 0xfd);
    poke(0x5d50, 0x27);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x1751, 0x233c, 0x6214, 0xd1a7, 0x0000, 0x0000, 0x0000, 0x0000, 0xc415, 0x5d2b, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(23888), equals(0xa7));
  }, tags: 'undocumented');


  // Test instruction fdcbfe
  test('fdcbfe', () {
    // Set up machine initial state
    loadRegisters(0xb4cf, 0x5639, 0x677b, 0x0ca2, 0x0000, 0x0000, 0x0000, 0x0000, 0xddc5, 0x4e4f, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0x88);
    poke(0x0003, 0xfe);
    poke(0x4dd7, 0x4a);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xb4cf, 0x5639, 0x677b, 0x0ca2, 0x0000, 0x0000, 0x0000, 0x0000, 0xddc5, 0x4e4f, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(19927), equals(0xca));
  });


  // Test instruction fdcbff
  test('fdcbff', () {
    // Set up machine initial state
    loadRegisters(0xf151, 0x13da, 0x7c56, 0xf025, 0x0000, 0x0000, 0x0000, 0x0000, 0x2b36, 0x2aed, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xcb);
    poke(0x0002, 0xe4);
    poke(0x0003, 0xff);
    poke(0x2ad1, 0x97);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x9751, 0x13da, 0x7c56, 0xf025, 0x0000, 0x0000, 0x0000, 0x0000, 0x2b36, 0x2aed, 0x0000, 0x0004);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
  }, tags: 'undocumented');


  // Test instruction fde1
  test('fde1', () {
    // Set up machine initial state
    loadRegisters(0x828e, 0x078b, 0x1e35, 0x8f1c, 0x0000, 0x0000, 0x0000, 0x0000, 0x4827, 0xb742, 0x716e, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xe1);
    poke(0x716e, 0xd5);
    poke(0x716f, 0x92);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x828e, 0x078b, 0x1e35, 0x8f1c, 0x0000, 0x0000, 0x0000, 0x0000, 0x4827, 0x92d5, 0x7170, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 14);
  });


  // Test instruction fde3
  test('fde3', () {
    // Set up machine initial state
    loadRegisters(0x4298, 0xc805, 0x6030, 0x4292, 0x0000, 0x0000, 0x0000, 0x0000, 0x473b, 0x9510, 0x1a38, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xe3);
    poke(0x1a38, 0xe0);
    poke(0x1a39, 0x0f);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x4298, 0xc805, 0x6030, 0x4292, 0x0000, 0x0000, 0x0000, 0x0000, 0x473b, 0x0fe0, 0x1a38, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 23);
    expect(peek(6712), equals(0x10));
    expect(peek(6713), equals(0x95));
  });


  // Test instruction fde5
  test('fde5', () {
    // Set up machine initial state
    loadRegisters(0xd139, 0xaa0d, 0xbf2b, 0x2a56, 0x0000, 0x0000, 0x0000, 0x0000, 0xe138, 0xd4da, 0xa8e1, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xe5);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xd139, 0xaa0d, 0xbf2b, 0x2a56, 0x0000, 0x0000, 0x0000, 0x0000, 0xe138, 0xd4da, 0xa8df, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 15);
    expect(peek(43231), equals(0xda));
    expect(peek(43232), equals(0xd4));
  });


  // Test instruction fde9
  test('fde9', () {
    // Set up machine initial state
    loadRegisters(0xc14f, 0x2eb6, 0xedf0, 0x27cf, 0x0000, 0x0000, 0x0000, 0x0000, 0x09ee, 0xa2a4, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xe9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc14f, 0x2eb6, 0xedf0, 0x27cf, 0x0000, 0x0000, 0x0000, 0x0000, 0x09ee, 0xa2a4, 0x0000, 0xa2a4);
    checkSpecialRegisters(0x00, 0x02, false, false, 8);
  });


  // Test instruction fdf9
  test('fdf9', () {
    // Set up machine initial state
    loadRegisters(0xc260, 0x992e, 0xd544, 0x67fb, 0x0000, 0x0000, 0x0000, 0x0000, 0xba5e, 0x3596, 0x353f, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfd);
    poke(0x0001, 0xf9);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0xc260, 0x992e, 0xd544, 0x67fb, 0x0000, 0x0000, 0x0000, 0x0000, 0xba5e, 0x3596, 0x3596, 0x0002);
    checkSpecialRegisters(0x00, 0x02, false, false, 10);
  });


  // Test instruction fe
  test('fe', () {
    // Set up machine initial state
    loadRegisters(0x6900, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x0000, 0xfe);
    poke(0x0001, 0x82);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x6987, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0002);
    checkSpecialRegisters(0x00, 0x01, false, false, 7);
  });


  // Test instruction ff
  test('ff', () {
    // Set up machine initial state
    loadRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5507, 0x6d33);
    z80.i = 0x00;
    z80.r = 0x00;
    z80.iff1 = false;
    z80.iff2 = false;
    poke(0x6d33, 0xff);

    // Execute machine for tState cycles
    while(z80.tStates < 1) {
      z80.executeNextInstruction();
    }

    // Test machine state is as expected
    checkRegisters(0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x5505, 0x0038);
    checkSpecialRegisters(0x00, 0x01, false, false, 11);
    expect(peek(21765), equals(0x34));
    expect(peek(21766), equals(0x6d));
  });

}
  