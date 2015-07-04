####HxDefines
HxDefines represents all defines in Haxe Compiler
See also: http://haxe.org/manual/lf-condition-compilation-flags.html
This file is generated with the output of `haxe --help-defines`

Variable | Flag | Description
-------- | ---- | -------------
`HxDefines.AbsolutePath` | absolute-path | Print absolute file path in trace output
`HxDefines.AdvancedTelemetry` | advanced-telemetry | Allow the SWF to be measured with Monocle tool
`HxDefines.Analyzer` | analyzer | Use static analyzer for optimization (experimental)
`HxDefines.As3` | as3 | Defined when outputing flash9 as3 source code
`HxDefines.CheckXmlProxy` | check-xml-proxy | Check the used fields of the xml proxy
`HxDefines.CoreApi` | core-api | Defined in the core api context
`HxDefines.CoreApiSerialize` | core-api-serialize | Mark some generated core api classes with the Serializable attribute on C#
`HxDefines.Cppia` | cppia | Generate experimental cpp instruction assembly
`HxDefines.Dce` | dce | <mode:std|full||no> Set the dead code elimination mode (default std)
`HxDefines.DceDebug` | dce-debug | Show DCE log
`HxDefines.Debug` | debug | Activated when compiling with -debug
`HxDefines.Display` | display | Activated during completion
`HxDefines.DllExport` | dll-export | GenCPP experimental linking
`HxDefines.DllImport` | dll-import | GenCPP experimental linking
`HxDefines.DocGen` | doc-gen | Do not perform any removal/change in order to correctly generate documentation
`HxDefines.Dump` | dump | Dump the complete typed AST for internal debugging in a dump subdirectory - use dump=pretty for Haxe-like formatting
`HxDefines.DumpDependencies` | dump-dependencies | Dump the classes dependencies in a dump subdirectory
`HxDefines.DumpIgnoreVarIds` | dump-ignore-var-ids | Remove variable IDs from non-pretty dumps (helps with diff)
`HxDefines.EraseGenerics` | erase-generics | Erase generic classes on C#
`HxDefines.Fdb` | fdb | Enable full flash debug infos for FDB interactive debugging
`HxDefines.FileExtension` | file-extension | Output filename extension for cpp source code
`HxDefines.FlashStrict` | flash-strict | More strict typing for flash target
`HxDefines.FlashUseStage` | flash-use-stage | Keep the SWF library initial stage
`HxDefines.ForceLibCheck` | force-lib-check | Force the compiler to check -net-lib and -java-lib added classes (internal)
`HxDefines.ForceNativeProperty` | force-native-property | Tag all properties with :nativeProperty metadata for 3.1 compatibility
`HxDefines.FormatWarning` | format-warning | Print a warning for each formated string, for 2.x compatibility
`HxDefines.GencommonDebug` | gencommon-debug | GenCommon internal
`HxDefines.HaxeBoot` | haxe-boot | Given the name 'haxe' to the flash boot class instead of a generated name
`HxDefines.HaxeVer` | haxe-ver | The current Haxe version value
`HxDefines.HxcppApiLevel` | hxcpp-api-level | Provided to allow compatibility between hxcpp versions
`HxDefines.IncludePrefix` | include-prefix | prepend path to generated include files
`HxDefines.Interp` | interp | The code is compiled to be run with --interp
`HxDefines.JavaVer` | java-ver | <version:5-7> Sets the Java version to be targeted
`HxDefines.JsClassic` | js-classic | Don't use a function wrapper and strict mode in JS output
`HxDefines.JsEs5` | js-es5 | Generate JS for ES5-compliant runtimes
`HxDefines.JsUnflatten` | js-unflatten | Generate nested objects for packages and types
`HxDefines.KeepOldOutput` | keep-old-output | Keep old source files in the output directory (for C#/Java)
`HxDefines.LoopUnrollMaxCost` | loop-unroll-max-cost | Maximum cost (number of expressions * iterations) before loop unrolling is canceled (default 250)
`HxDefines.Macro` | macro | Defined when code is compiled in the macro context
`HxDefines.MacroTimes` | macro-times | Display per-macro timing when used with --times
`HxDefines.NekoSource` | neko-source | Output neko source instead of bytecode
`HxDefines.NekoV1` | neko-v1 | Keep Neko 1.x compatibility
`HxDefines.NetTarget` | net-target | <name> Sets the .NET target. Defaults to "net". xbox, micro (Micro Framework), compact (Compact Framework) are some valid values
`HxDefines.NetVer` | net-ver | <version:20-45> Sets the .NET version to be targeted
`HxDefines.NetworkSandbox` | network-sandbox | Use local network sandbox instead of local file access one
`HxDefines.NoCompilation` | no-compilation | Disable final compilation for Cs, Cpp and Java
`HxDefines.NoCopt` | no-copt | Disable completion optimization (for debug purposes)
`HxDefines.NoDebug` | no-debug | Remove all debug macros from cpp output
`HxDefines.NoDeprecationWarnings` | no-deprecation-warnings | Do not warn if fields annotated with @:deprecated are used
`HxDefines.NoFlashOverride` | no-flash-override | Change overrides on some basic classes into HX suffixed methods, flash only
`HxDefines.NoInline` | no-inline | Disable inlining
`HxDefines.NoMacroCache` | no-macro-cache | Disable macro context caching
`HxDefines.NoOpt` | no-opt | Disable optimizations
`HxDefines.NoPatternMatching` | no-pattern-matching | Disable pattern matching
`HxDefines.NoRoot` | no-root | Generate top-level types into haxe.root namespace
`HxDefines.NoSimplify` | no-simplify | Disable simplification filter
`HxDefines.NoSwfCompress` | no-swf-compress | Disable SWF output compression
`HxDefines.NoTraces` | no-traces | Disable all trace calls
`HxDefines.Objc` | objc | Sets the hxcpp output to objective-c++ classes. Must be defined for interop
`HxDefines.PhpPrefix` | php-prefix | Compiled with --php-prefix
`HxDefines.RealPosition` | real-position | Disables haxe source mapping when targetting C#
`HxDefines.ReplaceFiles` | replace-files | GenCommon internal
`HxDefines.Scriptable` | scriptable | GenCPP internal
`HxDefines.ShallowExpose` | shallow-expose | Expose types to surrounding scope of Haxe generated closure without writing to window object
`HxDefines.SourceHeader` | source-header | Print value as comment on top of generated files, use '' value to disable
`HxDefines.SourceMapContent` | source-map-content | Include the hx sources as part of the JS source map
`HxDefines.Swc` | swc | Output a SWC instead of a SWF
`HxDefines.SwfCompressLevel` | swf-compress-level | <level:1-9> Set the amount of compression for the SWF output
`HxDefines.SwfDebugPassword` | swf-debug-password | Set a password for debugging
`HxDefines.SwfDirectBlit` | swf-direct-blit | Use hardware acceleration to blit graphics
`HxDefines.SwfGpu` | swf-gpu | Use GPU compositing features when drawing graphics
`HxDefines.SwfMetadata` | swf-metadata | <file> Include contents of <file> as metadata in the swf
`HxDefines.SwfPreloaderFrame` | swf-preloader-frame | Insert empty first frame in swf
`HxDefines.SwfProtected` | swf-protected | Compile Haxe private as protected in the SWF instead of public
`HxDefines.SwfScriptTimeout` | swf-script-timeout | Maximum ActionScript processing time before script stuck dialog box displays (in seconds)
`HxDefines.SwfUseDoabc` | swf-use-doabc | Use DoAbc swf-tag instead of DoAbcDefine
`HxDefines.Sys` | sys | Defined for all system platforms
`HxDefines.Unsafe` | unsafe | Allow unsafe code when targeting C#
`HxDefines.UseNekoc` | use-nekoc | Use nekoc compiler instead of internal one
`HxDefines.UseRttiDoc` | use-rtti-doc | Allows access to documentation during compilation
`HxDefines.Vcproj` | vcproj | GenCPP internal


