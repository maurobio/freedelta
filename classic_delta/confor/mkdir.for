      module clib
      use iso_c_binding 
      interface
!       function mkdir(path,mode) bind(c,name="mkdir")
!        use iso_c_binding
!        integer(c_int) :: mkdir
!        character(kind=c_char,len=1) :: path(*)
!        integer(c_int16_t), value :: mode
!       end function mkdir
C USAGE: i = mkdir('foo', int(o'772',c_int16_t))	  
       function mkdir(path) bind(c,name='mkdir')
        use iso_c_binding
        integer(c_int) :: mkdir
        character(kind=c_char,len=1) :: path(*)
       end function mkdir
C USAGE: i = mkdir('foo')
      end interface
      end module clib	  
