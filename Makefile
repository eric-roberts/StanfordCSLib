# Makefile for StanfordCSLib directory
# Last modified on Fri Jan  6 11:58:27 2017 by eroberts
#****************************************************************

SCRIPTS = \
    bin/gccx

TESTS = \
    cstest

OBJECTS = \
    obj/bst.o \
    obj/charset.o \
    obj/cmpfn.o \
    obj/cslib.o \
    obj/exception.o \
    obj/filelib.o \
    obj/foreach.o \
    obj/generic.o \
    obj/gevents.o \
    obj/gobjects.o \
    obj/gmath.o \
    obj/graph.o \
    obj/gtimer.o \
    obj/gtransform.o \
    obj/gtypes.o \
    obj/gwindow.o \
    obj/hashmap.o \
    obj/iterator.o \
    obj/loadobj.o \
    obj/map.o \
    obj/shellargs.o \
    obj/posixthread.o \
    obj/platform.o \
    obj/pqueue.o \
    obj/queue.o \
    obj/random.o \
    obj/ref.o \
    obj/set.o \
    obj/simpio.o \
    obj/sound.o \
    obj/stack.o \
    obj/strbuf.o \
    obj/strlib.o \
    obj/thread.o \
    obj/tokenscanner.o \
    obj/unittest.o \
    obj/unixfile.o \
    obj/vector.o

HEADERS = \
    bst.h \
    charset.h \
    cmdscan.h \
    cmpfn.h \
    cslib.h \
    exception.h \
    filelib.h \
    foreach.h \
    gcdebug.h \
    gevents.h \
    gmath.h \
    gobjects.h \
    graph.h \
    gtimer.h \
    gtransform.h \
    gtypes.h \
    gwindow.h \
    hashmap.h \
    iterator.h \
    itertype.h \
    list.h \
    loadobj.h \
    map.h \
    shellargs.h \
    platform.h \
    pqueue.h \
    queue.h \
    random.h \
    ref.h \
    set.h \
    simpio.h \
    sound.h \
    stack.h \
    strbuf.h \
    strlib.h \
    thread.h \
    tokenscanner.h \
    unittest.h \
    vector.h

LIBRARIES = lib/libcs.a


# ***************************************************************
# Entry to bring the package up to date
#    The "make all" entry should be the first real entry
#    The / separators are for parallel versions of make

all: directories / $(OBJECTS) / $(LIBRARIES) / $(TESTS)

directories: always
	@-(if ! test -d obj ; then mkdir obj ; fi)
	@-(if ! test -d lib ; then mkdir lib ; fi)

install: all
	@-(if test -w /usr/local/bin ; then \
             target=/usr/local/bin ; \
           else \
             target=$(HOME)/bin ; \
           fi ; \
           if ! test -d $$target ; then mkdir $$target ; fi ; \
           for x in $(PROGRAMS) $(SCRIPTS) ; do \
             echo link `pwd`/$$x $$target ; \
             rm -f $$target/$$x ; \
             ln -s `pwd`/$$x $$target ; \
           done)
	@-(if test -w /usr/local/lib ; then \
             target=/usr/local/lib ; \
           else \
             target=$(HOME)/lib ; \
           fi ; \
           if ! test -d $$target ; then mkdir $$target ; fi ; \
           for x in $(LIBRARIES) ; do \
             echo link `pwd`/$$x $$target ; \
             rm -f $$target/$$x ; \
             ln -s `pwd`/$$x $$target ; \
           done)
	@-(if test -w /usr/local/include ; then \
             target=/usr/local/include ; \
           else \
             target=$(HOME)/include ; \
           fi ; \
           if ! test -d $$target ; then mkdir $$target ; fi ; \
           for x in $(HEADERS) private ; do \
             echo link `pwd`/include/$$x $$target ; \
             rm -f $$target/$$x ; \
             ln -s `pwd`/include/$$x $$target ; \
           done)


# ***************************************************************
# Standard entries to remove files from the directories
#    tidy    -- eliminate unwanted files
#    scratch -- delete derived files in preparation for rebuild

tidy:
	rm -f ,* .,* *~ src/*~ include/*~ doc/*~ bin/~* core obj/a.out *.err

scratch clean: tidy
	rm -rf obj; mkdir obj
	rm -rf lib; mkdir lib
	rm -f $(TESTS)


# ***************************************************************
# Tools

obj/cstest.o: src/cstest.c include/cslib.h include/exception.h \
              include/strlib.h include/unittest.h
	gccx -c -o obj/cstest.o -Iinclude src/cstest.c

cstest: obj/cstest.o lib/libcs.a
	gccx -o cstest -Llib obj/cstest.o


# ***************************************************************
# Library compilations

obj/bst.o: src/bst.c include/bst.h include/cmpfn.h include/cslib.h \
           include/exception.h include/foreach.h include/iterator.h \
           include/itertype.h include/strlib.h include/unittest.h
	bin/gccx -c -o obj/bst.o -Iinclude src/bst.c

obj/charset.o: src/charset.c include/cslib.h include/foreach.h \
               include/iterator.h include/itertype.h include/strlib.h \
               include/unittest.h
	bin/gccx -c -o obj/charset.o -Iinclude src/charset.c

obj/cmdscan.o: src/cmdscan.c include/cmdscan.h include/cmpfn.h \
               include/cslib.h include/exception.h include/generic.h \
               include/hashmap.h include/iterator.h include/itertype.h \
               include/simpio.h include/strlib.h include/tokenscanner.h
	bin/gccx -c -o obj/cmdscan.o -Iinclude src/cmdscan.c

obj/cmpfn.o: src/cmpfn.c include/cmpfn.h include/cslib.h \
             include/strlib.h
	bin/gccx -c -o obj/cmpfn.o -Iinclude src/cmpfn.c

obj/cslib.o: src/cslib.c include/cslib.h include/exception.h
	bin/gccx -c -o obj/cslib.o -Iinclude src/cslib.c

obj/exception.o: src/exception.c include/cslib.h include/exception.h \
                 include/strlib.h include/thread.h include/unittest.h
	bin/gccx -c -o obj/exception.o -Iinclude src/exception.c

obj/filelib.o: src/filelib.c include/cslib.h include/cmpfn.h \
               include/exception.h include/filelib.h include/generic.h \
               include/iterator.h include/itertype.h include/strlib.h \
               include/unittest.h
	bin/gccx -c -o obj/filelib.o -Iinclude src/filelib.c

obj/foreach.o: src/foreach.c include/cslib.h include/foreach.h \
               include/iterator.h
	bin/gccx -c -o obj/foreach.o -Iinclude src/foreach.c

obj/generic.o: src/generic.c include/cmpfn.h include/cslib.h \
               include/exception.h include/generic.h include/ref.h \
               include/strlib.h include/unittest.h
	bin/gccx -c -o obj/generic.o -Iinclude src/generic.c

obj/gevents.o: src/gevents.c include/cslib.h include/gevents.h \
               include/gtimer.h include/gtypes.h include/hashmap.h \
               include/platform.h
	bin/gccx -c -o obj/gevents.o -Iinclude src/gevents.c

obj/gmath.o: src/gmath.c include/gmath.h
	bin/gccx -c -o obj/gmath.o -Iinclude src/gmath.c

obj/gobjects.o: src/gobjects.c include/gobjects.h include/platform.h \
                include/vector.h
	bin/gccx -c -o obj/gobjects.o -Iinclude src/gobjects.c

obj/graph.o: src/graph.c include/cmpfn.h include/cslib.h \
             include/foreach.h include/generic.h include/graph.h \
             include/iterator.h include/itertype.h include/set.h
	bin/gccx -c -o obj/graph.o -Iinclude src/graph.c

obj/gtimer.o: src/gtimer.c include/cslib.h
	bin/gccx -c -o obj/gtimer.o -Iinclude src/gtimer.c

obj/gtransform.o: src/gtransform.c include/gmath.h include/gtransform.h \
                  include/gtypes.h
	bin/gccx -c -o obj/gtransform.o -Iinclude src/gtransform.c

obj/gtypes.o: src/gtypes.c include/cslib.h include/generic.h \
              include/gtypes.h
	bin/gccx -c -o obj/gtypes.o -Iinclude src/gtypes.c

obj/gwindow.o: src/gwindow.c include/gobjects.h include/gwindow.h \
               include/platform.h
	bin/gccx -c -o obj/gwindow.o -Iinclude src/gwindow.c

obj/hashmap.o: src/hashmap.c include/cmpfn.h include/cslib.h \
               include/exception.h include/generic.h include/hashmap.h \
               include/iterator.h include/itertype.h include/strlib.h \
               include/unittest.h
	bin/gccx -c -o obj/hashmap.o -Iinclude src/hashmap.c

obj/iterator.o: src/iterator.c include/cmpfn.h include/cslib.h \
                include/iterator.h include/itertype.h
	bin/gccx -c -o obj/iterator.o -Iinclude src/iterator.c

obj/loadobj.o: src/loadobj.c include/cslib.h include/filelib.h \
               include/loadobj.h include/strlib.h
	bin/gccx -c -o obj/loadobj.o -Iinclude src/loadobj.c

obj/map.o: src/map.c include/bst.h include/cmpfn.h include/cslib.h \
           include/exception.h include/foreach.h include/generic.h \
           include/iterator.h include/itertype.h include/map.h \
           include/strlib.h include/unittest.h
	bin/gccx -c -o obj/map.o -Iinclude src/map.c

obj/platform.o: src/platform.c include/cslib.h include/filelib.h \
                include/gtimer.h include/platform.h include/strlib.h
	bin/gccx -c -o obj/platform.o -Iinclude src/platform.c

obj/posixthread.o: src/posixthread.c include/cslib.h include/exception.h \
                   include/strlib.h include/thread.h
	bin/gccx -c -o obj/posixthread.o -Iinclude src/posixthread.c

obj/pqueue.o: src/pqueue.c include/cslib.h include/generic.h \
              include/queue.h include/unittest.h
	bin/gccx -c -o obj/pqueue.o -Iinclude src/pqueue.c

obj/queue.o: src/queue.c include/cslib.h include/generic.h \
             include/queue.h include/unittest.h
	bin/gccx -c -o obj/queue.o -Iinclude src/queue.c

obj/random.o: src/random.c include/cslib.h include/random.h
	bin/gccx -c -o obj/random.o -Iinclude src/random.c

obj/ref.o: src/ref.c include/cslib.h include/ref.h
	bin/gccx -c -o obj/ref.o -Iinclude src/ref.c

obj/set.o: src/set.c include/bst.h include/cmpfn.h include/cslib.h \
           include/generic.h include/iterator.h include/itertype.h \
           include/set.h
	bin/gccx -c -o obj/set.o -Iinclude src/set.c

obj/shellargs.o: src/shellargs.c include/cslib.h include/generic.h \
                 include/hashmap.h include/shellargs.h include/strlib.h \
                 include/unittest.h include/vector.h
	bin/gccx -c -o obj/shellargs.o -Iinclude src/shellargs.c

obj/simpio.o: src/simpio.c include/cslib.h include/simpio.h \
              include/strlib.h
	bin/gccx -c -o obj/simpio.o -Iinclude src/simpio.c

obj/sound.o: src/sound.c include/cslib.h include/platform.h \
             include/sound.h
	bin/gccx -c -o obj/sound.o -Iinclude src/sound.c

obj/stack.o: src/stack.c include/cslib.h include/generic.h \
             include/stack.h include/unittest.h
	bin/gccx -c -o obj/stack.o -Iinclude src/stack.c

obj/strbuf.o: src/strbuf.c include/cslib.h include/exception.h \
              include/strbuf.h include/strlib.h include/unittest.h
	bin/gccx -c -o obj/strbuf.o -Iinclude src/strbuf.c

obj/strlib.o: src/strlib.c include/cslib.h include/exception.h \
              include/strlib.h include/unittest.h
	bin/gccx -c -o obj/strlib.o -Iinclude src/strlib.c

obj/thread.o: src/thread.c include/cslib.h include/exception.h \
              include/thread.h include/unittest.h
	bin/gccx -c -o obj/thread.o -Iinclude src/thread.c

obj/tokenscanner.o: src/tokenscanner.c include/cslib.h include/strlib.h \
                    include/tokenscanner.h
	bin/gccx -c -o obj/tokenscanner.o -Iinclude src/tokenscanner.c

obj/unittest.o: src/unittest.c include/cslib.h include/exception.h \
                include/generic.h include/strlib.h include/unittest.h
	bin/gccx -c -o obj/unittest.o -Iinclude src/unittest.c

obj/unixfile.o: src/unixfile.c include/cslib.h include/filelib.h \
                include/iterator.h include/strlib.h
	bin/gccx -c -o obj/unixfile.o -Iinclude src/unixfile.c

obj/vector.o: src/vector.c include/cmpfn.h include/cslib.h \
              include/generic.h include/iterator.h include/itertype.h \
              include/vector.h
	bin/gccx -c -o obj/vector.o -Iinclude src/vector.c


# ***************************************************************
# Entry to reconstruct the library archive

lib/libcs.a: $(OBJECTS)
	-rm -f lib/libcs.a
	(cd obj ; ar cr ../lib/libcs.a *.o)
	ranlib lib/libcs.a
