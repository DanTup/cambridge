﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace testclient
{
    public partial class Z80
    {
        // Z80 Registers
        // 
        // Details of the Z80 architecture are here http://landley.net/history/mirror/cpm/z80.html
        // And also here: http://z80.info/z80code.htm

        [Flags]
        private enum Flags
        {
            C = 1,  // carry flag (bit 0)
            N = 2,  // add/subtract flag (bit 1)
            P = 4,  // parity/overflow flag (bit 2)
            H = 16, // half carry flag (bit 4)
            Z = 64, // zero flag (bit 6)
            S = 128 // sign flag (bit 7)
        }

        // The main Z80 registers are 8-bit, but can be combined internally to form 16-bit registers. 
        private byte a, b, c, d, e, h, l;
        private Flags f;
        private byte i; // Interrupt Page address register
        private byte r; // Memory Refresh register

        private ushort ix, iy; // index registers
        private ushort pc; // Program Counter register
        private ushort sp; // Stack Pointer register
        private ushort af_, bc_, de_, hl_; // alternate registers (AF", BC', DE', HL')

        private bool fC
        {
            get { return (f & Flags.C) == Flags.C; }
            set { f |= Flags.C; }
        }

        private bool fN
        {
            get { return (f & Flags.N) == Flags.N; }
            set { f |= Flags.N; }
        }

        private bool fP
        {
            get { return (f & Flags.P) == Flags.P; }
            set { f |= Flags.P; }
        }

        private bool fH
        {
            get { return (f & Flags.H) == Flags.H; }
            set { f |= Flags.H; }
        }

        private bool fZ
        {
            get { return (f & Flags.Z) == Flags.Z; }
            set { f |= Flags.Z; }
        }

        private bool fS
        {
            get { return (f & Flags.S) == Flags.S; }
            set { f |= Flags.S; }
        }

        private ushort af
        {
            get
            {
                return (ushort)((a << 8) + f);
            }
            set
            {
                a = (byte)((value & 0xFF00) >> 8);
                f = (Flags)(value & 0x00FF);
            }
        }

        private ushort bc
        {
            get
            {
                return (ushort)((b << 8) + c);
            }
            set
            {
                b = (byte)((value & 0xFF00) >> 8);
                c = (byte)(value & 0x00FF);
            }
        }

        private ushort de
        {
            get
            {
                return (ushort)((d << 8) + e);
            }
            set
            {
                d = (byte)((value & 0xFF00) >> 8);
                e = (byte)(value & 0x00FF);
            }
        }

        private ushort hl
        {
            get
            {
                return (ushort)((h << 8) + l);
            }
            set
            {
                h = (byte)((value & 0xFF00) >> 8);
                l = (byte)(value & 0x00FF);
            }
        }
    }
}
