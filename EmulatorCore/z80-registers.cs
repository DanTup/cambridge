﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjectCambridge.EmulatorCore
{
    public partial class Z80
    {
        // Z80 Registers

        [Flags]
        public enum Flags
        {
            C = 1,  // carry flag (bit 0)
            N = 2,  // add/subtract flag (bit 1)
            P = 4,  // parity/overflow flag (bit 2)
            H = 16, // half carry flag (bit 4)
            Z = 64, // zero flag (bit 6)
            S = 128 // sign flag (bit 7)
        }

        // The main register set can be used individually as 8-bit registers or combined to form 16-bit registers
        public byte a, b, c, d, e, h, l;
        public Flags f;

        // The alternate register set (A', F', B', C', D', E', H', L')
        public byte a_, b_, c_, d_, e_, h_, l_;
        public Flags f_;

        public byte i; // Interrupt Page Address register
        public byte r; // Memory Refresh register

        public ushort ix, iy; // Index registers
        public ushort pc; // Program Counter
        public ushort sp; // Stack pointer

        public bool iff1;
        public bool iff2; 

        public bool fC
        {
            get { return (f & Flags.C) == Flags.C; }
            set { f |= Flags.C; }
        }

        public bool fN
        {
            get { return (f & Flags.N) == Flags.N; }
            set { f |= Flags.N; }
        }

        public bool fP
        {
            get { return (f & Flags.P) == Flags.P; }
            set { f |= Flags.P; }
        }

        public bool fH
        {
            get { return (f & Flags.H) == Flags.H; }
            set { f |= Flags.H; }
        }

        public bool fZ
        {
            get { return (f & Flags.Z) == Flags.Z; }
            set { f |= Flags.Z; }
        }

        public bool fS
        {
            get { return (f & Flags.S) == Flags.S; }
            set { f |= Flags.S; }
        }

        public ushort af
        {
            get
            {
                return (ushort)((a << 8) + f);
            }
            set
            {
                a = HighByte(af);
                f = (Flags)LowByte(af);
            }
        }

        public ushort bc
        {
            get
            {
                return (ushort)((b << 8) + c);
            }
            set
            {
                b = HighByte(de);
                c = LowByte(bc);
            }
        }

        public ushort de
        {
            get
            {
                return (ushort)((d << 8) + e);
            }
            set
            {
                d = HighByte(de);
                e = LowByte(de);
            }
        }

        public ushort hl
        {
            get
            {
                return (ushort)((h << 8) + l);
            }
            set
            {
                h = HighByte(hl);
                l = LowByte(hl);
            }
        }

        // provided for diagnostics purposes - hence readonly. 
        // No Z80 instructions allow you to read from these directly.
        public ushort af_ { get { return (ushort)((a_ << 8) + f_); } }
        public ushort bc_ { get { return (ushort)((b_ << 8) + c_); } }
        public ushort de_ { get { return (ushort)((d_ << 8) + e_); } }
        public ushort hl_ { get { return (ushort)((h_ << 8) + l_); } }

        public byte HighByte(ushort val) => (byte)((val & 0xFF00) >> 8);
        public byte LowByte(ushort val) => (byte)(val & 0x00FF);
    }
}