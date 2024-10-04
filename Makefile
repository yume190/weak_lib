# dynamic
libFoo.dylib: lib.c
	clang -shared -o libFoo.dylib lib.c

app: app.c libFoo.dylib
	clang libFoo.dylib -o app app.c

run: app
	./app

# weak dynamic
appWeak: app.c libFoo.dylib
	clang -weak_library libFoo.dylib -o appWeak app.c

runWeak: appWeak
	./appWeak

inspect: appWeak
	otool -L appWeak

# static
libFoo.a: lib.c
	clang -fPIC -c lib.c -o lib.oo
	ar rcs libFoo.a lib.oo

appStatic: libFoo.a
	clang -weak_library libFoo.a -o appStatic app.c

inspectS: appStatic
	otool -L appStatic

clean:
	-rm app appStatic appWeak lib.oo libFoo.a libFoo.dylib