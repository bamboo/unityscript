# UnityScript #

A JavaScript implementation based on the Boo programming language.

## Building ##

Checkout boo side-by-side with unityscript. 

Build boo:

	pushd ../boo
	nant
	popd

Build unityscript (and run the tests):

	nant test
	
If the build script can't automatically detect the location of nunit.framework.dll
create a build.properties file in the boo directory with something like:

```xml
<project name="build properties">
    <property name="nunit.framework.dll" value="/usr/lib/cli/nunit.framework-2.4/nunit.framework.dll" />
</project>
```

With *nunit.framework.dll* pointing to the location of nunit.framework.dll in your system.





