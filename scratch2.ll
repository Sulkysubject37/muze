; ModuleID = 'BitcodeBuffer'
source_filename = "scratch2"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "aarch64-apple-macosx26.5.2-unknown"

%macho.mach_header_64 = type { i32, i32, i32, i32, i32, i32, i32, i32 }
%mem.Allocator.VTable = type { ptr, ptr, ptr, ptr }
%Io.Writer.VTable = type { ptr, ptr, ptr, ptr }
%Io.Threaded = type { %Io.File.Writer, %SinglyLinkedList, %Io.Threaded.Csprng, i64, %Io.Threaded.WaitGroup, i64, i64, i64, %"atomic.Value(?*Io.Threaded.Thread)", %Io.Threaded.Environ, %c.Sigaction__struct_2086, %c.Sigaction__struct_2086, i64, i64, %mem.Allocator, %Io.Mutex, %Io.Condition, %Io.Threaded.NullFile__struct_2144, %Io.Mutex, i16, i1, i1, i2, i1, i1, i1, i1, i1, [2 x i8] }
%Io.File.Writer = type { %Io, i64, %Io.Writer, %Io.File, i16, i16, i16, i3, [1 x i8] }
%Io = type { ptr, ptr }
%Io.Writer = type { ptr, { ptr, i64 }, i64 }
%Io.File = type { i32, %Io.File.Flags, [3 x i8] }
%Io.File.Flags = type { i1 }
%SinglyLinkedList = type { ptr }
%Io.Threaded.Csprng = type { %Random.ChaCha }
%Random.ChaCha = type { i64, [512 x i8] }
%Io.Threaded.WaitGroup = type { %"atomic.Value(usize)", i32, [4 x i8] }
%"atomic.Value(usize)" = type { i64 }
%"atomic.Value(?*Io.Threaded.Thread)" = type { ptr }
%Io.Threaded.Environ = type { %process.Environ, %Io.Threaded.Environ.String__struct_2268, { %Io.File, i16, [2 x i8] }, i16, %Io.Threaded.Environ.Exist }
%process.Environ = type { %process.Environ.PosixBlock }
%process.Environ.PosixBlock = type { { ptr, i64 } }
%Io.Threaded.Environ.String__struct_2268 = type { { ptr, i64 }, { ptr, i64 }, { ptr, i64 }, { ptr, i64 } }
%Io.Threaded.Environ.Exist = type { i1, i1 }
%c.Sigaction__struct_2086 = type { %c.Sigaction__struct_2086__union_2196, i32, i32 }
%c.Sigaction__struct_2086__union_2196 = type { ptr }
%mem.Allocator = type { ptr, ptr }
%Io.Condition = type { %"atomic.Value(Io.Condition.State)", %"atomic.Value(u32)" }
%"atomic.Value(Io.Condition.State)" = type { i32 }
%"atomic.Value(u32)" = type { i32 }
%Io.Threaded.NullFile__struct_2144 = type { i32 }
%Io.Mutex = type { %"atomic.Value(Io.Mutex.State)" }
%"atomic.Value(Io.Mutex.State)" = type { i32 }
%c.stack_t__struct_2430 = type { ptr, i64, i32, [4 x i8] }
%Io.Operation.Result__union_3184 = type { { i16, [6 x i8], i64 }, i2, [7 x i8] }
%Io.Operation = type { <{ %Io.Operation.NetReceive, [8 x i8] }>, i2, [7 x i8] }
%Io.Operation.NetReceive = type { { ptr, i64 }, { ptr, i64 }, i32, i8, [3 x i8] }

@Thread.maybeAttachSignalStack.global.signal_stack = internal thread_local unnamed_addr global [262144 x i8] undef, align 1, !dbg !0
@c.dummy_execute_header = internal unnamed_addr global %macho.mach_header_64 undef, align 4, !dbg !1849
@__anon_2967 = internal unnamed_addr constant [1 x { ptr, i64 }] [{ ptr, i64 } { ptr @__anon_2962, i64 0 }], align 8
@__anon_2962 = internal unnamed_addr constant [1 x i8] zeroinitializer, align 1
@__anon_3942 = internal unnamed_addr constant { i64, i16, [6 x i8] } { i64 undef, i16 18, [6 x i8] undef }, align 8
@__anon_3950 = internal unnamed_addr constant { i64, i16, [6 x i8] } { i64 undef, i16 28, [6 x i8] undef }, align 8
@__anon_3966 = internal unnamed_addr constant { i64, i16, [6 x i8] } { i64 undef, i16 20, [6 x i8] undef }, align 8
@__anon_3968 = internal unnamed_addr constant { i64, i16, [6 x i8] } { i64 undef, i16 21, [6 x i8] undef }, align 8
@__anon_3998 = internal unnamed_addr constant %mem.Allocator.VTable { ptr @mem.Allocator.noAlloc, ptr @mem.Allocator.unreachableResize, ptr @mem.Allocator.unreachableRemap, ptr @mem.Allocator.unreachableFree }, align 8
@__anon_4016 = internal unnamed_addr constant [1 x ptr] zeroinitializer, align 8
@__anon_2877 = internal unnamed_addr constant %Io.Writer.VTable { ptr @Io.File.Writer.drain, ptr @Io.File.Writer.sendFile, ptr @Io.Writer.defaultFlush, ptr @Io.Writer.defaultRebase }, align 8
@Io.Threaded.global_single_threaded_instance = internal unnamed_addr global %Io.Threaded { %Io.File.Writer { %Io undef, i64 0, %Io.Writer { ptr @__anon_2877, { ptr, i64 } { ptr inttoptr (i64 1 to ptr), i64 0 }, i64 0 }, %Io.File { i32 2, %Io.File.Flags zeroinitializer, [3 x i8] undef }, i16 0, i16 0, i16 0, i3 0, [1 x i8] undef }, %SinglyLinkedList zeroinitializer, %Io.Threaded.Csprng { %Random.ChaCha { i64 -1, [512 x i8] undef } }, i64 16777216, %Io.Threaded.WaitGroup { %"atomic.Value(usize)" zeroinitializer, i32 0, [4 x i8] undef }, i64 0, i64 0, i64 0, %"atomic.Value(?*Io.Threaded.Thread)" zeroinitializer, %Io.Threaded.Environ { %process.Environ { %process.Environ.PosixBlock { { ptr, i64 } { ptr @__anon_4016, i64 0 } } }, %Io.Threaded.Environ.String__struct_2268 zeroinitializer, { %Io.File, i16, [2 x i8] } { %Io.File undef, i16 24, [2 x i8] undef }, i16 0, %Io.Threaded.Environ.Exist zeroinitializer }, %c.Sigaction__struct_2086 undef, %c.Sigaction__struct_2086 undef, i64 0, i64 -1, %mem.Allocator { ptr undef, ptr @__anon_3998 }, %Io.Mutex zeroinitializer, %Io.Condition zeroinitializer, %Io.Threaded.NullFile__struct_2144 { i32 -1 }, %Io.Mutex zeroinitializer, i16 0, i1 false, i1 false, i2 0, i1 false, i1 false, i1 true, i1 false, i1 false, [2 x i8] undef }, align 8, !dbg !1893

@main = alias i32 (i32, ptr, ptr), ptr @start.main
@_mh_execute_header = weak_odr alias %macho.mach_header_64, ptr @c.dummy_execute_header

; Function Attrs: nounwind uwtable
define internal noundef i32 @start.main(i32 %0, ptr nonnull readnone align 8 captures(none) %1, ptr nonnull align 8 %2) unnamed_addr #0 align 4 !dbg !1905 {
Entry:
  %3 = alloca %c.stack_t__struct_2430, align 8
    #dbg_value(i32 %0, !1913, !DIExpression(), !1914)
    #dbg_value(ptr poison, !1915, !DIExpression(), !1914)
    #dbg_value(ptr %2, !1916, !DIExpression(), !1914)
    #dbg_value(i64 0, !1917, !DIExpression(), !1918)
  br label %Loop, !dbg !1919

Loop:                                             ; preds = %Loop, %Entry
  %.0 = phi i64 [ 0, %Entry ], [ %6, %Loop ], !dbg !1918
    #dbg_value(i64 %.0, !1917, !DIExpression(), !1918)
  %4 = shl i64 %.0, 3, !dbg !1921
  %scevgep = getelementptr i8, ptr %2, i64 %4, !dbg !1921
  %5 = load ptr, ptr %scevgep, align 8, !dbg !1921
  %.not = icmp eq ptr %5, null, !dbg !1921
  %6 = add i64 %.0, 1, !dbg !1924
    #dbg_value(i64 %6, !1917, !DIExpression(), !1918)
  br i1 %.not, label %Else, label %Loop, !dbg !1921

Else:                                             ; preds = %Loop
    #dbg_value({ ptr, i64 } poison, !1927, !DIExpression(), !1932)
    #dbg_value(i32 %0, !1933, !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value), !1936)
    #dbg_value(ptr poison, !1938, !DIExpression(), !1936)
    #dbg_value({ ptr, i64 } poison, !1941, !DIExpression(), !1936)
    #dbg_value(ptr %2, !1948, !DIExpression(DW_OP_LLVM_fragment, 0, 64), !1949)
    #dbg_value(i64 %.0, !1948, !DIExpression(DW_OP_LLVM_fragment, 64, 64), !1949)
    #dbg_value(ptr @Io.Threaded.global_single_threaded_instance, !1950, !DIExpression(), !1952)
  store ptr %2, ptr getelementptr inbounds nuw (i8, ptr @Io.Threaded.global_single_threaded_instance, i64 656), align 8, !dbg !1953
  %7 = add i64 %6, -1, !dbg !1953
  store i64 %7, ptr getelementptr inbounds nuw (i8, ptr @Io.Threaded.global_single_threaded_instance, i64 664), align 8, !dbg !1953
  call void @llvm.lifetime.start.p0(i64 24, ptr nonnull %3), !dbg !1954
    #dbg_value(i64 262144, !1959, !DIExpression(), !1960)
  store ptr @Thread.maybeAttachSignalStack.global.signal_stack, ptr %3, align 8, !dbg !1954
  %8 = getelementptr inbounds nuw i8, ptr %3, i64 8, !dbg !1954
  store i64 262144, ptr %8, align 8, !dbg !1954
  %9 = getelementptr inbounds nuw i8, ptr %3, i64 16, !dbg !1954
  store i32 0, ptr %9, align 8, !dbg !1954
    #dbg_value(ptr %3, !1961, !DIExpression(), !1980)
    #dbg_value(ptr null, !1982, !DIExpression(), !1980)
  %10 = call i32 @sigaltstack(ptr nonnull readonly align 8 %3, ptr align 8 null), !dbg !1983
    #dbg_value(i32 %10, !1984, !DIExpression(), !1988)
  %11 = icmp eq i32 %10, -1, !dbg !1991
  br i1 %11, label %c.errno__anon_2649.exit.i.i, label %Thread.maybeAttachSignalStack.exit, !dbg !1991

c.errno__anon_2649.exit.i.i:                      ; preds = %Else
  %12 = call ptr @__error(), !dbg !1993
  br label %Thread.maybeAttachSignalStack.exit, !dbg !1996

Thread.maybeAttachSignalStack.exit:               ; preds = %Else, %c.errno__anon_2649.exit.i.i
  call void @llvm.lifetime.end.p0(i64 24, ptr nonnull %3), !dbg !1997
  ret i32 0, !dbg !2001
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write)
declare void @llvm.assume(i1 noundef) #1

; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias writeonly captures(none), ptr noalias readonly captures(none), i64, i1 immarg) #2

; Function Attrs: nounwind uwtable
declare i32 @sigaltstack(ptr readonly align 8, ptr align 8) local_unnamed_addr #0 align 4

; Function Attrs: nounwind uwtable
declare ptr @__error() local_unnamed_addr #0 align 4

; Function Attrs: nounwind uwtable
define internal fastcc void @Io.File.Writer.drain(ptr noalias nonnull writeonly sret({ i64, i16, [6 x i8] }) captures(none) %0, ptr nonnull align 8 %1, ptr nonnull readonly align 8 %2, i64 %3, i64 %4) unnamed_addr #0 align 4 !dbg !2003 {
Entry:
  %5 = alloca { %Io.Operation.Result__union_3184, i16, [6 x i8] }, align 8
  %6 = alloca %Io.Operation, align 8
  %7 = alloca { i64, i16, [6 x i8] }, align 8
  %8 = alloca %Io.File, align 8
  %.sroa.6 = alloca [6 x i8], align 2
    #dbg_value(ptr %1, !2004, !DIExpression(), !2005)
    #dbg_value({ ptr, i64 } poison, !2006, !DIExpression(), !2005)
    #dbg_value(i64 %4, !2007, !DIExpression(), !2005)
  %9 = ptrtoint ptr %1 to i64, !dbg !2008
  %10 = add i64 %9, -24, !dbg !2008
  %11 = inttoptr i64 %10 to ptr, !dbg !2008
    #dbg_value(ptr %11, !2009, !DIExpression(), !2008)
  %12 = getelementptr inbounds nuw i8, ptr %11, i64 70, !dbg !2011
  %13 = load i8, ptr %12, align 2, !dbg !2011
  %14 = trunc i8 %13 to i3, !dbg !2011
  %15 = zext i3 %14 to i32, !dbg !2012
  switch i32 %15, label %Default [
    i32 4, label %Case
    i32 1, label %Case1
    i32 3, label %Case1
    i32 0, label %Case2
    i32 2, label %Case2
  ], !dbg !2012

common.ret:                                       ; preds = %Io.File.Writer.drainStreaming.exit, %Io.File.Writer.drainPositional.exit
  ret void, !dbg !2013

Case:                                             ; preds = %Entry
  tail call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %0, ptr noundef nonnull align 8 dereferenceable(16) @__anon_3950, i64 16, i1 false), !dbg !2014
  ret void, !dbg !2013

Case1:                                            ; preds = %Entry, %Entry
  %16 = inttoptr i64 %10 to ptr, !dbg !2008
  tail call void @llvm.experimental.noalias.scope.decl(metadata !2016), !dbg !2019
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %6), !dbg !2021
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %5), !dbg !2021
    #dbg_value(ptr %11, !2026, !DIExpression(), !2027)
    #dbg_value({ ptr, i64 } poison, !2028, !DIExpression(), !2027)
    #dbg_value(i64 %4, !2029, !DIExpression(), !2027)
  %.sroa.013.0.copyload.i = load ptr, ptr %16, align 8, !dbg !2021, !noalias !2016
    #dbg_value(ptr %.sroa.013.0.copyload.i, !2030, !DIExpression(DW_OP_LLVM_fragment, 0, 64), !2031)
  %.sroa.214.0..0..sroa_idx.i = getelementptr inbounds nuw i8, ptr %16, i64 8, !dbg !2021
  %.sroa.214.0.copyload.i = load ptr, ptr %.sroa.214.0..0..sroa_idx.i, align 8, !dbg !2021, !noalias !2016
    #dbg_value(ptr %.sroa.214.0.copyload.i, !2030, !DIExpression(DW_OP_LLVM_fragment, 64, 64), !2031)
  %17 = getelementptr i8, ptr %16, i64 32, !dbg !2032
  %.val.i = load ptr, ptr %17, align 8, !dbg !2032, !noalias !2016
  %18 = getelementptr i8, ptr %16, i64 48, !dbg !2032
  %.val20.i = load i64, ptr %18, align 8, !dbg !2032, !noalias !2016
    #dbg_value({ ptr, i64 } poison, !2033, !DIExpression(), !2032)
  %19 = getelementptr inbounds nuw i8, ptr %.sroa.214.0.copyload.i, i64 384, !dbg !2034
  %20 = load ptr, ptr %19, align 8, !dbg !2034, !noalias !2016
  %21 = getelementptr inbounds nuw i8, ptr %16, i64 56, !dbg !2035
  %22 = load i64, ptr %21, align 8, !dbg !2035, !noalias !2016
  store i64 %22, ptr %5, align 8, !dbg !2035, !noalias !2016
  %23 = getelementptr inbounds nuw i8, ptr %16, i64 16, !dbg !2036
  %24 = load i64, ptr %23, align 8, !dbg !2036, !noalias !2016
  call fastcc void %20(ptr nonnull sret({ i64, i16, [6 x i8] }) %6, ptr align 1 %.sroa.013.0.copyload.i, ptr nonnull readonly align 4 %5, ptr nonnull readonly align 1 %.val.i, i64 %.val20.i, ptr nonnull readonly align 8 %2, i64 %3, i64 %4, i64 %24) #9, !dbg !2034, !noalias !2016
  %25 = getelementptr inbounds nuw i8, ptr %6, i64 8, !dbg !2037
  %26 = load i16, ptr %25, align 8, !dbg !2037, !noalias !2016
  %27 = zext i16 %26 to i32, !dbg !2038
  switch i32 %27, label %Default.i [
    i32 0, label %Then.i
    i32 22, label %Case.i
  ], !dbg !2038, !prof !2040

Then.i:                                           ; preds = %Case1
  %28 = load i64, ptr %6, align 8, !dbg !2041, !noalias !2016
    #dbg_value(i64 %28, !2044, !DIExpression(), !2045)
  %sunkaddr = inttoptr i64 %10 to ptr, !dbg !2047
  %sunkaddr16 = getelementptr inbounds i8, ptr %sunkaddr, i64 16, !dbg !2047
  %29 = load i64, ptr %sunkaddr16, align 8, !dbg !2047, !noalias !2016
  %30 = add nuw i64 %29, %28, !dbg !2048
  store i64 %30, ptr %sunkaddr16, align 8, !dbg !2048, !noalias !2016
    #dbg_value(ptr %11, !2049, !DIExpression(DW_OP_plus_uconst, 24, DW_OP_stack_value), !2053)
    #dbg_value(i64 %28, !2055, !DIExpression(), !2053)
  %sunkaddr17 = inttoptr i64 %10 to ptr, !dbg !2056
  %sunkaddr18 = getelementptr i8, ptr %sunkaddr17, i64 48, !dbg !2056
  %31 = load i64, ptr %sunkaddr18, align 8, !dbg !2056, !noalias !2016
  %32 = icmp ult i64 %28, %31, !dbg !2056
  br i1 %32, label %Then.i.i, label %Else.i.i, !dbg !2056

Then.i.i:                                         ; preds = %Then.i
  %sunkaddr19 = inttoptr i64 %10 to ptr, !dbg !2058
  %sunkaddr20 = getelementptr i8, ptr %sunkaddr19, i64 32, !dbg !2058
  %.unpack.i.i = load ptr, ptr %sunkaddr20, align 8, !dbg !2058, !noalias !2016
  %33 = getelementptr inbounds [1 x i8], ptr %.unpack.i.i, i64 %28, !dbg !2058
  %34 = sub nuw i64 %31, %28, !dbg !2058
    #dbg_value({ ptr, i64 } poison, !2060, !DIExpression(), !2058)
  call void @llvm.memmove.p0.p0.i64(ptr align 1 %.unpack.i.i, ptr align 1 %33, i64 %34, i1 false), !dbg !2061, !noalias !2016
  br label %Io.Writer.consume.exit.i, !dbg !2062

Else.i.i:                                         ; preds = %Then.i
  %35 = sub nuw i64 %28, %31, !dbg !2063
  br label %Io.Writer.consume.exit.i, !dbg !2064

Io.Writer.consume.exit.i:                         ; preds = %Else.i.i, %Then.i.i
  %storemerge.i.i = phi i64 [ 0, %Else.i.i ], [ %34, %Then.i.i ], !dbg !2065
  %common.ret.op.i.i = phi i64 [ %35, %Else.i.i ], [ 0, %Then.i.i ]
  %sunkaddr21 = inttoptr i64 %10 to ptr, !dbg !2065
  %sunkaddr22 = getelementptr i8, ptr %sunkaddr21, i64 48, !dbg !2065
  store i64 %storemerge.i.i, ptr %sunkaddr22, align 8, !dbg !2065, !noalias !2016
  br label %Io.File.Writer.drainPositional.exit, !dbg !2066

Case.i:                                           ; preds = %Case1
  %sunkaddr23 = inttoptr i64 %10 to ptr, !dbg !2067
  %sunkaddr24 = getelementptr inbounds i8, ptr %sunkaddr23, i64 70, !dbg !2067
  %36 = load i8, ptr %sunkaddr24, align 2, !dbg !2067, !noalias !2016
  %37 = trunc i8 %36 to i3, !dbg !2067
    #dbg_value(i3 %37, !2069, !DIExpression(), !2073)
  %switch.tableidx = xor i3 %37, -4, !dbg !2075
  %switch.cast = zext i3 %switch.tableidx to i24, !dbg !2075
  %switch.shiftamt = mul nuw nsw i24 %switch.cast, 3, !dbg !2075
  %switch.downshift = lshr i24 4718596, %switch.shiftamt, !dbg !2075
  %switch.masked = trunc i24 %switch.downshift to i3, !dbg !2075
  store i3 %switch.masked, ptr %sunkaddr24, align 2, !dbg !2067, !noalias !2016
  %sunkaddr25 = inttoptr i64 %10 to ptr, !dbg !2077
  %sunkaddr26 = getelementptr inbounds i8, ptr %sunkaddr25, i64 16, !dbg !2077
  %38 = load i64, ptr %sunkaddr26, align 8, !dbg !2077, !noalias !2016
    #dbg_value(i64 %38, !2078, !DIExpression(), !2077)
  %.not.i = icmp eq i64 %38, 0, !dbg !2079
  br i1 %.not.i, label %Block1.i, label %Then1.i, !dbg !2079

Default.i:                                        ; preds = %Case1
  %39 = inttoptr i64 %10 to ptr, !dbg !2008
    #dbg_value(i16 %26, !2081, !DIExpression(), !2082)
  %40 = getelementptr inbounds nuw i8, ptr %39, i64 64, !dbg !2083
  store i16 %26, ptr %40, align 8, !dbg !2083, !noalias !2016
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 2 dereferenceable(6) %.sroa.6, ptr noundef nonnull align 2 dereferenceable(6) getelementptr inbounds nuw (i8, ptr @__anon_3950, i64 10), i64 6, i1 false), !dbg !2084
  br label %Io.File.Writer.drainPositional.exit, !dbg !2084

Block1.i:                                         ; preds = %Then1.i, %Case.i
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 2 dereferenceable(6) %.sroa.6, i8 0, i64 6, i1 false), !dbg !2086, !alias.scope !2016
  br label %Io.File.Writer.drainPositional.exit, !dbg !2086

Then1.i:                                          ; preds = %Case.i
  %41 = inttoptr i64 %10 to ptr, !dbg !2008
  %sunkaddr27 = inttoptr i64 %10 to ptr, !dbg !2087
  %sunkaddr28 = getelementptr inbounds i8, ptr %sunkaddr27, i64 16, !dbg !2087
  store i64 0, ptr %sunkaddr28, align 8, !dbg !2087, !noalias !2016
  %42 = call fastcc i16 @Io.File.Writer.seekTo(ptr nonnull align 8 %41, i64 %38), !dbg !2089, !noalias !2016
  %43 = icmp eq i16 %42, 0, !dbg !2089
  br i1 %43, label %Block1.i, label %Else2.i, !dbg !2089

Else2.i:                                          ; preds = %Then1.i
  %sunkaddr29 = inttoptr i64 %10 to ptr, !dbg !2091
  %sunkaddr30 = getelementptr inbounds i8, ptr %sunkaddr29, i64 70, !dbg !2091
  store i3 -4, ptr %sunkaddr30, align 2, !dbg !2091, !noalias !2016
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 2 dereferenceable(6) %.sroa.6, ptr noundef nonnull align 2 dereferenceable(6) getelementptr inbounds nuw (i8, ptr @__anon_3950, i64 10), i64 6, i1 false), !dbg !2093
  br label %Io.File.Writer.drainPositional.exit, !dbg !2093

Io.File.Writer.drainPositional.exit:              ; preds = %Io.Writer.consume.exit.i, %Default.i, %Block1.i, %Else2.i
  %.sroa.0.0 = phi i64 [ undef, %Default.i ], [ %common.ret.op.i.i, %Io.Writer.consume.exit.i ], [ 0, %Block1.i ], [ undef, %Else2.i ], !dbg !2031
  %.sroa.5.0 = phi i16 [ 28, %Default.i ], [ 0, %Io.Writer.consume.exit.i ], [ 0, %Block1.i ], [ 28, %Else2.i ], !dbg !2031
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %6), !dbg !2031
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %5), !dbg !2031
  store i64 %.sroa.0.0, ptr %0, align 8, !dbg !2095
  %.sroa.5.0..sroa_idx = getelementptr inbounds nuw i8, ptr %0, i64 8, !dbg !2095
  store i16 %.sroa.5.0, ptr %.sroa.5.0..sroa_idx, align 8, !dbg !2095
  %.sroa.6.0..sroa_idx = getelementptr inbounds nuw i8, ptr %0, i64 10, !dbg !2095
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 2 dereferenceable(6) %.sroa.6.0..sroa_idx, ptr noundef nonnull align 2 dereferenceable(6) %.sroa.6, i64 6, i1 false), !dbg !2095
  br label %common.ret, !dbg !2095

Case2:                                            ; preds = %Entry, %Entry
  %44 = inttoptr i64 %10 to ptr, !dbg !2008
    #dbg_value(ptr %11, !2096, !DIExpression(), !2098)
    #dbg_value({ ptr, i64 } poison, !2101, !DIExpression(), !2098)
    #dbg_value(i64 %4, !2102, !DIExpression(), !2098)
  %.sroa.0.0.copyload.i = load ptr, ptr %44, align 8, !dbg !2103, !noalias !2104
    #dbg_value(ptr %.sroa.0.0.copyload.i, !2107, !DIExpression(DW_OP_LLVM_fragment, 0, 64), !2108)
    #dbg_value(ptr %.sroa.0.0.copyload.i, !2109, !DIExpression(DW_OP_LLVM_fragment, 0, 64), !2119)
  %.sroa.2.0..sroa_idx.i = getelementptr inbounds nuw i8, ptr %44, i64 8, !dbg !2103
  %.sroa.2.0.copyload.i = load ptr, ptr %.sroa.2.0..sroa_idx.i, align 8, !dbg !2103, !noalias !2104
    #dbg_value(ptr %.sroa.2.0.copyload.i, !2107, !DIExpression(DW_OP_LLVM_fragment, 64, 64), !2108)
    #dbg_value(ptr %.sroa.2.0.copyload.i, !2109, !DIExpression(DW_OP_LLVM_fragment, 64, 64), !2119)
  %45 = getelementptr i8, ptr %44, i64 32, !dbg !2122
  %.val.i1 = load ptr, ptr %45, align 8, !dbg !2122, !noalias !2104
  %46 = getelementptr i8, ptr %44, i64 48, !dbg !2122
  %.val8.i = load i64, ptr %46, align 8, !dbg !2122, !noalias !2104
    #dbg_value({ ptr, i64 } poison, !2123, !DIExpression(), !2122)
  %47 = getelementptr inbounds nuw i8, ptr %44, i64 56, !dbg !2124
  %48 = load i64, ptr %47, align 8, !dbg !2125, !noalias !2104
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %6), !dbg !2126, !noalias !2104
    #dbg_declare(ptr poison, !2127, !DIExpression(), !2126)
    #dbg_value({ ptr, i64 } poison, !2128, !DIExpression(), !2126)
    #dbg_value({ ptr, i64 } poison, !2129, !DIExpression(), !2126)
    #dbg_value(i64 %4, !2130, !DIExpression(), !2126)
  store ptr %.val.i1, ptr %6, align 8, !dbg !2131, !noalias !2132
  %.sroa.2.0..sroa_idx.i.i = getelementptr inbounds nuw i8, ptr %6, i64 8, !dbg !2131
  store i64 %.val8.i, ptr %.sroa.2.0..sroa_idx.i.i, align 8, !dbg !2131, !noalias !2132
  %.sroa.3.0..sroa_idx.i.i = getelementptr inbounds nuw i8, ptr %6, i64 16, !dbg !2131
  store ptr %2, ptr %.sroa.3.0..sroa_idx.i.i, align 8, !dbg !2131, !noalias !2132
  %.sroa.4.0..sroa_idx.i.i = getelementptr inbounds nuw i8, ptr %6, i64 24, !dbg !2131
  store i64 %3, ptr %.sroa.4.0..sroa_idx.i.i, align 8, !dbg !2131, !noalias !2132
  %.sroa.5.0..sroa_idx.i.i = getelementptr inbounds nuw i8, ptr %6, i64 32, !dbg !2131
  store i64 %4, ptr %.sroa.5.0..sroa_idx.i.i, align 8, !dbg !2131, !noalias !2132
  %.sroa.6.0..sroa_idx.i.i = getelementptr inbounds nuw i8, ptr %6, i64 40, !dbg !2131
  store i64 %48, ptr %.sroa.6.0..sroa_idx.i.i, align 8, !dbg !2131, !noalias !2132
  %49 = getelementptr inbounds nuw i8, ptr %6, i64 48, !dbg !2131
  store i2 1, ptr %49, align 8, !dbg !2131, !noalias !2132
  %50 = getelementptr i8, ptr %.sroa.2.0.copyload.i, i64 120, !dbg !2131
  %.val9.val.i.i = load ptr, ptr %50, align 8, !dbg !2131, !noalias !2132
  call void @llvm.lifetime.start.p0(i64 32, ptr nonnull %5), !dbg !2135, !noalias !2132
    #dbg_declare(ptr poison, !2140, !DIExpression(), !2141)
    #dbg_declare(ptr %6, !2142, !DIExpression(), !2141)
  call fastcc void %.val9.val.i.i(ptr nonnull sret({ %Io.Operation.Result__union_3184, i16, [6 x i8] }) %5, ptr align 1 %.sroa.0.0.copyload.i, ptr nonnull readonly align 8 %6) #9, !dbg !2135, !noalias !2143
  %.sroa.05.i.sroa.0.0.copyload.i = load i64, ptr %5, align 8, !dbg !2146, !noalias !2132
  %.sroa.05.i.sroa.4.0..sroa_idx.i = getelementptr inbounds nuw i8, ptr %5, i64 8, !dbg !2146
  %.sroa.05.i.sroa.4.0.copyload.i = load i16, ptr %.sroa.05.i.sroa.4.0..sroa_idx.i, align 8, !dbg !2146, !noalias !2132
  %51 = zext i16 %.sroa.05.i.sroa.4.0.copyload.i to i32, !dbg !2146
  %.sroa.25.0..sroa_idx.i.i = getelementptr inbounds nuw i8, ptr %5, i64 24, !dbg !2146
  %.sroa.25.0.copyload.i.i = load i16, ptr %.sroa.25.0..sroa_idx.i.i, align 8, !dbg !2146, !noalias !2132
  %52 = zext i16 %.sroa.25.0.copyload.i.i to i32, !dbg !2146
  call void @llvm.lifetime.end.p0(i64 32, ptr nonnull %5), !dbg !2146, !noalias !2132
  %.not.i.i = icmp eq i32 %52, 0, !dbg !2131
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %6), !dbg !2147, !noalias !2104
  br i1 %.not.i.i, label %Io.File.writeStreaming.exit.i, label %Else.i, !dbg !2131, !prof !2148

Io.File.writeStreaming.exit.i:                    ; preds = %Case2
  %53 = icmp eq i32 %51, 0, !dbg !2125
  br i1 %53, label %Then.i2, label %Else.i, !dbg !2125

Then.i2:                                          ; preds = %Io.File.writeStreaming.exit.i
  %54 = inttoptr i64 %10 to ptr, !dbg !2008
    #dbg_value(i64 %.sroa.05.i.sroa.0.0.copyload.i, !2149, !DIExpression(), !2150)
  %55 = getelementptr inbounds nuw i8, ptr %54, i64 16, !dbg !2152
  %56 = load i64, ptr %55, align 8, !dbg !2152, !noalias !2104
  %57 = add nuw i64 %56, %.sroa.05.i.sroa.0.0.copyload.i, !dbg !2153
  store i64 %57, ptr %55, align 8, !dbg !2153, !noalias !2104
    #dbg_value(ptr %11, !2049, !DIExpression(DW_OP_plus_uconst, 24, DW_OP_stack_value), !2154)
    #dbg_value(i64 %.sroa.05.i.sroa.0.0.copyload.i, !2055, !DIExpression(), !2154)
  %sunkaddr31 = inttoptr i64 %10 to ptr, !dbg !2156
  %sunkaddr32 = getelementptr i8, ptr %sunkaddr31, i64 48, !dbg !2156
  %58 = load i64, ptr %sunkaddr32, align 8, !dbg !2156, !noalias !2104
  %59 = icmp ult i64 %.sroa.05.i.sroa.0.0.copyload.i, %58, !dbg !2156
  br i1 %59, label %Then.i.i7, label %Else.i.i3, !dbg !2156

Then.i.i7:                                        ; preds = %Then.i2
  %sunkaddr33 = inttoptr i64 %10 to ptr, !dbg !2157
  %sunkaddr34 = getelementptr i8, ptr %sunkaddr33, i64 32, !dbg !2157
  %.unpack.i.i8 = load ptr, ptr %sunkaddr34, align 8, !dbg !2157, !noalias !2104
  %60 = getelementptr inbounds [1 x i8], ptr %.unpack.i.i8, i64 %.sroa.05.i.sroa.0.0.copyload.i, !dbg !2157
  %61 = sub nuw i64 %58, %.sroa.05.i.sroa.0.0.copyload.i, !dbg !2157
    #dbg_value({ ptr, i64 } poison, !2060, !DIExpression(), !2157)
  call void @llvm.memmove.p0.p0.i64(ptr align 1 %.unpack.i.i8, ptr align 1 %60, i64 %61, i1 false), !dbg !2158, !noalias !2104
  br label %Io.Writer.consume.exit.i4, !dbg !2159

Else.i.i3:                                        ; preds = %Then.i2
  %62 = sub nuw i64 %.sroa.05.i.sroa.0.0.copyload.i, %58, !dbg !2160
  br label %Io.Writer.consume.exit.i4, !dbg !2161

Io.Writer.consume.exit.i4:                        ; preds = %Else.i.i3, %Then.i.i7
  %storemerge.i.i5 = phi i64 [ 0, %Else.i.i3 ], [ %61, %Then.i.i7 ], !dbg !2162
  %common.ret.op.i.i6 = phi i64 [ %62, %Else.i.i3 ], [ 0, %Then.i.i7 ]
  %sunkaddr35 = inttoptr i64 %10 to ptr, !dbg !2162
  %sunkaddr36 = getelementptr i8, ptr %sunkaddr35, i64 48, !dbg !2162
  store i64 %storemerge.i.i5, ptr %sunkaddr36, align 8, !dbg !2162, !noalias !2104
  br label %Io.File.Writer.drainStreaming.exit, !dbg !2163

Else.i:                                           ; preds = %Io.File.writeStreaming.exit.i, %Case2
  %.sroa.212.015.i = phi i32 [ %51, %Io.File.writeStreaming.exit.i ], [ %52, %Case2 ]
  %63 = inttoptr i64 %10 to ptr, !dbg !2008
  %64 = getelementptr inbounds nuw i8, ptr %63, i64 64, !dbg !2164
  %65 = trunc i32 %.sroa.212.015.i to i16
  store i16 %65, ptr %64, align 8, !dbg !2164, !noalias !2104
  br label %Io.File.Writer.drainStreaming.exit, !dbg !2165

Io.File.Writer.drainStreaming.exit:               ; preds = %Io.Writer.consume.exit.i4, %Else.i
  %.sroa.3.0 = phi i16 [ 0, %Io.Writer.consume.exit.i4 ], [ 28, %Else.i ], !dbg !2108
  %.sroa.013.0 = phi i64 [ %common.ret.op.i.i6, %Io.Writer.consume.exit.i4 ], [ undef, %Else.i ], !dbg !2108
  store i64 %.sroa.013.0, ptr %0, align 8, !dbg !2167
  %.sroa.3.0..sroa_idx = getelementptr inbounds nuw i8, ptr %0, i64 8, !dbg !2167
  store i16 %.sroa.3.0, ptr %.sroa.3.0..sroa_idx, align 8, !dbg !2167
  %.sroa.4.0..sroa_idx = getelementptr inbounds nuw i8, ptr %0, i64 10, !dbg !2167
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 2 dereferenceable(6) %.sroa.4.0..sroa_idx, ptr noundef nonnull align 2 dereferenceable(6) getelementptr inbounds nuw (i8, ptr @__anon_3950, i64 10), i64 6, i1 false), !dbg !2167
  br label %common.ret, !dbg !2167

Default:                                          ; preds = %Entry
  unreachable, !dbg !2168
}

; Function Attrs: nounwind uwtable
define internal fastcc i16 @Io.Writer.defaultRebase(ptr nonnull align 8 %0, i64 %1, i64 %2) unnamed_addr #0 align 4 !dbg !2170 {
Entry:
  %3 = alloca { i64, i16, [6 x i8] }, align 8
    #dbg_value(ptr %0, !2171, !DIExpression(), !2172)
    #dbg_value(i64 %1, !2173, !DIExpression(), !2172)
    #dbg_value(i64 %2, !2174, !DIExpression(), !2172)
  %4 = getelementptr inbounds nuw i8, ptr %0, i64 16
  %5 = getelementptr inbounds nuw i8, ptr %0, i64 24
  %6 = load i64, ptr %4, align 8, !dbg !2175
  %7 = load i64, ptr %5, align 8, !dbg !2179
  %8 = sub nuw i64 %6, %7, !dbg !2180
  %9 = icmp ult i64 %8, %2, !dbg !2180
  br i1 %9, label %Then.lr.ph, label %common.ret, !dbg !2180

Then.lr.ph:                                       ; preds = %Entry
  br label %Then, !dbg !2180

common.ret:                                       ; preds = %TryCont, %Entry, %TryRet
  %common.ret.op = phi i16 [ %15, %TryRet ], [ 0, %Entry ], [ 0, %TryCont ]
  ret i16 %common.ret.op, !dbg !2181

Then:                                             ; preds = %Then.lr.ph, %TryCont
  %10 = phi i64 [ %7, %Then.lr.ph ], [ %22, %TryCont ]
  %11 = call i64 @llvm.usub.sat.i64(i64 %10, i64 %1), !dbg !2182
    #dbg_value(i64 %11, !2185, !DIExpression(), !2182)
    #dbg_value(i64 %10, !2186, !DIExpression(), !2187)
  %12 = sub nuw i64 %10, %11, !dbg !2188
    #dbg_value(i64 %12, !2189, !DIExpression(), !2188)
  %sunkaddr = getelementptr inbounds i8, ptr %0, i64 24, !dbg !2190
  store i64 %11, ptr %sunkaddr, align 8, !dbg !2190
  %13 = load ptr, ptr %0, align 8, !dbg !2191
  %14 = load ptr, ptr %13, align 8, !dbg !2191
  call fastcc void %14(ptr nonnull sret({ i64, i16, [6 x i8] }) %3, ptr nonnull align 8 %0, ptr nonnull readonly align 8 @__anon_2967, i64 1, i64 1) #9, !dbg !2191
  %sunkaddr34 = getelementptr inbounds i8, ptr %3, i64 8, !dbg !2191
  %15 = load i16, ptr %sunkaddr34, align 8, !dbg !2191
  %.not = icmp eq i16 %15, 0, !dbg !2191
  br i1 %.not, label %TryCont, label %TryRet, !dbg !2191, !prof !2148

TryRet:                                           ; preds = %Then
  %sunkaddr35 = getelementptr inbounds i8, ptr %0, i64 24, !dbg !2192
  %16 = load i64, ptr %sunkaddr35, align 8, !dbg !2192
  %17 = add nuw i64 %16, %12, !dbg !2194
  store i64 %17, ptr %sunkaddr35, align 8, !dbg !2194
  br label %common.ret, !dbg !2195

TryCont:                                          ; preds = %Then
    #dbg_value(i1 true, !2197, !DIExpression(), !2201)
  %sunkaddr36 = getelementptr inbounds i8, ptr %0, i64 24, !dbg !2204
  %18 = load i64, ptr %sunkaddr36, align 8, !dbg !2204
    #dbg_value(i1 true, !2197, !DIExpression(), !2205)
  %sunkaddr37 = getelementptr inbounds i8, ptr %0, i64 8, !dbg !2207
  %.unpack = load ptr, ptr %sunkaddr37, align 8, !dbg !2207
  %19 = getelementptr inbounds [1 x i8], ptr %.unpack, i64 %18, !dbg !2207
  %20 = getelementptr inbounds [1 x i8], ptr %.unpack, i64 %11, !dbg !2208
  call void @llvm.memmove.p0.p0.i64(ptr align 1 %19, ptr align 1 %20, i64 %12, i1 false), !dbg !2208
  %21 = load i64, ptr %sunkaddr36, align 8, !dbg !2209
  %22 = add nuw i64 %21, %12, !dbg !2211
  store i64 %22, ptr %sunkaddr36, align 8, !dbg !2211
  %sunkaddr38 = getelementptr inbounds i8, ptr %0, i64 16, !dbg !2212
  %23 = load i64, ptr %sunkaddr38, align 8, !dbg !2212
    #dbg_value(i1 true, !2197, !DIExpression(), !2213)
  %24 = sub nuw i64 %23, %22, !dbg !2180
  %25 = icmp ult i64 %24, %2, !dbg !2180
  br i1 %25, label %Then, label %common.ret, !dbg !2180
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.usub.sat.i64(i64, i64) #3

; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memmove.p0.p0.i64(ptr writeonly captures(none), ptr readonly captures(none), i64, i1 immarg) #2

; Function Attrs: nounwind uwtable
define internal fastcc i16 @Io.Writer.defaultFlush(ptr nonnull align 8 %0) unnamed_addr #0 align 4 !dbg !2215 {
Entry:
  %1 = alloca { i64, i16, [6 x i8] }, align 8
    #dbg_value(ptr %0, !2216, !DIExpression(), !2217)
  %2 = load ptr, ptr %0, align 8, !dbg !2218
  %3 = load ptr, ptr %2, align 8, !dbg !2218
    #dbg_value(ptr %3, !2219, !DIExpression(), !2218)
  br label %Loop, !dbg !2220

common.ret:                                       ; preds = %Then, %Loop
  %common.ret.op = phi i16 [ 0, %Loop ], [ %5, %Then ]
  ret i16 %common.ret.op, !dbg !2222

Loop:                                             ; preds = %Then, %Entry
  %sunkaddr = getelementptr inbounds i8, ptr %0, i64 24, !dbg !2225
  %4 = load i64, ptr %sunkaddr, align 8, !dbg !2225
  %.not = icmp eq i64 %4, 0, !dbg !2225
  br i1 %.not, label %common.ret, label %Then, !dbg !2225

Then:                                             ; preds = %Loop
  call fastcc void %3(ptr nonnull sret({ i64, i16, [6 x i8] }) %1, ptr nonnull align 8 %0, ptr nonnull readonly align 8 @__anon_2967, i64 1, i64 1) #9, !dbg !2227
  %sunkaddr3 = getelementptr inbounds i8, ptr %1, i64 8, !dbg !2227
  %5 = load i16, ptr %sunkaddr3, align 8, !dbg !2227
  %.not2 = icmp eq i16 %5, 0, !dbg !2227
  br i1 %.not2, label %Loop, label %common.ret, !dbg !2227, !prof !2148
}

; Function Attrs: nounwind uwtable
define internal fastcc i16 @Io.File.Writer.seekTo(ptr nonnull align 8 %0, i64 range(i64 1, 0) %1) unnamed_addr #0 align 4 !dbg !2230 {
Entry:
  %2 = alloca %Io.File, align 8
    #dbg_value(ptr %0, !2238, !DIExpression(), !2239)
    #dbg_value(i64 %1, !2240, !DIExpression(), !2239)
  %3 = getelementptr inbounds nuw i8, ptr %0, i64 24, !dbg !2241
    #dbg_value(ptr %3, !2242, !DIExpression(), !2244)
  %4 = load ptr, ptr %3, align 8, !dbg !2246
  %5 = getelementptr inbounds nuw i8, ptr %4, i64 16, !dbg !2246
  %6 = load ptr, ptr %5, align 8, !dbg !2246
  %7 = tail call fastcc i16 %6(ptr nonnull align 8 %3) #9, !dbg !2246
  %.not = icmp eq i16 %7, 0, !dbg !2247
  br i1 %.not, label %TryCont, label %common.ret, !dbg !2247, !prof !2148

common.ret:                                       ; preds = %Io.File.Writer.seekToUnbuffered.exit, %Entry
  %common.ret.op = phi i16 [ %7, %Entry ], [ %common.ret.op.i, %Io.File.Writer.seekToUnbuffered.exit ]
  ret i16 %common.ret.op, !dbg !2248

TryCont:                                          ; preds = %Entry
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %2), !dbg !2249
    #dbg_value(ptr %0, !2254, !DIExpression(), !2255)
    #dbg_value(i64 %1, !2256, !DIExpression(), !2255)
    #dbg_value(i1 true, !2197, !DIExpression(), !2257)
  %.sroa.010.0.copyload.i = load ptr, ptr %0, align 8, !dbg !2260
    #dbg_value(ptr %.sroa.010.0.copyload.i, !2261, !DIExpression(DW_OP_LLVM_fragment, 0, 64), !2262)
  %.sroa.211.0..0.1.sroa_idx.i = getelementptr inbounds nuw i8, ptr %0, i64 8, !dbg !2260
  %.sroa.211.0.copyload.i = load ptr, ptr %.sroa.211.0..0.1.sroa_idx.i, align 8, !dbg !2260
    #dbg_value(ptr %.sroa.211.0.copyload.i, !2261, !DIExpression(DW_OP_LLVM_fragment, 64, 64), !2262)
  %8 = getelementptr inbounds nuw i8, ptr %0, i64 70, !dbg !2263
  %9 = load i8, ptr %8, align 2, !dbg !2263
  %10 = trunc i8 %9 to i3, !dbg !2263
  %11 = zext i3 %10 to i32, !dbg !2264
  switch i32 %11, label %Default.i [
    i32 4, label %Case.i
    i32 1, label %Case1.i
    i32 3, label %Case1.i
    i32 0, label %Case2.i
    i32 2, label %Case2.i
  ], !dbg !2264

Case.i:                                           ; preds = %TryCont
  %12 = getelementptr inbounds nuw i8, ptr %0, i64 68, !dbg !2266
  %13 = load i16, ptr %12, align 4, !dbg !2266
  br label %Io.File.Writer.seekToUnbuffered.exit, !dbg !2268

Case1.i:                                          ; preds = %TryCont, %TryCont
  %14 = getelementptr inbounds nuw i8, ptr %0, i64 16, !dbg !2269
  store i64 %1, ptr %14, align 8, !dbg !2269
  br label %Io.File.Writer.seekToUnbuffered.exit, !dbg !2269

Case2.i:                                          ; preds = %TryCont, %TryCont
  %15 = getelementptr inbounds nuw i8, ptr %0, i64 68, !dbg !2271
  %16 = load i16, ptr %15, align 4, !dbg !2271
  %.not.i = icmp eq i16 %16, 0, !dbg !2271
  br i1 %.not.i, label %Else.i, label %Io.File.Writer.seekToUnbuffered.exit, !dbg !2271

Default.i:                                        ; preds = %TryCont
  unreachable, !dbg !2274

Else.i:                                           ; preds = %Case2.i
  %17 = getelementptr inbounds nuw i8, ptr %.sroa.211.0.copyload.i, i64 424, !dbg !2276
  %18 = load ptr, ptr %17, align 8, !dbg !2276
  %19 = getelementptr inbounds nuw i8, ptr %0, i64 56, !dbg !2278
  %20 = load i64, ptr %19, align 8, !dbg !2278
  store i64 %20, ptr %2, align 8, !dbg !2278
  %21 = call fastcc i16 %18(ptr align 1 %.sroa.010.0.copyload.i, ptr nonnull readonly align 4 %2, i64 range(i64 1, 0) %1) #9, !dbg !2276
  %22 = icmp eq i16 %21, 0, !dbg !2276
  br i1 %22, label %Then1.i, label %Else1.i, !dbg !2276

Then1.i:                                          ; preds = %Else.i
  %23 = getelementptr inbounds nuw i8, ptr %0, i64 16, !dbg !2279
  store i64 %1, ptr %23, align 8, !dbg !2279
  br label %Io.File.Writer.seekToUnbuffered.exit, !dbg !2279

Else1.i:                                          ; preds = %Else.i
  %sunkaddr = getelementptr inbounds i8, ptr %0, i64 68, !dbg !2281
  store i16 %21, ptr %sunkaddr, align 4, !dbg !2281
  br label %Io.File.Writer.seekToUnbuffered.exit, !dbg !2283

Io.File.Writer.seekToUnbuffered.exit:             ; preds = %Case.i, %Case1.i, %Case2.i, %Then1.i, %Else1.i
  %common.ret.op.i = phi i16 [ %13, %Case.i ], [ %21, %Else1.i ], [ 0, %Then1.i ], [ 0, %Case1.i ], [ %16, %Case2.i ]
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %2), !dbg !2284
  br label %common.ret, !dbg !2285
}

; Function Attrs: nounwind uwtable
define internal fastcc void @Io.File.Writer.sendFile(ptr noalias nonnull writeonly sret({ i64, i16, [6 x i8] }) captures(none) %0, ptr nonnull align 8 %1, ptr nonnull align 1 %2, i64 %3) unnamed_addr #0 align 4 !dbg !2287 {
Entry:
  %4 = alloca { i64, i16, [6 x i8] }, align 8
  %5 = alloca %Io.File, align 8
  %6 = alloca { i64, i16, [6 x i8] }, align 8
  %7 = alloca %Io.File, align 8
  %.sroa.8 = alloca [6 x i8], align 2
  %.sroa.10 = alloca [6 x i8], align 2
    #dbg_value(ptr %1, !2288, !DIExpression(), !2289)
    #dbg_value(ptr %2, !2290, !DIExpression(), !2289)
    #dbg_value(i64 %3, !2291, !DIExpression(), !2289)
  %8 = ptrtoint ptr %1 to i64, !dbg !2292
  %9 = add i64 %8, -24, !dbg !2292
  %10 = inttoptr i64 %9 to ptr, !dbg !2292
    #dbg_value(ptr %10, !2293, !DIExpression(), !2292)
  %11 = getelementptr inbounds nuw i8, ptr %10, i64 70, !dbg !2294
  %12 = load i8, ptr %11, align 2, !dbg !2294
  %13 = trunc i8 %12 to i3, !dbg !2294
  %14 = zext i3 %13 to i32, !dbg !2295
  switch i32 %14, label %Default [
    i32 1, label %Case
    i32 3, label %Case1
    i32 0, label %Case2
    i32 2, label %Case3
    i32 4, label %Case4
  ], !dbg !2295

common.ret:                                       ; preds = %Io.File.Writer.sendFileStreaming.exit, %Io.File.Writer.sendFilePositional.exit
  ret void, !dbg !2296

Case:                                             ; preds = %Entry
  %15 = inttoptr i64 %9 to ptr, !dbg !2292
  tail call void @llvm.experimental.noalias.scope.decl(metadata !2297), !dbg !2300
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %4), !dbg !2302
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %5), !dbg !2302
    #dbg_value(ptr %10, !2307, !DIExpression(), !2308)
    #dbg_value(ptr %2, !2309, !DIExpression(), !2308)
    #dbg_value(i64 %3, !2310, !DIExpression(), !2308)
  %.sroa.014.0.copyload.i = load ptr, ptr %15, align 8, !dbg !2302, !noalias !2297
    #dbg_value(ptr %.sroa.014.0.copyload.i, !2311, !DIExpression(DW_OP_LLVM_fragment, 0, 64), !2312)
  %.sroa.215.0..0..sroa_idx.i = getelementptr inbounds nuw i8, ptr %15, i64 8, !dbg !2302
  %.sroa.215.0.copyload.i = load ptr, ptr %.sroa.215.0..0..sroa_idx.i, align 8, !dbg !2302, !noalias !2297
    #dbg_value(ptr %.sroa.215.0.copyload.i, !2311, !DIExpression(DW_OP_LLVM_fragment, 64, 64), !2312)
  %16 = getelementptr i8, ptr %15, i64 32, !dbg !2313
  %.val.i = load ptr, ptr %16, align 8, !dbg !2313, !noalias !2297
  %17 = getelementptr i8, ptr %15, i64 48, !dbg !2313
  %.val21.i = load i64, ptr %17, align 8, !dbg !2313, !noalias !2297
    #dbg_value({ ptr, i64 } poison, !2314, !DIExpression(), !2313)
  %18 = getelementptr inbounds nuw i8, ptr %.sroa.215.0.copyload.i, i64 400, !dbg !2315
  %19 = load ptr, ptr %18, align 8, !dbg !2315, !noalias !2297
  %20 = getelementptr inbounds nuw i8, ptr %15, i64 56, !dbg !2316
  %21 = load i64, ptr %20, align 8, !dbg !2316, !noalias !2297
  store i64 %21, ptr %5, align 8, !dbg !2316, !noalias !2297
  %22 = getelementptr inbounds nuw i8, ptr %15, i64 16, !dbg !2317
  %23 = load i64, ptr %22, align 8, !dbg !2317, !noalias !2297
  call fastcc void %19(ptr nonnull sret({ i64, i16, [6 x i8] }) %4, ptr align 1 %.sroa.014.0.copyload.i, ptr nonnull readonly align 4 %5, ptr nonnull readonly align 1 %.val.i, i64 %.val21.i, ptr nonnull align 1 %2, i64 %3, i64 %23) #9, !dbg !2315, !noalias !2297
  %24 = getelementptr inbounds nuw i8, ptr %4, i64 8, !dbg !2318
  %25 = load i16, ptr %24, align 8, !dbg !2318, !noalias !2297
  %26 = zext i16 %25 to i32, !dbg !2319
  switch i32 %26, label %Default.i [
    i32 0, label %Then.i
    i32 22, label %Case.i
    i32 17, label %Case1.i
    i32 20, label %Case2.i
    i32 18, label %Case3.i
    i32 21, label %Case4.i
  ], !dbg !2319, !prof !2321

Then.i:                                           ; preds = %Case
  %27 = load i64, ptr %4, align 8, !dbg !2322, !noalias !2297
    #dbg_value(i64 %27, !2325, !DIExpression(), !2326)
  %sunkaddr = inttoptr i64 %9 to ptr, !dbg !2328
  %sunkaddr37 = getelementptr inbounds i8, ptr %sunkaddr, i64 16, !dbg !2328
  %28 = load i64, ptr %sunkaddr37, align 8, !dbg !2328, !noalias !2297
  %29 = add nuw i64 %28, %27, !dbg !2329
  store i64 %29, ptr %sunkaddr37, align 8, !dbg !2329, !noalias !2297
    #dbg_value(ptr %10, !2049, !DIExpression(DW_OP_plus_uconst, 24, DW_OP_stack_value), !2330)
    #dbg_value(i64 %27, !2055, !DIExpression(), !2330)
  %sunkaddr38 = inttoptr i64 %9 to ptr, !dbg !2332
  %sunkaddr39 = getelementptr i8, ptr %sunkaddr38, i64 48, !dbg !2332
  %30 = load i64, ptr %sunkaddr39, align 8, !dbg !2332, !noalias !2297
  %31 = icmp ult i64 %27, %30, !dbg !2332
  br i1 %31, label %Then.i.i, label %Else.i.i, !dbg !2332

Then.i.i:                                         ; preds = %Then.i
  %sunkaddr40 = inttoptr i64 %9 to ptr, !dbg !2333
  %sunkaddr41 = getelementptr i8, ptr %sunkaddr40, i64 32, !dbg !2333
  %.unpack.i.i = load ptr, ptr %sunkaddr41, align 8, !dbg !2333, !noalias !2297
  %32 = getelementptr inbounds [1 x i8], ptr %.unpack.i.i, i64 %27, !dbg !2333
  %33 = sub nuw i64 %30, %27, !dbg !2333
    #dbg_value({ ptr, i64 } poison, !2060, !DIExpression(), !2333)
  call void @llvm.memmove.p0.p0.i64(ptr align 1 %.unpack.i.i, ptr align 1 %32, i64 %33, i1 false), !dbg !2334, !noalias !2297
  br label %Io.Writer.consume.exit.i, !dbg !2335

Else.i.i:                                         ; preds = %Then.i
  %34 = sub nuw i64 %27, %30, !dbg !2336
  br label %Io.Writer.consume.exit.i, !dbg !2337

Io.Writer.consume.exit.i:                         ; preds = %Else.i.i, %Then.i.i
  %storemerge.i.i = phi i64 [ 0, %Else.i.i ], [ %33, %Then.i.i ], !dbg !2338
  %common.ret.op.i.i = phi i64 [ %34, %Else.i.i ], [ 0, %Then.i.i ]
  %sunkaddr42 = inttoptr i64 %9 to ptr, !dbg !2338
  %sunkaddr43 = getelementptr i8, ptr %sunkaddr42, i64 48, !dbg !2338
  store i64 %storemerge.i.i, ptr %sunkaddr43, align 8, !dbg !2338, !noalias !2297
  br label %Io.File.Writer.sendFilePositional.exit, !dbg !2339

Case.i:                                           ; preds = %Case
  %sunkaddr44 = inttoptr i64 %9 to ptr, !dbg !2340
  %sunkaddr45 = getelementptr inbounds i8, ptr %sunkaddr44, i64 70, !dbg !2340
  %35 = load i8, ptr %sunkaddr45, align 2, !dbg !2340, !noalias !2297
  %36 = trunc i8 %35 to i3, !dbg !2340
    #dbg_value(i3 %36, !2069, !DIExpression(), !2342)
  %switch.tableidx = xor i3 %36, -4, !dbg !2344
  %switch.cast = zext i3 %switch.tableidx to i24, !dbg !2344
  %switch.shiftamt = mul nuw nsw i24 %switch.cast, 3, !dbg !2344
  %switch.downshift = lshr i24 4718596, %switch.shiftamt, !dbg !2344
  %switch.masked = trunc i24 %switch.downshift to i3, !dbg !2344
  store i3 %switch.masked, ptr %sunkaddr45, align 2, !dbg !2340, !noalias !2297
  %sunkaddr46 = inttoptr i64 %9 to ptr, !dbg !2345
  %sunkaddr47 = getelementptr inbounds i8, ptr %sunkaddr46, i64 16, !dbg !2345
  %37 = load i64, ptr %sunkaddr47, align 8, !dbg !2345, !noalias !2297
    #dbg_value(i64 %37, !2346, !DIExpression(), !2345)
  %.not.i = icmp eq i64 %37, 0, !dbg !2347
  br i1 %.not.i, label %Block1.i, label %Then1.i, !dbg !2347

Case1.i:                                          ; preds = %Case
  %38 = inttoptr i64 %9 to ptr, !dbg !2292
  %39 = getelementptr inbounds nuw i8, ptr %38, i64 64, !dbg !2349
  store i16 17, ptr %39, align 8, !dbg !2349, !noalias !2297
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 2 dereferenceable(6) %.sroa.10, ptr noundef nonnull align 2 dereferenceable(6) getelementptr inbounds nuw (i8, ptr @__anon_3950, i64 10), i64 6, i1 false), !dbg !2351
  br label %Io.File.Writer.sendFilePositional.exit, !dbg !2351

Case2.i:                                          ; preds = %Case
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 2 dereferenceable(6) %.sroa.10, ptr noundef nonnull align 2 dereferenceable(6) getelementptr inbounds nuw (i8, ptr @__anon_3966, i64 10), i64 6, i1 false), !dbg !2352
  br label %Io.File.Writer.sendFilePositional.exit, !dbg !2352

Case3.i:                                          ; preds = %Case
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 2 dereferenceable(6) %.sroa.10, ptr noundef nonnull align 2 dereferenceable(6) getelementptr inbounds nuw (i8, ptr @__anon_3942, i64 10), i64 6, i1 false), !dbg !2354
  br label %Io.File.Writer.sendFilePositional.exit, !dbg !2354

Case4.i:                                          ; preds = %Case
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 2 dereferenceable(6) %.sroa.10, ptr noundef nonnull align 2 dereferenceable(6) getelementptr inbounds nuw (i8, ptr @__anon_3968, i64 10), i64 6, i1 false), !dbg !2356
  br label %Io.File.Writer.sendFilePositional.exit, !dbg !2356

Default.i:                                        ; preds = %Case
  %40 = inttoptr i64 %9 to ptr, !dbg !2292
    #dbg_value(i16 %25, !2358, !DIExpression(), !2360)
  %41 = getelementptr inbounds nuw i8, ptr %40, i64 66, !dbg !2361
  store i16 %25, ptr %41, align 2, !dbg !2361, !noalias !2297
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 2 dereferenceable(6) %.sroa.10, ptr noundef nonnull align 2 dereferenceable(6) getelementptr inbounds nuw (i8, ptr @__anon_3950, i64 10), i64 6, i1 false), !dbg !2362
  br label %Io.File.Writer.sendFilePositional.exit, !dbg !2362

Block1.i:                                         ; preds = %Then1.i, %Case.i
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 2 dereferenceable(6) %.sroa.10, i8 0, i64 6, i1 false), !dbg !2364, !alias.scope !2297
  br label %Io.File.Writer.sendFilePositional.exit, !dbg !2364

Then1.i:                                          ; preds = %Case.i
  %42 = inttoptr i64 %9 to ptr, !dbg !2292
  %sunkaddr48 = inttoptr i64 %9 to ptr, !dbg !2365
  %sunkaddr49 = getelementptr inbounds i8, ptr %sunkaddr48, i64 16, !dbg !2365
  store i64 0, ptr %sunkaddr49, align 8, !dbg !2365, !noalias !2297
  %43 = call fastcc i16 @Io.File.Writer.seekTo(ptr nonnull align 8 %42, i64 %37), !dbg !2367, !noalias !2297
  %44 = icmp eq i16 %43, 0, !dbg !2367
  br i1 %44, label %Block1.i, label %Else2.i, !dbg !2367

Else2.i:                                          ; preds = %Then1.i
  %sunkaddr50 = inttoptr i64 %9 to ptr, !dbg !2369
  %sunkaddr51 = getelementptr inbounds i8, ptr %sunkaddr50, i64 70, !dbg !2369
  store i3 -4, ptr %sunkaddr51, align 2, !dbg !2369, !noalias !2297
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 2 dereferenceable(6) %.sroa.10, ptr noundef nonnull align 2 dereferenceable(6) getelementptr inbounds nuw (i8, ptr @__anon_3950, i64 10), i64 6, i1 false), !dbg !2371
  br label %Io.File.Writer.sendFilePositional.exit, !dbg !2371

Io.File.Writer.sendFilePositional.exit:           ; preds = %Io.Writer.consume.exit.i, %Case1.i, %Case2.i, %Case3.i, %Case4.i, %Default.i, %Block1.i, %Else2.i
  %.sroa.0.0 = phi i64 [ undef, %Default.i ], [ %common.ret.op.i.i, %Io.Writer.consume.exit.i ], [ 0, %Block1.i ], [ undef, %Else2.i ], [ undef, %Case1.i ], [ undef, %Case2.i ], [ undef, %Case3.i ], [ undef, %Case4.i ], !dbg !2312
  %.sroa.9.0 = phi i16 [ 28, %Default.i ], [ 0, %Io.Writer.consume.exit.i ], [ 0, %Block1.i ], [ 28, %Else2.i ], [ 28, %Case1.i ], [ 20, %Case2.i ], [ 18, %Case3.i ], [ 21, %Case4.i ], !dbg !2312
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %4), !dbg !2312
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %5), !dbg !2312
  store i64 %.sroa.0.0, ptr %0, align 8, !dbg !2373
  %.sroa.9.0..sroa_idx = getelementptr inbounds nuw i8, ptr %0, i64 8, !dbg !2373
  store i16 %.sroa.9.0, ptr %.sroa.9.0..sroa_idx, align 8, !dbg !2373
  %.sroa.10.0..sroa_idx = getelementptr inbounds nuw i8, ptr %0, i64 10, !dbg !2373
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 2 dereferenceable(6) %.sroa.10.0..sroa_idx, ptr noundef nonnull align 2 dereferenceable(6) %.sroa.10, i64 6, i1 false), !dbg !2373
  br label %common.ret, !dbg !2373

Case1:                                            ; preds = %Entry
  tail call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %0, ptr noundef nonnull align 8 dereferenceable(16) @__anon_3942, i64 16, i1 false), !dbg !2374
  ret void, !dbg !2296

Case2:                                            ; preds = %Entry
  %45 = inttoptr i64 %9 to ptr, !dbg !2292
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %4), !dbg !2376
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %5), !dbg !2376
    #dbg_value(ptr %10, !2380, !DIExpression(), !2381)
    #dbg_value(ptr %2, !2382, !DIExpression(), !2381)
    #dbg_value(i64 %3, !2383, !DIExpression(), !2381)
  %.sroa.07.0.copyload.i = load ptr, ptr %45, align 8, !dbg !2376, !noalias !2384
    #dbg_value(ptr %.sroa.07.0.copyload.i, !2387, !DIExpression(DW_OP_LLVM_fragment, 0, 64), !2388)
  %.sroa.28.0..0..sroa_idx.i = getelementptr inbounds nuw i8, ptr %45, i64 8, !dbg !2376
  %.sroa.28.0.copyload.i = load ptr, ptr %.sroa.28.0..0..sroa_idx.i, align 8, !dbg !2376, !noalias !2384
    #dbg_value(ptr %.sroa.28.0.copyload.i, !2387, !DIExpression(DW_OP_LLVM_fragment, 64, 64), !2388)
  %46 = getelementptr i8, ptr %45, i64 32, !dbg !2389
  %.val.i1 = load ptr, ptr %46, align 8, !dbg !2389, !noalias !2384
  %47 = getelementptr i8, ptr %45, i64 48, !dbg !2389
  %.val13.i = load i64, ptr %47, align 8, !dbg !2389, !noalias !2384
    #dbg_value({ ptr, i64 } poison, !2390, !DIExpression(), !2389)
  %48 = getelementptr inbounds nuw i8, ptr %.sroa.28.0.copyload.i, i64 392, !dbg !2391
  %49 = load ptr, ptr %48, align 8, !dbg !2391, !noalias !2384
  %50 = getelementptr inbounds nuw i8, ptr %45, i64 56, !dbg !2392
  %51 = load i64, ptr %50, align 8, !dbg !2392, !noalias !2384
  store i64 %51, ptr %5, align 8, !dbg !2392, !noalias !2384
  call fastcc void %49(ptr nonnull sret({ i64, i16, [6 x i8] }) %4, ptr align 1 %.sroa.07.0.copyload.i, ptr nonnull readonly align 4 %5, ptr nonnull readonly align 1 %.val.i1, i64 %.val13.i, ptr nonnull align 1 %2, i64 %3) #9, !dbg !2391, !noalias !2384
  %52 = getelementptr inbounds nuw i8, ptr %4, i64 8, !dbg !2393
  %53 = load i16, ptr %52, align 8, !dbg !2393, !noalias !2384
  %54 = zext i16 %53 to i32, !dbg !2394
  switch i32 %54, label %Default.i13 [
    i32 0, label %Then.i6
    i32 17, label %Case.i5
    i32 20, label %Case1.i4
    i32 18, label %Case2.i3
    i32 21, label %Case3.i2
  ], !dbg !2394, !prof !2396

Then.i6:                                          ; preds = %Case2
  %55 = inttoptr i64 %9 to ptr, !dbg !2292
  %56 = load i64, ptr %4, align 8, !dbg !2397, !noalias !2384
    #dbg_value(i64 %56, !2400, !DIExpression(), !2401)
  %57 = getelementptr inbounds nuw i8, ptr %55, i64 16, !dbg !2403
  %58 = load i64, ptr %57, align 8, !dbg !2403, !noalias !2384
  %59 = add nuw i64 %58, %56, !dbg !2404
  store i64 %59, ptr %57, align 8, !dbg !2404, !noalias !2384
    #dbg_value(ptr %10, !2049, !DIExpression(DW_OP_plus_uconst, 24, DW_OP_stack_value), !2405)
    #dbg_value(i64 %56, !2055, !DIExpression(), !2405)
  %sunkaddr52 = inttoptr i64 %9 to ptr, !dbg !2407
  %sunkaddr53 = getelementptr i8, ptr %sunkaddr52, i64 48, !dbg !2407
  %60 = load i64, ptr %sunkaddr53, align 8, !dbg !2407, !noalias !2384
  %61 = icmp ult i64 %56, %60, !dbg !2407
  br i1 %61, label %Then.i.i11, label %Else.i.i7, !dbg !2407

Then.i.i11:                                       ; preds = %Then.i6
  %sunkaddr54 = inttoptr i64 %9 to ptr, !dbg !2408
  %sunkaddr55 = getelementptr i8, ptr %sunkaddr54, i64 32, !dbg !2408
  %.unpack.i.i12 = load ptr, ptr %sunkaddr55, align 8, !dbg !2408, !noalias !2384
  %62 = getelementptr inbounds [1 x i8], ptr %.unpack.i.i12, i64 %56, !dbg !2408
  %63 = sub nuw i64 %60, %56, !dbg !2408
    #dbg_value({ ptr, i64 } poison, !2060, !DIExpression(), !2408)
  call void @llvm.memmove.p0.p0.i64(ptr align 1 %.unpack.i.i12, ptr align 1 %62, i64 %63, i1 false), !dbg !2409, !noalias !2384
  br label %Io.Writer.consume.exit.i8, !dbg !2410

Else.i.i7:                                        ; preds = %Then.i6
  %64 = sub nuw i64 %56, %60, !dbg !2411
  br label %Io.Writer.consume.exit.i8, !dbg !2412

Io.Writer.consume.exit.i8:                        ; preds = %Else.i.i7, %Then.i.i11
  %storemerge.i.i9 = phi i64 [ 0, %Else.i.i7 ], [ %63, %Then.i.i11 ], !dbg !2413
  %common.ret.op.i.i10 = phi i64 [ %64, %Else.i.i7 ], [ 0, %Then.i.i11 ]
  %sunkaddr56 = inttoptr i64 %9 to ptr, !dbg !2413
  %sunkaddr57 = getelementptr i8, ptr %sunkaddr56, i64 48, !dbg !2413
  store i64 %storemerge.i.i9, ptr %sunkaddr57, align 8, !dbg !2413, !noalias !2384
  br label %Io.File.Writer.sendFileStreaming.exit, !dbg !2414

Case.i5:                                          ; preds = %Case2
  %65 = inttoptr i64 %9 to ptr, !dbg !2292
  %66 = getelementptr inbounds nuw i8, ptr %65, i64 64, !dbg !2415
  store i16 17, ptr %66, align 8, !dbg !2415, !noalias !2384
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 2 dereferenceable(6) %.sroa.8, ptr noundef nonnull align 2 dereferenceable(6) getelementptr inbounds nuw (i8, ptr @__anon_3950, i64 10), i64 6, i1 false), !dbg !2417
  br label %Io.File.Writer.sendFileStreaming.exit, !dbg !2417

Case1.i4:                                         ; preds = %Case2
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 2 dereferenceable(6) %.sroa.8, ptr noundef nonnull align 2 dereferenceable(6) getelementptr inbounds nuw (i8, ptr @__anon_3966, i64 10), i64 6, i1 false), !dbg !2418
  br label %Io.File.Writer.sendFileStreaming.exit, !dbg !2418

Case2.i3:                                         ; preds = %Case2
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 2 dereferenceable(6) %.sroa.8, ptr noundef nonnull align 2 dereferenceable(6) getelementptr inbounds nuw (i8, ptr @__anon_3942, i64 10), i64 6, i1 false), !dbg !2420
  br label %Io.File.Writer.sendFileStreaming.exit, !dbg !2420

Case3.i2:                                         ; preds = %Case2
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 2 dereferenceable(6) %.sroa.8, ptr noundef nonnull align 2 dereferenceable(6) getelementptr inbounds nuw (i8, ptr @__anon_3968, i64 10), i64 6, i1 false), !dbg !2422
  br label %Io.File.Writer.sendFileStreaming.exit, !dbg !2422

Default.i13:                                      ; preds = %Case2
  %67 = inttoptr i64 %9 to ptr, !dbg !2292
    #dbg_value(i16 %53, !2424, !DIExpression(), !2425)
  %68 = getelementptr inbounds nuw i8, ptr %67, i64 66, !dbg !2426
  store i16 %53, ptr %68, align 2, !dbg !2426, !noalias !2384
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 2 dereferenceable(6) %.sroa.8, ptr noundef nonnull align 2 dereferenceable(6) getelementptr inbounds nuw (i8, ptr @__anon_3950, i64 10), i64 6, i1 false), !dbg !2427
  br label %Io.File.Writer.sendFileStreaming.exit, !dbg !2427

Io.File.Writer.sendFileStreaming.exit:            ; preds = %Io.Writer.consume.exit.i8, %Case.i5, %Case1.i4, %Case2.i3, %Case3.i2, %Default.i13
  %.sroa.7.0 = phi i16 [ 28, %Default.i13 ], [ 0, %Io.Writer.consume.exit.i8 ], [ 28, %Case.i5 ], [ 20, %Case1.i4 ], [ 18, %Case2.i3 ], [ 21, %Case3.i2 ], !dbg !2388
  %.sroa.026.0 = phi i64 [ undef, %Default.i13 ], [ %common.ret.op.i.i10, %Io.Writer.consume.exit.i8 ], [ undef, %Case.i5 ], [ undef, %Case1.i4 ], [ undef, %Case2.i3 ], [ undef, %Case3.i2 ], !dbg !2388
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %4), !dbg !2388
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %5), !dbg !2388
  store i64 %.sroa.026.0, ptr %0, align 8, !dbg !2429
  %.sroa.7.0..sroa_idx = getelementptr inbounds nuw i8, ptr %0, i64 8, !dbg !2429
  store i16 %.sroa.7.0, ptr %.sroa.7.0..sroa_idx, align 8, !dbg !2429
  %.sroa.8.0..sroa_idx = getelementptr inbounds nuw i8, ptr %0, i64 10, !dbg !2429
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 2 dereferenceable(6) %.sroa.8.0..sroa_idx, ptr noundef nonnull align 2 dereferenceable(6) %.sroa.8, i64 6, i1 false), !dbg !2429
  br label %common.ret, !dbg !2429

Case3:                                            ; preds = %Entry
  tail call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %0, ptr noundef nonnull align 8 dereferenceable(16) @__anon_3942, i64 16, i1 false), !dbg !2430
  ret void, !dbg !2296

Case4:                                            ; preds = %Entry
  tail call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(16) %0, ptr noundef nonnull align 8 dereferenceable(16) @__anon_3950, i64 16, i1 false), !dbg !2432
  ret void, !dbg !2296

Default:                                          ; preds = %Entry
  unreachable, !dbg !2434
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable
define internal fastcc noalias noundef ptr @mem.Allocator.noAlloc(ptr nonnull readnone align 1 captures(none) %0, i64 %1, i6 %2, i64 %3) unnamed_addr #4 align 4 !dbg !2436 {
Entry:
    #dbg_value(ptr poison, !2437, !DIExpression(), !2438)
    #dbg_value(i64 poison, !2439, !DIExpression(), !2438)
    #dbg_value(i6 poison, !2440, !DIExpression(), !2438)
    #dbg_value(i64 poison, !2441, !DIExpression(), !2438)
  ret ptr null, !dbg !2442
}

; Function Attrs: mustprogress nofree norecurse noreturn nosync nounwind willreturn memory(none) uwtable
define internal fastcc void @mem.Allocator.unreachableFree(ptr nonnull readnone align 1 captures(none) %0, ptr nonnull readnone align 1 captures(none) %1, i64 %2, i6 %3, i64 %4) unnamed_addr #5 align 4 !dbg !2443 {
Entry:
  unreachable, !dbg !2444
}

; Function Attrs: mustprogress nofree norecurse noreturn nosync nounwind willreturn memory(none) uwtable
define internal fastcc noalias noundef nonnull ptr @mem.Allocator.unreachableRemap(ptr nonnull readnone align 1 captures(none) %0, ptr nonnull readnone align 1 captures(none) %1, i64 %2, i6 %3, i64 %4, i64 %5) unnamed_addr #5 align 4 !dbg !2445 {
Entry:
  unreachable, !dbg !2446
}

; Function Attrs: mustprogress nofree norecurse noreturn nosync nounwind willreturn memory(none) uwtable
define internal fastcc noundef i1 @mem.Allocator.unreachableResize(ptr nonnull readnone align 1 captures(none) %0, ptr nonnull readnone align 1 captures(none) %1, i64 %2, i6 %3, i64 %4, i64 %5) unnamed_addr #5 align 4 !dbg !2447 {
Entry:
  unreachable, !dbg !2448
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr captures(none)) #6

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr captures(none)) #6

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr writeonly captures(none), i8, i64, i1 immarg) #7

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.experimental.noalias.scope.decl(metadata) #8

attributes #0 = { nounwind uwtable "frame-pointer"="all" "target-cpu"="apple-m1" "target-features"="+aes,+aggressive-fma,+alternate-sextload-cvt-f32-pattern,+altnzcv,+am,+arith-bcc-fusion,+arith-cbz-fusion,+ccdp,+ccidx,+ccpp,+complxnum,+CONTEXTIDREL2,+crc,+disable-latency-sched-heuristic,+dit,+dotprod,+el2vmsa,+el3,+flagm,+fp16fml,+fp-armv8,+fptoint,+fullfp16,+fuse-address,+fuse-aes,+fuse-arith-logic,+fuse-crypto-eor,+fuse-csel,+fuse-literals,+jsconv,+lor,+lse,+lse2,+mpam,+neon,+nv,+pan,+pan-rwv,+pauth,+perfmon,+predres,+ras,+rcpc,+rcpc-immo,+rdm,+sb,+sel2,+sha2,+sha3,+specrestrict,+ssbs,+store-pair-suppress,+tlb-rmi,+tracev8.4,+uaops,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+vh,+zcm-fpr64,+zcm-gpr64,+zcz,+zcz-gp,-a320,-addr-lsl-slow-14,-alu-lsl-fast,-amvs,-ascend-store-address,-avoid-ldapur,-balance-fp-ops,-bf16,-brbe,-bti,-call-saved-x10,-call-saved-x11,-call-saved-x12,-call-saved-x13,-call-saved-x14,-call-saved-x15,-call-saved-x18,-call-saved-x8,-call-saved-x9,-chk,-clrbhb,-cmp-bcc-fusion,-cmpbr,-cpa,-crypto,-cssc,-d128,-disable-fast-inc-vl,-disable-ldp,-disable-stp,-ecv,-enable-select-opt,-ete,-execute-only,-exynos-cheap-as-move,-f32mm,-f64mm,-f8f16mm,-f8f32mm,-faminmax,-fgt,-fix-cortex-a53-835769,-fmv,-force-32bit-jump-tables,-fp8,-fp8dot2,-fp8dot4,-fp8fma,-fpac,-fprcvt,-fujitsu-monaka,-fuse-addsub-2reg-const1,-fuse-adrp-add,-gcs,-harden-sls-blr,-harden-sls-nocomdat,-harden-sls-retbr,-hbc,-hcx,-i8mm,-ite,-ldp-aligned-only,-ls64,-lse128,-lsfe,-lsui,-lut,-mec,-mops,-mte,-nmi,-no-bti-at-return-twice,-no-neg-immediates,-no-sve-fp-ld1r,-no-zcz-fp,-occmo,-olympus,-outline-atomics,-pauth-lr,-pcdphint,-pops,-predictable-select-expensive,-prfm-slc-target,-rand,-rasv2,-rcpc3,-reserve-lr-for-ra,-reserve-x1,-reserve-x10,-reserve-x11,-reserve-x12,-reserve-x13,-reserve-x14,-reserve-x15,-reserve-x18,-reserve-x2,-reserve-x20,-reserve-x21,-reserve-x22,-reserve-x23,-reserve-x24,-reserve-x25,-reserve-x26,-reserve-x27,-reserve-x28,-reserve-x3,-reserve-x4,-reserve-x5,-reserve-x6,-reserve-x7,-reserve-x9,-rme,-slow-misaligned-128store,-slow-paired-128,-slow-strqro-store,-sm4,-sme,-sme2,-sme2p1,-sme2p2,-sme-b16b16,-sme-f16f16,-sme-f64f64,-sme-f8f16,-sme-f8f32,-sme-fa64,-sme-i16i64,-sme-lutv2,-sme-mop4,-sme-tmop,-spe,-spe-eef,-specres2,-ssve-aes,-ssve-bitperm,-ssve-fexpa,-ssve-fp8dot2,-ssve-fp8dot4,-ssve-fp8fma,-stp-aligned-only,-strict-align,-sve,-sve2,-sve2-aes,-sve2-bitperm,-sve2-sha3,-sve2-sm4,-sve2p1,-sve2p2,-sve-aes,-sve-aes2,-sve-b16b16,-sve-bfscale,-sve-bitperm,-sve-f16f32mm,-sve-sha3,-sve-sm4,-tagged-globals,-the,-tlbiw,-tme,-tpidr-el1,-tpidr-el2,-tpidr-el3,-tpidrro-el0,-trbe,-use-experimental-zeroing-pseudos,-use-fixed-over-scalable-if-equal-cost,-use-postra-scheduler,-use-reciprocal-square-root,-v8.5a,-v8.6a,-v8.7a,-v8.8a,-v8.9a,-v8r,-v9.1a,-v9.2a,-v9.3a,-v9.4a,-v9.5a,-v9.6a,-v9a,-wfxt,-xs,-zcm-fpr32,-zcm-gpr32,-zcz-fp-workaround" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable "frame-pointer"="all" "target-cpu"="apple-m1" "target-features"="+aes,+aggressive-fma,+alternate-sextload-cvt-f32-pattern,+altnzcv,+am,+arith-bcc-fusion,+arith-cbz-fusion,+ccdp,+ccidx,+ccpp,+complxnum,+CONTEXTIDREL2,+crc,+disable-latency-sched-heuristic,+dit,+dotprod,+el2vmsa,+el3,+flagm,+fp16fml,+fp-armv8,+fptoint,+fullfp16,+fuse-address,+fuse-aes,+fuse-arith-logic,+fuse-crypto-eor,+fuse-csel,+fuse-literals,+jsconv,+lor,+lse,+lse2,+mpam,+neon,+nv,+pan,+pan-rwv,+pauth,+perfmon,+predres,+ras,+rcpc,+rcpc-immo,+rdm,+sb,+sel2,+sha2,+sha3,+specrestrict,+ssbs,+store-pair-suppress,+tlb-rmi,+tracev8.4,+uaops,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+vh,+zcm-fpr64,+zcm-gpr64,+zcz,+zcz-gp,-a320,-addr-lsl-slow-14,-alu-lsl-fast,-amvs,-ascend-store-address,-avoid-ldapur,-balance-fp-ops,-bf16,-brbe,-bti,-call-saved-x10,-call-saved-x11,-call-saved-x12,-call-saved-x13,-call-saved-x14,-call-saved-x15,-call-saved-x18,-call-saved-x8,-call-saved-x9,-chk,-clrbhb,-cmp-bcc-fusion,-cmpbr,-cpa,-crypto,-cssc,-d128,-disable-fast-inc-vl,-disable-ldp,-disable-stp,-ecv,-enable-select-opt,-ete,-execute-only,-exynos-cheap-as-move,-f32mm,-f64mm,-f8f16mm,-f8f32mm,-faminmax,-fgt,-fix-cortex-a53-835769,-fmv,-force-32bit-jump-tables,-fp8,-fp8dot2,-fp8dot4,-fp8fma,-fpac,-fprcvt,-fujitsu-monaka,-fuse-addsub-2reg-const1,-fuse-adrp-add,-gcs,-harden-sls-blr,-harden-sls-nocomdat,-harden-sls-retbr,-hbc,-hcx,-i8mm,-ite,-ldp-aligned-only,-ls64,-lse128,-lsfe,-lsui,-lut,-mec,-mops,-mte,-nmi,-no-bti-at-return-twice,-no-neg-immediates,-no-sve-fp-ld1r,-no-zcz-fp,-occmo,-olympus,-outline-atomics,-pauth-lr,-pcdphint,-pops,-predictable-select-expensive,-prfm-slc-target,-rand,-rasv2,-rcpc3,-reserve-lr-for-ra,-reserve-x1,-reserve-x10,-reserve-x11,-reserve-x12,-reserve-x13,-reserve-x14,-reserve-x15,-reserve-x18,-reserve-x2,-reserve-x20,-reserve-x21,-reserve-x22,-reserve-x23,-reserve-x24,-reserve-x25,-reserve-x26,-reserve-x27,-reserve-x28,-reserve-x3,-reserve-x4,-reserve-x5,-reserve-x6,-reserve-x7,-reserve-x9,-rme,-slow-misaligned-128store,-slow-paired-128,-slow-strqro-store,-sm4,-sme,-sme2,-sme2p1,-sme2p2,-sme-b16b16,-sme-f16f16,-sme-f64f64,-sme-f8f16,-sme-f8f32,-sme-fa64,-sme-i16i64,-sme-lutv2,-sme-mop4,-sme-tmop,-spe,-spe-eef,-specres2,-ssve-aes,-ssve-bitperm,-ssve-fexpa,-ssve-fp8dot2,-ssve-fp8dot4,-ssve-fp8fma,-stp-aligned-only,-strict-align,-sve,-sve2,-sve2-aes,-sve2-bitperm,-sve2-sha3,-sve2-sm4,-sve2p1,-sve2p2,-sve-aes,-sve-aes2,-sve-b16b16,-sve-bfscale,-sve-bitperm,-sve-f16f32mm,-sve-sha3,-sve-sm4,-tagged-globals,-the,-tlbiw,-tme,-tpidr-el1,-tpidr-el2,-tpidr-el3,-tpidrro-el0,-trbe,-use-experimental-zeroing-pseudos,-use-fixed-over-scalable-if-equal-cost,-use-postra-scheduler,-use-reciprocal-square-root,-v8.5a,-v8.6a,-v8.7a,-v8.8a,-v8.9a,-v8r,-v9.1a,-v9.2a,-v9.3a,-v9.4a,-v9.5a,-v9.6a,-v9a,-wfxt,-xs,-zcm-fpr32,-zcm-gpr32,-zcz-fp-workaround" }
attributes #5 = { mustprogress nofree norecurse noreturn nosync nounwind willreturn memory(none) uwtable "frame-pointer"="all" "target-cpu"="apple-m1" "target-features"="+aes,+aggressive-fma,+alternate-sextload-cvt-f32-pattern,+altnzcv,+am,+arith-bcc-fusion,+arith-cbz-fusion,+ccdp,+ccidx,+ccpp,+complxnum,+CONTEXTIDREL2,+crc,+disable-latency-sched-heuristic,+dit,+dotprod,+el2vmsa,+el3,+flagm,+fp16fml,+fp-armv8,+fptoint,+fullfp16,+fuse-address,+fuse-aes,+fuse-arith-logic,+fuse-crypto-eor,+fuse-csel,+fuse-literals,+jsconv,+lor,+lse,+lse2,+mpam,+neon,+nv,+pan,+pan-rwv,+pauth,+perfmon,+predres,+ras,+rcpc,+rcpc-immo,+rdm,+sb,+sel2,+sha2,+sha3,+specrestrict,+ssbs,+store-pair-suppress,+tlb-rmi,+tracev8.4,+uaops,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+vh,+zcm-fpr64,+zcm-gpr64,+zcz,+zcz-gp,-a320,-addr-lsl-slow-14,-alu-lsl-fast,-amvs,-ascend-store-address,-avoid-ldapur,-balance-fp-ops,-bf16,-brbe,-bti,-call-saved-x10,-call-saved-x11,-call-saved-x12,-call-saved-x13,-call-saved-x14,-call-saved-x15,-call-saved-x18,-call-saved-x8,-call-saved-x9,-chk,-clrbhb,-cmp-bcc-fusion,-cmpbr,-cpa,-crypto,-cssc,-d128,-disable-fast-inc-vl,-disable-ldp,-disable-stp,-ecv,-enable-select-opt,-ete,-execute-only,-exynos-cheap-as-move,-f32mm,-f64mm,-f8f16mm,-f8f32mm,-faminmax,-fgt,-fix-cortex-a53-835769,-fmv,-force-32bit-jump-tables,-fp8,-fp8dot2,-fp8dot4,-fp8fma,-fpac,-fprcvt,-fujitsu-monaka,-fuse-addsub-2reg-const1,-fuse-adrp-add,-gcs,-harden-sls-blr,-harden-sls-nocomdat,-harden-sls-retbr,-hbc,-hcx,-i8mm,-ite,-ldp-aligned-only,-ls64,-lse128,-lsfe,-lsui,-lut,-mec,-mops,-mte,-nmi,-no-bti-at-return-twice,-no-neg-immediates,-no-sve-fp-ld1r,-no-zcz-fp,-occmo,-olympus,-outline-atomics,-pauth-lr,-pcdphint,-pops,-predictable-select-expensive,-prfm-slc-target,-rand,-rasv2,-rcpc3,-reserve-lr-for-ra,-reserve-x1,-reserve-x10,-reserve-x11,-reserve-x12,-reserve-x13,-reserve-x14,-reserve-x15,-reserve-x18,-reserve-x2,-reserve-x20,-reserve-x21,-reserve-x22,-reserve-x23,-reserve-x24,-reserve-x25,-reserve-x26,-reserve-x27,-reserve-x28,-reserve-x3,-reserve-x4,-reserve-x5,-reserve-x6,-reserve-x7,-reserve-x9,-rme,-slow-misaligned-128store,-slow-paired-128,-slow-strqro-store,-sm4,-sme,-sme2,-sme2p1,-sme2p2,-sme-b16b16,-sme-f16f16,-sme-f64f64,-sme-f8f16,-sme-f8f32,-sme-fa64,-sme-i16i64,-sme-lutv2,-sme-mop4,-sme-tmop,-spe,-spe-eef,-specres2,-ssve-aes,-ssve-bitperm,-ssve-fexpa,-ssve-fp8dot2,-ssve-fp8dot4,-ssve-fp8fma,-stp-aligned-only,-strict-align,-sve,-sve2,-sve2-aes,-sve2-bitperm,-sve2-sha3,-sve2-sm4,-sve2p1,-sve2p2,-sve-aes,-sve-aes2,-sve-b16b16,-sve-bfscale,-sve-bitperm,-sve-f16f32mm,-sve-sha3,-sve-sm4,-tagged-globals,-the,-tlbiw,-tme,-tpidr-el1,-tpidr-el2,-tpidr-el3,-tpidrro-el0,-trbe,-use-experimental-zeroing-pseudos,-use-fixed-over-scalable-if-equal-cost,-use-postra-scheduler,-use-reciprocal-square-root,-v8.5a,-v8.6a,-v8.7a,-v8.8a,-v8.9a,-v8r,-v9.1a,-v9.2a,-v9.3a,-v9.4a,-v9.5a,-v9.6a,-v9a,-wfxt,-xs,-zcm-fpr32,-zcm-gpr32,-zcz-fp-workaround" }
attributes #6 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #7 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #8 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
attributes #9 = { nounwind }

!llvm.dbg.cu = !{!4}
!llvm.module.flags = !{!1902, !1903, !1904}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "signal_stack", linkageName: "Thread.maybeAttachSignalStack.global.signal_stack", scope: !2, file: !2, line: 1734, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "Thread.zig", directory: "/Users/sulky/.zvm/master/lib/std")
!3 = !DICompositeType(tag: DW_TAG_array_type, name: "[262144]u8", scope: !4, baseType: !116, size: 2097152, align: 8, elements: !1900)
!4 = distinct !DICompileUnit(language: DW_LANG_C99, file: !5, producer: "zig 0.16.0", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !6, globals: !950, splitDebugInlining: false)
!5 = !DIFile(filename: "scratch2", directory: "/Users/sulky/Downloads/off_proj/sem_iii/muze")
!6 = !{!7, !13, !23, !24, !38, !72, !77, !82, !91, !209, !376, !357, !325, !302, !281, !266, !500, !511, !133, !541, !625, !630, !637, !644, !650, !760, !835, !845}
!7 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "Io.Threaded.UseSendfile__enum_2114", scope: !8, file: !8, line: 406, baseType: !9, size: 8, align: 8, elements: !10)
!8 = !DIFile(filename: "Threaded.zig", directory: "/Users/sulky/.zvm/master/lib/std/Io")
!9 = !DIBasicType(name: "u1", size: 8, encoding: DW_ATE_unsigned)
!10 = !{!11, !12}
!11 = !DIEnumerator(name: "enabled", value: 0, isUnsigned: true)
!12 = !DIEnumerator(name: "disabled", value: 1, isUnsigned: true)
!13 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "@typeInfo(Io.Terminal.Mode).@\22union\22.tag_type.?", scope: !15, file: !14, line: 80, baseType: !18, size: 8, align: 8, elements: !19)
!14 = !DIFile(filename: "Terminal.zig", directory: "/Users/sulky/.zvm/master/lib/std/Io")
!15 = !DICompositeType(tag: DW_TAG_structure_type, name: "Io.Terminal.Mode", scope: !14, file: !14, line: 80, size: 8, align: 8, elements: !16)
!16 = !{!17}
!17 = !DIDerivedType(tag: DW_TAG_member, name: "tag", scope: !15, baseType: !13, size: 8, align: 8)
!18 = !DIBasicType(name: "u2", size: 8, encoding: DW_ATE_unsigned)
!19 = !{!20, !21, !22}
!20 = !DIEnumerator(name: "no_color", value: 0, isUnsigned: true)
!21 = !DIEnumerator(name: "escape_codes", value: 1, isUnsigned: true)
!22 = !DIEnumerator(name: "windows_api", value: 2, isUnsigned: true)
!23 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "Io.Threaded.UseFcopyfile__enum_2121", scope: !8, file: !8, line: 424, baseType: !9, size: 8, align: 8, elements: !10)
!24 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "Io.Mutex.State", scope: !26, file: !25, line: 1592, baseType: !33, size: 32, align: 32, elements: !34)
!25 = !DIFile(filename: "Io.zig", directory: "/Users/sulky/.zvm/master/lib/std")
!26 = !DICompositeType(tag: DW_TAG_structure_type, name: "Io.Mutex", scope: !25, file: !25, line: 1650, size: 32, align: 32, elements: !27)
!27 = !{!28}
!28 = !DIDerivedType(tag: DW_TAG_member, name: "state", scope: !26, baseType: !29, size: 32, align: 32)
!29 = !DICompositeType(tag: DW_TAG_structure_type, name: "atomic.Value(Io.Mutex.State)", scope: !30, file: !30, line: 120, size: 32, align: 32, elements: !31)
!30 = !DIFile(filename: "atomic.zig", directory: "/Users/sulky/.zvm/master/lib/std")
!31 = !{!32}
!32 = !DIDerivedType(tag: DW_TAG_member, name: "raw", scope: !29, baseType: !24, size: 32, align: 32)
!33 = !DIBasicType(name: "u32", size: 32, encoding: DW_ATE_unsigned)
!34 = !{!35, !36, !37}
!35 = !DIEnumerator(name: "unlocked", value: 0, isUnsigned: true)
!36 = !DIEnumerator(name: "locked_once", value: 1, isUnsigned: true)
!37 = !DIEnumerator(name: "contended", value: 2, isUnsigned: true)
!38 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "c.SIG__enum_2017", scope: !39, file: !39, line: 2661, baseType: !33, size: 32, align: 32, elements: !40)
!39 = !DIFile(filename: "c.zig", directory: "/Users/sulky/.zvm/master/lib/std")
!40 = !{!41, !42, !43, !44, !45, !46, !47, !48, !49, !50, !51, !52, !53, !54, !55, !56, !57, !58, !59, !60, !61, !62, !63, !64, !65, !66, !67, !68, !69, !70, !71}
!41 = !DIEnumerator(name: "HUP", value: 1, isUnsigned: true)
!42 = !DIEnumerator(name: "INT", value: 2, isUnsigned: true)
!43 = !DIEnumerator(name: "QUIT", value: 3, isUnsigned: true)
!44 = !DIEnumerator(name: "ILL", value: 4, isUnsigned: true)
!45 = !DIEnumerator(name: "TRAP", value: 5, isUnsigned: true)
!46 = !DIEnumerator(name: "ABRT", value: 6, isUnsigned: true)
!47 = !DIEnumerator(name: "EMT", value: 7, isUnsigned: true)
!48 = !DIEnumerator(name: "FPE", value: 8, isUnsigned: true)
!49 = !DIEnumerator(name: "KILL", value: 9, isUnsigned: true)
!50 = !DIEnumerator(name: "BUS", value: 10, isUnsigned: true)
!51 = !DIEnumerator(name: "SEGV", value: 11, isUnsigned: true)
!52 = !DIEnumerator(name: "SYS", value: 12, isUnsigned: true)
!53 = !DIEnumerator(name: "PIPE", value: 13, isUnsigned: true)
!54 = !DIEnumerator(name: "ALRM", value: 14, isUnsigned: true)
!55 = !DIEnumerator(name: "TERM", value: 15, isUnsigned: true)
!56 = !DIEnumerator(name: "URG", value: 16, isUnsigned: true)
!57 = !DIEnumerator(name: "STOP", value: 17, isUnsigned: true)
!58 = !DIEnumerator(name: "TSTP", value: 18, isUnsigned: true)
!59 = !DIEnumerator(name: "CONT", value: 19, isUnsigned: true)
!60 = !DIEnumerator(name: "CHLD", value: 20, isUnsigned: true)
!61 = !DIEnumerator(name: "TTIN", value: 21, isUnsigned: true)
!62 = !DIEnumerator(name: "TTOU", value: 22, isUnsigned: true)
!63 = !DIEnumerator(name: "IO", value: 23, isUnsigned: true)
!64 = !DIEnumerator(name: "XCPU", value: 24, isUnsigned: true)
!65 = !DIEnumerator(name: "XFSZ", value: 25, isUnsigned: true)
!66 = !DIEnumerator(name: "VTALRM", value: 26, isUnsigned: true)
!67 = !DIEnumerator(name: "PROF", value: 27, isUnsigned: true)
!68 = !DIEnumerator(name: "WINCH", value: 28, isUnsigned: true)
!69 = !DIEnumerator(name: "INFO", value: 29, isUnsigned: true)
!70 = !DIEnumerator(name: "USR1", value: 30, isUnsigned: true)
!71 = !DIEnumerator(name: "USR2", value: 31, isUnsigned: true)
!72 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "Io.Limit", scope: !25, file: !25, line: 701, baseType: !73, size: 64, align: 64, elements: !74)
!73 = !DIBasicType(name: "usize", size: 64, encoding: DW_ATE_unsigned)
!74 = !{!75, !76}
!75 = !DIEnumerator(name: "nothing", value: 0, isUnsigned: true)
!76 = !DIEnumerator(name: "unlimited", value: 18446744073709551615, isUnsigned: true)
!77 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "Io.Event", scope: !25, file: !25, line: 1869, baseType: !33, size: 32, align: 32, elements: !78)
!78 = !{!79, !80, !81}
!79 = !DIEnumerator(name: "unset", value: 0, isUnsigned: true)
!80 = !DIEnumerator(name: "waiting", value: 1, isUnsigned: true)
!81 = !DIEnumerator(name: "is_set", value: 2, isUnsigned: true)
!82 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "Io.File.Reader.Mode", scope: !83, file: !83, line: 68, baseType: !84, size: 8, align: 8, elements: !85)
!83 = !DIFile(filename: "Reader.zig", directory: "/Users/sulky/.zvm/master/lib/std/Io/File")
!84 = !DIBasicType(name: "u3", size: 8, encoding: DW_ATE_unsigned)
!85 = !{!86, !87, !88, !89, !90}
!86 = !DIEnumerator(name: "streaming", value: 0, isUnsigned: true)
!87 = !DIEnumerator(name: "positional", value: 1, isUnsigned: true)
!88 = !DIEnumerator(name: "streaming_simple", value: 2, isUnsigned: true)
!89 = !DIEnumerator(name: "positional_simple", value: 3, isUnsigned: true)
!90 = !DIEnumerator(name: "failure", value: 4, isUnsigned: true)
!91 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "Target.Os.Tag", scope: !93, file: !92, line: 217, baseType: !165, size: 8, align: 8, elements: !166)
!92 = !DIFile(filename: "Target.zig", directory: "/Users/sulky/.zvm/master/lib/std")
!93 = !DICompositeType(tag: DW_TAG_structure_type, name: "Target.Os", scope: !92, file: !92, line: 726, size: 1472, align: 64, elements: !94)
!94 = !{!95, !164}
!95 = !DIDerivedType(tag: DW_TAG_member, name: "version_range", scope: !93, baseType: !96, size: 1408, align: 64)
!96 = !DICompositeType(tag: DW_TAG_union_type, name: "Target.Os.VersionRange", scope: !93, file: !92, line: 680, size: 1408, align: 64, elements: !97)
!97 = !{!98, !100, !120, !125, !131}
!98 = !DIDerivedType(tag: DW_TAG_member, name: "none", scope: !96, baseType: !99)
!99 = !DIBasicType(name: "void", encoding: DW_ATE_signed)
!100 = !DIDerivedType(tag: DW_TAG_member, name: "semver", scope: !96, baseType: !101, size: 896)
!101 = !DICompositeType(tag: DW_TAG_structure_type, name: "SemanticVersion.Range", scope: !102, file: !102, line: 30, size: 896, align: 64, elements: !103)
!102 = !DIFile(filename: "SemanticVersion.zig", directory: "/Users/sulky/.zvm/master/lib/std")
!103 = !{!104, !119}
!104 = !DIDerivedType(tag: DW_TAG_member, name: "min", scope: !101, baseType: !105, size: 448, align: 64)
!105 = !DICompositeType(tag: DW_TAG_structure_type, name: "SemanticVersion", scope: !102, file: !102, line: 300, size: 448, align: 64, elements: !106)
!106 = !{!107, !108, !109, !110, !118}
!107 = !DIDerivedType(tag: DW_TAG_member, name: "major", scope: !105, baseType: !73, size: 64, align: 64)
!108 = !DIDerivedType(tag: DW_TAG_member, name: "minor", scope: !105, baseType: !73, size: 64, align: 64, offset: 64)
!109 = !DIDerivedType(tag: DW_TAG_member, name: "patch", scope: !105, baseType: !73, size: 64, align: 64, offset: 128)
!110 = !DIDerivedType(tag: DW_TAG_member, name: "pre", scope: !105, baseType: !111, size: 128, align: 64, offset: 192)
!111 = !DIDerivedType(tag: DW_TAG_typedef, name: "?[]const u8", scope: !4, baseType: !112, size: 128, align: 64)
!112 = !DICompositeType(tag: DW_TAG_structure_type, name: "[]const u8", scope: !4, size: 128, align: 64, elements: !113)
!113 = !{!114, !117}
!114 = !DIDerivedType(tag: DW_TAG_member, name: "ptr", scope: !112, baseType: !115, size: 64, align: 64)
!115 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "[*]const u8", scope: !4, baseType: !116, size: 64, align: 64)
!116 = !DIBasicType(name: "u8", size: 8, encoding: DW_ATE_unsigned)
!117 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !112, baseType: !73, size: 64, align: 64, offset: 64)
!118 = !DIDerivedType(tag: DW_TAG_member, name: "build", scope: !105, baseType: !111, size: 128, align: 64, offset: 320)
!119 = !DIDerivedType(tag: DW_TAG_member, name: "max", scope: !101, baseType: !105, size: 448, align: 64, offset: 448)
!120 = !DIDerivedType(tag: DW_TAG_member, name: "hurd", scope: !96, baseType: !121, size: 1344)
!121 = !DICompositeType(tag: DW_TAG_structure_type, name: "Target.Os.HurdVersionRange", scope: !93, file: !92, line: 330, size: 1344, align: 64, elements: !122)
!122 = !{!123, !124}
!123 = !DIDerivedType(tag: DW_TAG_member, name: "range", scope: !121, baseType: !101, size: 896, align: 64)
!124 = !DIDerivedType(tag: DW_TAG_member, name: "glibc", scope: !121, baseType: !105, size: 448, align: 64, offset: 896)
!125 = !DIDerivedType(tag: DW_TAG_member, name: "linux", scope: !96, baseType: !126, size: 1408)
!126 = !DICompositeType(tag: DW_TAG_structure_type, name: "Target.Os.LinuxVersionRange", scope: !93, file: !92, line: 347, size: 1408, align: 64, elements: !127)
!127 = !{!128, !129, !130}
!128 = !DIDerivedType(tag: DW_TAG_member, name: "range", scope: !126, baseType: !101, size: 896, align: 64)
!129 = !DIDerivedType(tag: DW_TAG_member, name: "glibc", scope: !126, baseType: !105, size: 448, align: 64, offset: 896)
!130 = !DIDerivedType(tag: DW_TAG_member, name: "android", scope: !126, baseType: !33, size: 32, align: 32, offset: 1344)
!131 = !DIDerivedType(tag: DW_TAG_member, name: "windows", scope: !96, baseType: !132, size: 64)
!132 = !DICompositeType(tag: DW_TAG_structure_type, name: "Target.Os.WindowsVersion.Range", scope: !133, file: !92, line: 297, size: 64, align: 32, elements: !161)
!133 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "Target.Os.WindowsVersion", scope: !93, file: !92, line: 315, baseType: !33, size: 32, align: 32, elements: !134)
!134 = !{!135, !136, !137, !138, !139, !140, !141, !142, !143, !144, !145, !146, !147, !148, !149, !150, !151, !152, !153, !154, !155, !156, !157, !158, !159, !160}
!135 = !DIEnumerator(name: "nt4", value: 67108864, isUnsigned: true)
!136 = !DIEnumerator(name: "win2k", value: 83886080, isUnsigned: true)
!137 = !DIEnumerator(name: "xp", value: 83951616, isUnsigned: true)
!138 = !DIEnumerator(name: "ws2003", value: 84017152, isUnsigned: true)
!139 = !DIEnumerator(name: "vista", value: 100663296, isUnsigned: true)
!140 = !DIEnumerator(name: "win7", value: 100728832, isUnsigned: true)
!141 = !DIEnumerator(name: "win8", value: 100794368, isUnsigned: true)
!142 = !DIEnumerator(name: "win8_1", value: 100859904, isUnsigned: true)
!143 = !DIEnumerator(name: "win10", value: 167772160, isUnsigned: true)
!144 = !DIEnumerator(name: "win10_th2", value: 167772161, isUnsigned: true)
!145 = !DIEnumerator(name: "win10_rs1", value: 167772162, isUnsigned: true)
!146 = !DIEnumerator(name: "win10_rs2", value: 167772163, isUnsigned: true)
!147 = !DIEnumerator(name: "win10_rs3", value: 167772164, isUnsigned: true)
!148 = !DIEnumerator(name: "win10_rs4", value: 167772165, isUnsigned: true)
!149 = !DIEnumerator(name: "win10_rs5", value: 167772166, isUnsigned: true)
!150 = !DIEnumerator(name: "win10_19h1", value: 167772167, isUnsigned: true)
!151 = !DIEnumerator(name: "win10_vb", value: 167772168, isUnsigned: true)
!152 = !DIEnumerator(name: "win10_mn", value: 167772169, isUnsigned: true)
!153 = !DIEnumerator(name: "win10_fe", value: 167772170, isUnsigned: true)
!154 = !DIEnumerator(name: "win10_co", value: 167772171, isUnsigned: true)
!155 = !DIEnumerator(name: "win10_ni", value: 167772172, isUnsigned: true)
!156 = !DIEnumerator(name: "win10_cu", value: 167772173, isUnsigned: true)
!157 = !DIEnumerator(name: "win11_zn", value: 167772174, isUnsigned: true)
!158 = !DIEnumerator(name: "win11_ga", value: 167772175, isUnsigned: true)
!159 = !DIEnumerator(name: "win11_ge", value: 167772176, isUnsigned: true)
!160 = !DIEnumerator(name: "win11_dt", value: 167772177, isUnsigned: true)
!161 = !{!162, !163}
!162 = !DIDerivedType(tag: DW_TAG_member, name: "min", scope: !132, baseType: !133, size: 32, align: 32)
!163 = !DIDerivedType(tag: DW_TAG_member, name: "max", scope: !132, baseType: !133, size: 32, align: 32, offset: 32)
!164 = !DIDerivedType(tag: DW_TAG_member, name: "tag", scope: !93, baseType: !91, size: 8, align: 8, offset: 1408)
!165 = !DIBasicType(name: "u6", size: 8, encoding: DW_ATE_unsigned)
!166 = !{!167, !168, !169, !170, !171, !172, !173, !174, !175, !176, !177, !178, !179, !180, !181, !182, !183, !184, !185, !186, !187, !188, !189, !190, !191, !192, !193, !194, !195, !196, !197, !198, !199, !200, !201, !202, !203, !204, !205, !206, !207, !208}
!167 = !DIEnumerator(name: "freestanding", value: 0, isUnsigned: true)
!168 = !DIEnumerator(name: "other", value: 1, isUnsigned: true)
!169 = !DIEnumerator(name: "contiki", value: 2, isUnsigned: true)
!170 = !DIEnumerator(name: "fuchsia", value: 3, isUnsigned: true)
!171 = !DIEnumerator(name: "hermit", value: 4, isUnsigned: true)
!172 = !DIEnumerator(name: "managarm", value: 5, isUnsigned: true)
!173 = !DIEnumerator(name: "haiku", value: 6, isUnsigned: true)
!174 = !DIEnumerator(name: "hurd", value: 7, isUnsigned: true)
!175 = !DIEnumerator(name: "illumos", value: 8, isUnsigned: true)
!176 = !DIEnumerator(name: "linux", value: 9, isUnsigned: true)
!177 = !DIEnumerator(name: "plan9", value: 10, isUnsigned: true)
!178 = !DIEnumerator(name: "rtems", value: 11, isUnsigned: true)
!179 = !DIEnumerator(name: "serenity", value: 12, isUnsigned: true)
!180 = !DIEnumerator(name: "dragonfly", value: 13, isUnsigned: true)
!181 = !DIEnumerator(name: "freebsd", value: 14, isUnsigned: true)
!182 = !DIEnumerator(name: "netbsd", value: 15, isUnsigned: true)
!183 = !DIEnumerator(name: "openbsd", value: 16, isUnsigned: true)
!184 = !DIEnumerator(name: "driverkit", value: 17, isUnsigned: true)
!185 = !DIEnumerator(name: "ios", value: 18, isUnsigned: true)
!186 = !DIEnumerator(name: "maccatalyst", value: 19, isUnsigned: true)
!187 = !DIEnumerator(name: "macos", value: 20, isUnsigned: true)
!188 = !DIEnumerator(name: "tvos", value: 21, isUnsigned: true)
!189 = !DIEnumerator(name: "visionos", value: 22, isUnsigned: true)
!190 = !DIEnumerator(name: "watchos", value: 23, isUnsigned: true)
!191 = !DIEnumerator(name: "windows", value: 24, isUnsigned: true)
!192 = !DIEnumerator(name: "uefi", value: 25, isUnsigned: true)
!193 = !DIEnumerator(name: "3ds", value: 26, isUnsigned: true)
!194 = !DIEnumerator(name: "ps3", value: 27, isUnsigned: true)
!195 = !DIEnumerator(name: "ps4", value: 28, isUnsigned: true)
!196 = !DIEnumerator(name: "ps5", value: 29, isUnsigned: true)
!197 = !DIEnumerator(name: "psp", value: 30, isUnsigned: true)
!198 = !DIEnumerator(name: "vita", value: 31, isUnsigned: true)
!199 = !DIEnumerator(name: "emscripten", value: 32, isUnsigned: true)
!200 = !DIEnumerator(name: "wasi", value: 33, isUnsigned: true)
!201 = !DIEnumerator(name: "amdhsa", value: 34, isUnsigned: true)
!202 = !DIEnumerator(name: "amdpal", value: 35, isUnsigned: true)
!203 = !DIEnumerator(name: "cuda", value: 36, isUnsigned: true)
!204 = !DIEnumerator(name: "mesa3d", value: 37, isUnsigned: true)
!205 = !DIEnumerator(name: "nvcl", value: 38, isUnsigned: true)
!206 = !DIEnumerator(name: "opencl", value: 39, isUnsigned: true)
!207 = !DIEnumerator(name: "opengl", value: 40, isUnsigned: true)
!208 = !DIEnumerator(name: "vulkan", value: 41, isUnsigned: true)
!209 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "@typeInfo(builtin.CallingConvention).@\22union\22.tag_type.?", scope: !211, file: !210, line: 485, baseType: !116, size: 8, align: 8, elements: !397)
!210 = !DIFile(filename: "builtin.zig", directory: "/Users/sulky/.zvm/master/lib/std")
!211 = !DICompositeType(tag: DW_TAG_structure_type, name: "builtin.CallingConvention", scope: !210, file: !210, line: 485, size: 256, align: 64, elements: !212)
!212 = !{!213, !396}
!213 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !211, baseType: !214, size: 192, align: 64)
!214 = !DICompositeType(tag: DW_TAG_union_type, name: "builtin.CallingConvention:Payload", scope: !210, file: !210, line: 485, size: 192, align: 64, elements: !215)
!215 = !{!216, !217, !218, !219, !220, !229, !230, !231, !232, !233, !234, !235, !240, !241, !242, !243, !244, !245, !246, !247, !248, !249, !250, !251, !252, !253, !254, !255, !256, !257, !258, !259, !260, !261, !274, !275, !276, !293, !294, !295, !296, !297, !306, !307, !308, !309, !310, !311, !312, !313, !314, !315, !316, !317, !318, !319, !320, !331, !332, !333, !334, !335, !336, !337, !338, !339, !340, !341, !342, !343, !344, !345, !346, !347, !348, !349, !350, !351, !352, !363, !364, !365, !366, !367, !368, !369, !370, !371, !382, !383, !384, !385, !386, !387, !388, !389, !390, !391, !392, !393, !394, !395}
!216 = !DIDerivedType(tag: DW_TAG_member, name: "auto", scope: !214, baseType: !99)
!217 = !DIDerivedType(tag: DW_TAG_member, name: "async", scope: !214, baseType: !99)
!218 = !DIDerivedType(tag: DW_TAG_member, name: "naked", scope: !214, baseType: !99)
!219 = !DIDerivedType(tag: DW_TAG_member, name: "inline", scope: !214, baseType: !99)
!220 = !DIDerivedType(tag: DW_TAG_member, name: "x86_64_sysv", scope: !214, baseType: !221, size: 128)
!221 = !DICompositeType(tag: DW_TAG_structure_type, name: "builtin.CallingConvention.CommonOptions", scope: !211, file: !210, line: 345, size: 128, align: 64, elements: !222)
!222 = !{!223}
!223 = !DIDerivedType(tag: DW_TAG_member, name: "incoming_stack_alignment", scope: !221, baseType: !224, size: 128, align: 64)
!224 = !DICompositeType(tag: DW_TAG_structure_type, name: "?u64", scope: !4, size: 128, align: 64, elements: !225)
!225 = !{!226, !228}
!226 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !224, baseType: !227, size: 64, align: 64)
!227 = !DIBasicType(name: "u64", size: 64, encoding: DW_ATE_unsigned)
!228 = !DIDerivedType(tag: DW_TAG_member, name: "some", scope: !224, baseType: !116, size: 8, align: 8, offset: 64)
!229 = !DIDerivedType(tag: DW_TAG_member, name: "x86_64_x32", scope: !214, baseType: !221, size: 128)
!230 = !DIDerivedType(tag: DW_TAG_member, name: "x86_64_win", scope: !214, baseType: !221, size: 128)
!231 = !DIDerivedType(tag: DW_TAG_member, name: "x86_64_regcall_v3_sysv", scope: !214, baseType: !221, size: 128)
!232 = !DIDerivedType(tag: DW_TAG_member, name: "x86_64_regcall_v4_win", scope: !214, baseType: !221, size: 128)
!233 = !DIDerivedType(tag: DW_TAG_member, name: "x86_64_vectorcall", scope: !214, baseType: !221, size: 128)
!234 = !DIDerivedType(tag: DW_TAG_member, name: "x86_64_interrupt", scope: !214, baseType: !221, size: 128)
!235 = !DIDerivedType(tag: DW_TAG_member, name: "x86_sysv", scope: !214, baseType: !236, size: 192)
!236 = !DICompositeType(tag: DW_TAG_structure_type, name: "builtin.CallingConvention.X86RegparmOptions", scope: !211, file: !210, line: 353, size: 192, align: 64, elements: !237)
!237 = !{!238, !239}
!238 = !DIDerivedType(tag: DW_TAG_member, name: "incoming_stack_alignment", scope: !236, baseType: !224, size: 128, align: 64)
!239 = !DIDerivedType(tag: DW_TAG_member, name: "register_params", scope: !236, baseType: !18, size: 8, align: 8, offset: 128)
!240 = !DIDerivedType(tag: DW_TAG_member, name: "x86_win", scope: !214, baseType: !236, size: 192)
!241 = !DIDerivedType(tag: DW_TAG_member, name: "x86_stdcall", scope: !214, baseType: !236, size: 192)
!242 = !DIDerivedType(tag: DW_TAG_member, name: "x86_fastcall", scope: !214, baseType: !221, size: 128)
!243 = !DIDerivedType(tag: DW_TAG_member, name: "x86_thiscall", scope: !214, baseType: !221, size: 128)
!244 = !DIDerivedType(tag: DW_TAG_member, name: "x86_thiscall_mingw", scope: !214, baseType: !221, size: 128)
!245 = !DIDerivedType(tag: DW_TAG_member, name: "x86_regcall_v3", scope: !214, baseType: !221, size: 128)
!246 = !DIDerivedType(tag: DW_TAG_member, name: "x86_regcall_v4_win", scope: !214, baseType: !221, size: 128)
!247 = !DIDerivedType(tag: DW_TAG_member, name: "x86_vectorcall", scope: !214, baseType: !221, size: 128)
!248 = !DIDerivedType(tag: DW_TAG_member, name: "x86_interrupt", scope: !214, baseType: !221, size: 128)
!249 = !DIDerivedType(tag: DW_TAG_member, name: "x86_16_cdecl", scope: !214, baseType: !221, size: 128)
!250 = !DIDerivedType(tag: DW_TAG_member, name: "x86_16_stdcall", scope: !214, baseType: !221, size: 128)
!251 = !DIDerivedType(tag: DW_TAG_member, name: "x86_16_regparmcall", scope: !214, baseType: !221, size: 128)
!252 = !DIDerivedType(tag: DW_TAG_member, name: "x86_16_interrupt", scope: !214, baseType: !221, size: 128)
!253 = !DIDerivedType(tag: DW_TAG_member, name: "aarch64_aapcs", scope: !214, baseType: !221, size: 128)
!254 = !DIDerivedType(tag: DW_TAG_member, name: "aarch64_aapcs_darwin", scope: !214, baseType: !221, size: 128)
!255 = !DIDerivedType(tag: DW_TAG_member, name: "aarch64_aapcs_win", scope: !214, baseType: !221, size: 128)
!256 = !DIDerivedType(tag: DW_TAG_member, name: "aarch64_vfabi", scope: !214, baseType: !221, size: 128)
!257 = !DIDerivedType(tag: DW_TAG_member, name: "aarch64_vfabi_sve", scope: !214, baseType: !221, size: 128)
!258 = !DIDerivedType(tag: DW_TAG_member, name: "alpha_osf", scope: !214, baseType: !221, size: 128)
!259 = !DIDerivedType(tag: DW_TAG_member, name: "arm_aapcs", scope: !214, baseType: !221, size: 128)
!260 = !DIDerivedType(tag: DW_TAG_member, name: "arm_aapcs_vfp", scope: !214, baseType: !221, size: 128)
!261 = !DIDerivedType(tag: DW_TAG_member, name: "arm_interrupt", scope: !214, baseType: !262, size: 192)
!262 = !DICompositeType(tag: DW_TAG_structure_type, name: "builtin.CallingConvention.ArmInterruptOptions", scope: !211, file: !210, line: 387, size: 192, align: 64, elements: !263)
!263 = !{!264, !265}
!264 = !DIDerivedType(tag: DW_TAG_member, name: "incoming_stack_alignment", scope: !262, baseType: !224, size: 128, align: 64)
!265 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !262, baseType: !266, size: 8, align: 8, offset: 128)
!266 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "builtin.CallingConvention.ArmInterruptOptions.InterruptType", scope: !262, file: !210, line: 387, baseType: !84, size: 8, align: 8, elements: !267)
!267 = !{!268, !269, !270, !271, !272, !273}
!268 = !DIEnumerator(name: "generic", value: 0, isUnsigned: true)
!269 = !DIEnumerator(name: "irq", value: 1, isUnsigned: true)
!270 = !DIEnumerator(name: "fiq", value: 2, isUnsigned: true)
!271 = !DIEnumerator(name: "swi", value: 3, isUnsigned: true)
!272 = !DIEnumerator(name: "abort", value: 4, isUnsigned: true)
!273 = !DIEnumerator(name: "undef", value: 5, isUnsigned: true)
!274 = !DIDerivedType(tag: DW_TAG_member, name: "mips64_n64", scope: !214, baseType: !221, size: 128)
!275 = !DIDerivedType(tag: DW_TAG_member, name: "mips64_n32", scope: !214, baseType: !221, size: 128)
!276 = !DIDerivedType(tag: DW_TAG_member, name: "mips64_interrupt", scope: !214, baseType: !277, size: 192)
!277 = !DICompositeType(tag: DW_TAG_structure_type, name: "builtin.CallingConvention.MipsInterruptOptions", scope: !211, file: !210, line: 424, size: 192, align: 64, elements: !278)
!278 = !{!279, !280}
!279 = !DIDerivedType(tag: DW_TAG_member, name: "incoming_stack_alignment", scope: !277, baseType: !224, size: 128, align: 64)
!280 = !DIDerivedType(tag: DW_TAG_member, name: "mode", scope: !277, baseType: !281, size: 8, align: 8, offset: 128)
!281 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "builtin.CallingConvention.MipsInterruptOptions.InterruptMode", scope: !277, file: !210, line: 424, baseType: !282, size: 8, align: 8, elements: !283)
!282 = !DIBasicType(name: "u4", size: 8, encoding: DW_ATE_unsigned)
!283 = !{!284, !285, !286, !287, !288, !289, !290, !291, !292}
!284 = !DIEnumerator(name: "eic", value: 0, isUnsigned: true)
!285 = !DIEnumerator(name: "sw0", value: 1, isUnsigned: true)
!286 = !DIEnumerator(name: "sw1", value: 2, isUnsigned: true)
!287 = !DIEnumerator(name: "hw0", value: 3, isUnsigned: true)
!288 = !DIEnumerator(name: "hw1", value: 4, isUnsigned: true)
!289 = !DIEnumerator(name: "hw2", value: 5, isUnsigned: true)
!290 = !DIEnumerator(name: "hw3", value: 6, isUnsigned: true)
!291 = !DIEnumerator(name: "hw4", value: 7, isUnsigned: true)
!292 = !DIEnumerator(name: "hw5", value: 8, isUnsigned: true)
!293 = !DIDerivedType(tag: DW_TAG_member, name: "mips_o32", scope: !214, baseType: !221, size: 128)
!294 = !DIDerivedType(tag: DW_TAG_member, name: "mips_interrupt", scope: !214, baseType: !277, size: 192)
!295 = !DIDerivedType(tag: DW_TAG_member, name: "riscv64_lp64", scope: !214, baseType: !221, size: 128)
!296 = !DIDerivedType(tag: DW_TAG_member, name: "riscv64_lp64_v", scope: !214, baseType: !221, size: 128)
!297 = !DIDerivedType(tag: DW_TAG_member, name: "riscv64_interrupt", scope: !214, baseType: !298, size: 192)
!298 = !DICompositeType(tag: DW_TAG_structure_type, name: "builtin.CallingConvention.RiscvInterruptOptions", scope: !211, file: !210, line: 445, size: 192, align: 64, elements: !299)
!299 = !{!300, !301}
!300 = !DIDerivedType(tag: DW_TAG_member, name: "incoming_stack_alignment", scope: !298, baseType: !224, size: 128, align: 64)
!301 = !DIDerivedType(tag: DW_TAG_member, name: "mode", scope: !298, baseType: !302, size: 8, align: 8, offset: 128)
!302 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "builtin.CallingConvention.RiscvInterruptOptions.PrivilegeMode", scope: !298, file: !210, line: 445, baseType: !18, size: 8, align: 8, elements: !303)
!303 = !{!304, !305}
!304 = !DIEnumerator(name: "supervisor", value: 0, isUnsigned: true)
!305 = !DIEnumerator(name: "machine", value: 1, isUnsigned: true)
!306 = !DIDerivedType(tag: DW_TAG_member, name: "riscv32_ilp32", scope: !214, baseType: !221, size: 128)
!307 = !DIDerivedType(tag: DW_TAG_member, name: "riscv32_ilp32_v", scope: !214, baseType: !221, size: 128)
!308 = !DIDerivedType(tag: DW_TAG_member, name: "riscv32_interrupt", scope: !214, baseType: !298, size: 192)
!309 = !DIDerivedType(tag: DW_TAG_member, name: "sparc64_sysv", scope: !214, baseType: !221, size: 128)
!310 = !DIDerivedType(tag: DW_TAG_member, name: "sparc_sysv", scope: !214, baseType: !221, size: 128)
!311 = !DIDerivedType(tag: DW_TAG_member, name: "powerpc64_elf", scope: !214, baseType: !221, size: 128)
!312 = !DIDerivedType(tag: DW_TAG_member, name: "powerpc64_elf_altivec", scope: !214, baseType: !221, size: 128)
!313 = !DIDerivedType(tag: DW_TAG_member, name: "powerpc64_elf_v2", scope: !214, baseType: !221, size: 128)
!314 = !DIDerivedType(tag: DW_TAG_member, name: "powerpc_sysv", scope: !214, baseType: !221, size: 128)
!315 = !DIDerivedType(tag: DW_TAG_member, name: "powerpc_sysv_altivec", scope: !214, baseType: !221, size: 128)
!316 = !DIDerivedType(tag: DW_TAG_member, name: "powerpc_aix", scope: !214, baseType: !221, size: 128)
!317 = !DIDerivedType(tag: DW_TAG_member, name: "powerpc_aix_altivec", scope: !214, baseType: !221, size: 128)
!318 = !DIDerivedType(tag: DW_TAG_member, name: "wasm_mvp", scope: !214, baseType: !221, size: 128)
!319 = !DIDerivedType(tag: DW_TAG_member, name: "arc_sysv", scope: !214, baseType: !221, size: 128)
!320 = !DIDerivedType(tag: DW_TAG_member, name: "arc_interrupt", scope: !214, baseType: !321, size: 192)
!321 = !DICompositeType(tag: DW_TAG_structure_type, name: "builtin.CallingConvention.ArcInterruptOptions", scope: !211, file: !210, line: 371, size: 192, align: 64, elements: !322)
!322 = !{!323, !324}
!323 = !DIDerivedType(tag: DW_TAG_member, name: "incoming_stack_alignment", scope: !321, baseType: !224, size: 128, align: 64)
!324 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !321, baseType: !325, size: 8, align: 8, offset: 128)
!325 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "builtin.CallingConvention.ArcInterruptOptions.InterruptType", scope: !321, file: !210, line: 371, baseType: !18, size: 8, align: 8, elements: !326)
!326 = !{!327, !328, !329, !330}
!327 = !DIEnumerator(name: "ilink1", value: 0, isUnsigned: true)
!328 = !DIEnumerator(name: "ilink2", value: 1, isUnsigned: true)
!329 = !DIEnumerator(name: "ilink", value: 2, isUnsigned: true)
!330 = !DIEnumerator(name: "firq", value: 3, isUnsigned: true)
!331 = !DIDerivedType(tag: DW_TAG_member, name: "avr_gnu", scope: !214, baseType: !99)
!332 = !DIDerivedType(tag: DW_TAG_member, name: "avr_builtin", scope: !214, baseType: !99)
!333 = !DIDerivedType(tag: DW_TAG_member, name: "avr_signal", scope: !214, baseType: !99)
!334 = !DIDerivedType(tag: DW_TAG_member, name: "avr_interrupt", scope: !214, baseType: !99)
!335 = !DIDerivedType(tag: DW_TAG_member, name: "bpf_std", scope: !214, baseType: !221, size: 128)
!336 = !DIDerivedType(tag: DW_TAG_member, name: "csky_sysv", scope: !214, baseType: !221, size: 128)
!337 = !DIDerivedType(tag: DW_TAG_member, name: "csky_interrupt", scope: !214, baseType: !221, size: 128)
!338 = !DIDerivedType(tag: DW_TAG_member, name: "hexagon_sysv", scope: !214, baseType: !221, size: 128)
!339 = !DIDerivedType(tag: DW_TAG_member, name: "hexagon_sysv_hvx", scope: !214, baseType: !221, size: 128)
!340 = !DIDerivedType(tag: DW_TAG_member, name: "hppa_elf", scope: !214, baseType: !221, size: 128)
!341 = !DIDerivedType(tag: DW_TAG_member, name: "hppa64_elf", scope: !214, baseType: !221, size: 128)
!342 = !DIDerivedType(tag: DW_TAG_member, name: "kvx_lp64", scope: !214, baseType: !221, size: 128)
!343 = !DIDerivedType(tag: DW_TAG_member, name: "kvx_ilp32", scope: !214, baseType: !221, size: 128)
!344 = !DIDerivedType(tag: DW_TAG_member, name: "lanai_sysv", scope: !214, baseType: !221, size: 128)
!345 = !DIDerivedType(tag: DW_TAG_member, name: "loongarch64_lp64", scope: !214, baseType: !221, size: 128)
!346 = !DIDerivedType(tag: DW_TAG_member, name: "loongarch32_ilp32", scope: !214, baseType: !221, size: 128)
!347 = !DIDerivedType(tag: DW_TAG_member, name: "m68k_sysv", scope: !214, baseType: !221, size: 128)
!348 = !DIDerivedType(tag: DW_TAG_member, name: "m68k_gnu", scope: !214, baseType: !221, size: 128)
!349 = !DIDerivedType(tag: DW_TAG_member, name: "m68k_rtd", scope: !214, baseType: !221, size: 128)
!350 = !DIDerivedType(tag: DW_TAG_member, name: "m68k_interrupt", scope: !214, baseType: !221, size: 128)
!351 = !DIDerivedType(tag: DW_TAG_member, name: "microblaze_std", scope: !214, baseType: !221, size: 128)
!352 = !DIDerivedType(tag: DW_TAG_member, name: "microblaze_interrupt", scope: !214, baseType: !353, size: 192)
!353 = !DICompositeType(tag: DW_TAG_structure_type, name: "builtin.CallingConvention.MicroblazeInterruptOptions", scope: !211, file: !210, line: 404, size: 192, align: 64, elements: !354)
!354 = !{!355, !356}
!355 = !DIDerivedType(tag: DW_TAG_member, name: "incoming_stack_alignment", scope: !353, baseType: !224, size: 128, align: 64)
!356 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !353, baseType: !357, size: 8, align: 8, offset: 128)
!357 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "builtin.CallingConvention.MicroblazeInterruptOptions.InterruptType", scope: !353, file: !210, line: 404, baseType: !18, size: 8, align: 8, elements: !358)
!358 = !{!359, !360, !361, !362}
!359 = !DIEnumerator(name: "user", value: 0, isUnsigned: true)
!360 = !DIEnumerator(name: "regular", value: 1, isUnsigned: true)
!361 = !DIEnumerator(name: "fast", value: 2, isUnsigned: true)
!362 = !DIEnumerator(name: "breakpoint", value: 3, isUnsigned: true)
!363 = !DIDerivedType(tag: DW_TAG_member, name: "msp430_eabi", scope: !214, baseType: !221, size: 128)
!364 = !DIDerivedType(tag: DW_TAG_member, name: "msp430_interrupt", scope: !214, baseType: !221, size: 128)
!365 = !DIDerivedType(tag: DW_TAG_member, name: "or1k_sysv", scope: !214, baseType: !221, size: 128)
!366 = !DIDerivedType(tag: DW_TAG_member, name: "propeller_sysv", scope: !214, baseType: !221, size: 128)
!367 = !DIDerivedType(tag: DW_TAG_member, name: "s390x_sysv", scope: !214, baseType: !221, size: 128)
!368 = !DIDerivedType(tag: DW_TAG_member, name: "s390x_sysv_vx", scope: !214, baseType: !221, size: 128)
!369 = !DIDerivedType(tag: DW_TAG_member, name: "sh_gnu", scope: !214, baseType: !221, size: 128)
!370 = !DIDerivedType(tag: DW_TAG_member, name: "sh_renesas", scope: !214, baseType: !221, size: 128)
!371 = !DIDerivedType(tag: DW_TAG_member, name: "sh_interrupt", scope: !214, baseType: !372, size: 192)
!372 = !DICompositeType(tag: DW_TAG_structure_type, name: "builtin.CallingConvention.ShInterruptOptions", scope: !211, file: !210, line: 458, size: 192, align: 64, elements: !373)
!373 = !{!374, !375}
!374 = !DIDerivedType(tag: DW_TAG_member, name: "incoming_stack_alignment", scope: !372, baseType: !224, size: 128, align: 64)
!375 = !DIDerivedType(tag: DW_TAG_member, name: "save", scope: !372, baseType: !376, size: 8, align: 8, offset: 128)
!376 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "builtin.CallingConvention.ShInterruptOptions.SaveBehavior", scope: !372, file: !210, line: 458, baseType: !84, size: 8, align: 8, elements: !377)
!377 = !{!378, !379, !380, !381}
!378 = !DIEnumerator(name: "fpscr", value: 0, isUnsigned: true)
!379 = !DIEnumerator(name: "high", value: 1, isUnsigned: true)
!380 = !DIEnumerator(name: "full", value: 2, isUnsigned: true)
!381 = !DIEnumerator(name: "bank", value: 3, isUnsigned: true)
!382 = !DIDerivedType(tag: DW_TAG_member, name: "ve_sysv", scope: !214, baseType: !221, size: 128)
!383 = !DIDerivedType(tag: DW_TAG_member, name: "xcore_xs1", scope: !214, baseType: !221, size: 128)
!384 = !DIDerivedType(tag: DW_TAG_member, name: "xcore_xs2", scope: !214, baseType: !221, size: 128)
!385 = !DIDerivedType(tag: DW_TAG_member, name: "xtensa_call0", scope: !214, baseType: !221, size: 128)
!386 = !DIDerivedType(tag: DW_TAG_member, name: "xtensa_windowed", scope: !214, baseType: !221, size: 128)
!387 = !DIDerivedType(tag: DW_TAG_member, name: "amdgcn_device", scope: !214, baseType: !221, size: 128)
!388 = !DIDerivedType(tag: DW_TAG_member, name: "amdgcn_kernel", scope: !214, baseType: !99)
!389 = !DIDerivedType(tag: DW_TAG_member, name: "amdgcn_cs", scope: !214, baseType: !221, size: 128)
!390 = !DIDerivedType(tag: DW_TAG_member, name: "nvptx_device", scope: !214, baseType: !99)
!391 = !DIDerivedType(tag: DW_TAG_member, name: "nvptx_kernel", scope: !214, baseType: !99)
!392 = !DIDerivedType(tag: DW_TAG_member, name: "spirv_device", scope: !214, baseType: !99)
!393 = !DIDerivedType(tag: DW_TAG_member, name: "spirv_kernel", scope: !214, baseType: !99)
!394 = !DIDerivedType(tag: DW_TAG_member, name: "spirv_fragment", scope: !214, baseType: !99)
!395 = !DIDerivedType(tag: DW_TAG_member, name: "spirv_vertex", scope: !214, baseType: !99)
!396 = !DIDerivedType(tag: DW_TAG_member, name: "tag", scope: !211, baseType: !209, size: 8, align: 8, offset: 192)
!397 = !{!398, !399, !400, !401, !402, !403, !404, !405, !406, !407, !408, !409, !410, !411, !412, !413, !414, !415, !416, !417, !418, !419, !420, !421, !422, !423, !424, !425, !426, !427, !428, !429, !430, !431, !432, !433, !434, !435, !436, !437, !438, !439, !440, !441, !442, !443, !444, !445, !446, !447, !448, !449, !450, !451, !452, !453, !454, !455, !456, !457, !458, !459, !460, !461, !462, !463, !464, !465, !466, !467, !468, !469, !470, !471, !472, !473, !474, !475, !476, !477, !478, !479, !480, !481, !482, !483, !484, !485, !486, !487, !488, !489, !490, !491, !492, !493, !494, !495, !496, !497, !498, !499}
!398 = !DIEnumerator(name: "auto", value: 0, isUnsigned: true)
!399 = !DIEnumerator(name: "async", value: 1, isUnsigned: true)
!400 = !DIEnumerator(name: "naked", value: 2, isUnsigned: true)
!401 = !DIEnumerator(name: "inline", value: 3, isUnsigned: true)
!402 = !DIEnumerator(name: "x86_64_sysv", value: 4, isUnsigned: true)
!403 = !DIEnumerator(name: "x86_64_x32", value: 5, isUnsigned: true)
!404 = !DIEnumerator(name: "x86_64_win", value: 6, isUnsigned: true)
!405 = !DIEnumerator(name: "x86_64_regcall_v3_sysv", value: 7, isUnsigned: true)
!406 = !DIEnumerator(name: "x86_64_regcall_v4_win", value: 8, isUnsigned: true)
!407 = !DIEnumerator(name: "x86_64_vectorcall", value: 9, isUnsigned: true)
!408 = !DIEnumerator(name: "x86_64_interrupt", value: 10, isUnsigned: true)
!409 = !DIEnumerator(name: "x86_sysv", value: 11, isUnsigned: true)
!410 = !DIEnumerator(name: "x86_win", value: 12, isUnsigned: true)
!411 = !DIEnumerator(name: "x86_stdcall", value: 13, isUnsigned: true)
!412 = !DIEnumerator(name: "x86_fastcall", value: 14, isUnsigned: true)
!413 = !DIEnumerator(name: "x86_thiscall", value: 15, isUnsigned: true)
!414 = !DIEnumerator(name: "x86_thiscall_mingw", value: 16, isUnsigned: true)
!415 = !DIEnumerator(name: "x86_regcall_v3", value: 17, isUnsigned: true)
!416 = !DIEnumerator(name: "x86_regcall_v4_win", value: 18, isUnsigned: true)
!417 = !DIEnumerator(name: "x86_vectorcall", value: 19, isUnsigned: true)
!418 = !DIEnumerator(name: "x86_interrupt", value: 20, isUnsigned: true)
!419 = !DIEnumerator(name: "x86_16_cdecl", value: 21, isUnsigned: true)
!420 = !DIEnumerator(name: "x86_16_stdcall", value: 22, isUnsigned: true)
!421 = !DIEnumerator(name: "x86_16_regparmcall", value: 23, isUnsigned: true)
!422 = !DIEnumerator(name: "x86_16_interrupt", value: 24, isUnsigned: true)
!423 = !DIEnumerator(name: "aarch64_aapcs", value: 25, isUnsigned: true)
!424 = !DIEnumerator(name: "aarch64_aapcs_darwin", value: 26, isUnsigned: true)
!425 = !DIEnumerator(name: "aarch64_aapcs_win", value: 27, isUnsigned: true)
!426 = !DIEnumerator(name: "aarch64_vfabi", value: 28, isUnsigned: true)
!427 = !DIEnumerator(name: "aarch64_vfabi_sve", value: 29, isUnsigned: true)
!428 = !DIEnumerator(name: "alpha_osf", value: 30, isUnsigned: true)
!429 = !DIEnumerator(name: "arm_aapcs", value: 31, isUnsigned: true)
!430 = !DIEnumerator(name: "arm_aapcs_vfp", value: 32, isUnsigned: true)
!431 = !DIEnumerator(name: "arm_interrupt", value: 33, isUnsigned: true)
!432 = !DIEnumerator(name: "mips64_n64", value: 34, isUnsigned: true)
!433 = !DIEnumerator(name: "mips64_n32", value: 35, isUnsigned: true)
!434 = !DIEnumerator(name: "mips64_interrupt", value: 36, isUnsigned: true)
!435 = !DIEnumerator(name: "mips_o32", value: 37, isUnsigned: true)
!436 = !DIEnumerator(name: "mips_interrupt", value: 38, isUnsigned: true)
!437 = !DIEnumerator(name: "riscv64_lp64", value: 39, isUnsigned: true)
!438 = !DIEnumerator(name: "riscv64_lp64_v", value: 40, isUnsigned: true)
!439 = !DIEnumerator(name: "riscv64_interrupt", value: 41, isUnsigned: true)
!440 = !DIEnumerator(name: "riscv32_ilp32", value: 42, isUnsigned: true)
!441 = !DIEnumerator(name: "riscv32_ilp32_v", value: 43, isUnsigned: true)
!442 = !DIEnumerator(name: "riscv32_interrupt", value: 44, isUnsigned: true)
!443 = !DIEnumerator(name: "sparc64_sysv", value: 45, isUnsigned: true)
!444 = !DIEnumerator(name: "sparc_sysv", value: 46, isUnsigned: true)
!445 = !DIEnumerator(name: "powerpc64_elf", value: 47, isUnsigned: true)
!446 = !DIEnumerator(name: "powerpc64_elf_altivec", value: 48, isUnsigned: true)
!447 = !DIEnumerator(name: "powerpc64_elf_v2", value: 49, isUnsigned: true)
!448 = !DIEnumerator(name: "powerpc_sysv", value: 50, isUnsigned: true)
!449 = !DIEnumerator(name: "powerpc_sysv_altivec", value: 51, isUnsigned: true)
!450 = !DIEnumerator(name: "powerpc_aix", value: 52, isUnsigned: true)
!451 = !DIEnumerator(name: "powerpc_aix_altivec", value: 53, isUnsigned: true)
!452 = !DIEnumerator(name: "wasm_mvp", value: 54, isUnsigned: true)
!453 = !DIEnumerator(name: "arc_sysv", value: 55, isUnsigned: true)
!454 = !DIEnumerator(name: "arc_interrupt", value: 56, isUnsigned: true)
!455 = !DIEnumerator(name: "avr_gnu", value: 57, isUnsigned: true)
!456 = !DIEnumerator(name: "avr_builtin", value: 58, isUnsigned: true)
!457 = !DIEnumerator(name: "avr_signal", value: 59, isUnsigned: true)
!458 = !DIEnumerator(name: "avr_interrupt", value: 60, isUnsigned: true)
!459 = !DIEnumerator(name: "bpf_std", value: 61, isUnsigned: true)
!460 = !DIEnumerator(name: "csky_sysv", value: 62, isUnsigned: true)
!461 = !DIEnumerator(name: "csky_interrupt", value: 63, isUnsigned: true)
!462 = !DIEnumerator(name: "hexagon_sysv", value: 64, isUnsigned: true)
!463 = !DIEnumerator(name: "hexagon_sysv_hvx", value: 65, isUnsigned: true)
!464 = !DIEnumerator(name: "hppa_elf", value: 66, isUnsigned: true)
!465 = !DIEnumerator(name: "hppa64_elf", value: 67, isUnsigned: true)
!466 = !DIEnumerator(name: "kvx_lp64", value: 68, isUnsigned: true)
!467 = !DIEnumerator(name: "kvx_ilp32", value: 69, isUnsigned: true)
!468 = !DIEnumerator(name: "lanai_sysv", value: 70, isUnsigned: true)
!469 = !DIEnumerator(name: "loongarch64_lp64", value: 71, isUnsigned: true)
!470 = !DIEnumerator(name: "loongarch32_ilp32", value: 72, isUnsigned: true)
!471 = !DIEnumerator(name: "m68k_sysv", value: 73, isUnsigned: true)
!472 = !DIEnumerator(name: "m68k_gnu", value: 74, isUnsigned: true)
!473 = !DIEnumerator(name: "m68k_rtd", value: 75, isUnsigned: true)
!474 = !DIEnumerator(name: "m68k_interrupt", value: 76, isUnsigned: true)
!475 = !DIEnumerator(name: "microblaze_std", value: 77, isUnsigned: true)
!476 = !DIEnumerator(name: "microblaze_interrupt", value: 78, isUnsigned: true)
!477 = !DIEnumerator(name: "msp430_eabi", value: 79, isUnsigned: true)
!478 = !DIEnumerator(name: "msp430_interrupt", value: 80, isUnsigned: true)
!479 = !DIEnumerator(name: "or1k_sysv", value: 81, isUnsigned: true)
!480 = !DIEnumerator(name: "propeller_sysv", value: 82, isUnsigned: true)
!481 = !DIEnumerator(name: "s390x_sysv", value: 83, isUnsigned: true)
!482 = !DIEnumerator(name: "s390x_sysv_vx", value: 84, isUnsigned: true)
!483 = !DIEnumerator(name: "sh_gnu", value: 85, isUnsigned: true)
!484 = !DIEnumerator(name: "sh_renesas", value: 86, isUnsigned: true)
!485 = !DIEnumerator(name: "sh_interrupt", value: 87, isUnsigned: true)
!486 = !DIEnumerator(name: "ve_sysv", value: 88, isUnsigned: true)
!487 = !DIEnumerator(name: "xcore_xs1", value: 89, isUnsigned: true)
!488 = !DIEnumerator(name: "xcore_xs2", value: 90, isUnsigned: true)
!489 = !DIEnumerator(name: "xtensa_call0", value: 91, isUnsigned: true)
!490 = !DIEnumerator(name: "xtensa_windowed", value: 92, isUnsigned: true)
!491 = !DIEnumerator(name: "amdgcn_device", value: 93, isUnsigned: true)
!492 = !DIEnumerator(name: "amdgcn_kernel", value: 94, isUnsigned: true)
!493 = !DIEnumerator(name: "amdgcn_cs", value: 95, isUnsigned: true)
!494 = !DIEnumerator(name: "nvptx_device", value: 96, isUnsigned: true)
!495 = !DIEnumerator(name: "nvptx_kernel", value: 97, isUnsigned: true)
!496 = !DIEnumerator(name: "spirv_device", value: 98, isUnsigned: true)
!497 = !DIEnumerator(name: "spirv_kernel", value: 99, isUnsigned: true)
!498 = !DIEnumerator(name: "spirv_fragment", value: 100, isUnsigned: true)
!499 = !DIEnumerator(name: "spirv_vertex", value: 101, isUnsigned: true)
!500 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "Target.ObjectFormat", scope: !92, file: !92, line: 1058, baseType: !282, size: 8, align: 8, elements: !501)
!501 = !{!502, !503, !504, !505, !506, !507, !508, !509, !510}
!502 = !DIEnumerator(name: "c", value: 0, isUnsigned: true)
!503 = !DIEnumerator(name: "coff", value: 1, isUnsigned: true)
!504 = !DIEnumerator(name: "elf", value: 2, isUnsigned: true)
!505 = !DIEnumerator(name: "hex", value: 3, isUnsigned: true)
!506 = !DIEnumerator(name: "macho", value: 4, isUnsigned: true)
!507 = !DIEnumerator(name: "plan9", value: 5, isUnsigned: true)
!508 = !DIEnumerator(name: "raw", value: 6, isUnsigned: true)
!509 = !DIEnumerator(name: "spirv", value: 7, isUnsigned: true)
!510 = !DIEnumerator(name: "wasm", value: 8, isUnsigned: true)
!511 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "Target.Abi", scope: !92, file: !92, line: 1009, baseType: !512, size: 8, align: 8, elements: !513)
!512 = !DIBasicType(name: "u5", size: 8, encoding: DW_ATE_unsigned)
!513 = !{!514, !515, !516, !517, !518, !519, !520, !521, !522, !523, !524, !525, !526, !527, !528, !529, !530, !531, !532, !533, !534, !535, !536, !537, !538, !539, !540}
!514 = !DIEnumerator(name: "none", value: 0, isUnsigned: true)
!515 = !DIEnumerator(name: "gnu", value: 1, isUnsigned: true)
!516 = !DIEnumerator(name: "gnuabin32", value: 2, isUnsigned: true)
!517 = !DIEnumerator(name: "gnuabi64", value: 3, isUnsigned: true)
!518 = !DIEnumerator(name: "gnueabi", value: 4, isUnsigned: true)
!519 = !DIEnumerator(name: "gnueabihf", value: 5, isUnsigned: true)
!520 = !DIEnumerator(name: "gnuf32", value: 6, isUnsigned: true)
!521 = !DIEnumerator(name: "gnusf", value: 7, isUnsigned: true)
!522 = !DIEnumerator(name: "gnux32", value: 8, isUnsigned: true)
!523 = !DIEnumerator(name: "eabi", value: 9, isUnsigned: true)
!524 = !DIEnumerator(name: "eabihf", value: 10, isUnsigned: true)
!525 = !DIEnumerator(name: "ilp32", value: 11, isUnsigned: true)
!526 = !DIEnumerator(name: "android", value: 12, isUnsigned: true)
!527 = !DIEnumerator(name: "androideabi", value: 13, isUnsigned: true)
!528 = !DIEnumerator(name: "musl", value: 14, isUnsigned: true)
!529 = !DIEnumerator(name: "muslabin32", value: 15, isUnsigned: true)
!530 = !DIEnumerator(name: "muslabi64", value: 16, isUnsigned: true)
!531 = !DIEnumerator(name: "musleabi", value: 17, isUnsigned: true)
!532 = !DIEnumerator(name: "musleabihf", value: 18, isUnsigned: true)
!533 = !DIEnumerator(name: "muslf32", value: 19, isUnsigned: true)
!534 = !DIEnumerator(name: "muslsf", value: 20, isUnsigned: true)
!535 = !DIEnumerator(name: "muslx32", value: 21, isUnsigned: true)
!536 = !DIEnumerator(name: "msvc", value: 22, isUnsigned: true)
!537 = !DIEnumerator(name: "itanium", value: 23, isUnsigned: true)
!538 = !DIEnumerator(name: "simulator", value: 24, isUnsigned: true)
!539 = !DIEnumerator(name: "ohos", value: 25, isUnsigned: true)
!540 = !DIEnumerator(name: "ohoseabi", value: 26, isUnsigned: true)
!541 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "Target.Cpu.Arch", scope: !542, file: !92, line: 1952, baseType: !165, size: 8, align: 8, elements: !566)
!542 = !DICompositeType(tag: DW_TAG_structure_type, name: "Target.Cpu", scope: !92, file: !92, line: 2095, size: 448, align: 64, elements: !543)
!543 = !{!544, !564, !565}
!544 = !DIDerivedType(tag: DW_TAG_member, name: "model", scope: !542, baseType: !545, size: 64, align: 64)
!545 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const Target.Cpu.Model", scope: !4, baseType: !546, size: 64, align: 64)
!546 = !DICompositeType(tag: DW_TAG_structure_type, name: "Target.Cpu.Model", scope: !542, file: !92, line: 2064, size: 576, align: 64, elements: !547)
!547 = !{!548, !549, !556}
!548 = !DIDerivedType(tag: DW_TAG_member, name: "name", scope: !546, baseType: !112, size: 128, align: 64)
!549 = !DIDerivedType(tag: DW_TAG_member, name: "llvm_name", scope: !546, baseType: !550, size: 128, align: 64, offset: 128)
!550 = !DIDerivedType(tag: DW_TAG_typedef, name: "?[:0]const u8", scope: !4, baseType: !551, size: 128, align: 64)
!551 = !DICompositeType(tag: DW_TAG_structure_type, name: "[:0]const u8", scope: !4, size: 128, align: 64, elements: !552)
!552 = !{!553, !555}
!553 = !DIDerivedType(tag: DW_TAG_member, name: "ptr", scope: !551, baseType: !554, size: 64, align: 64)
!554 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "[*:0]const u8", scope: !4, baseType: !116, size: 64, align: 64)
!555 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !551, baseType: !73, size: 64, align: 64, offset: 64)
!556 = !DIDerivedType(tag: DW_TAG_member, name: "features", scope: !546, baseType: !557, size: 320, align: 64, offset: 256)
!557 = !DICompositeType(tag: DW_TAG_structure_type, name: "Target.Cpu.Feature.Set", scope: !558, file: !92, line: 1288, size: 320, align: 64, elements: !559)
!558 = !DIBasicType(name: "Target.Cpu.Feature", encoding: DW_ATE_signed)
!559 = !{!560}
!560 = !DIDerivedType(tag: DW_TAG_member, name: "ints", scope: !557, baseType: !561, size: 320, align: 64)
!561 = !DICompositeType(tag: DW_TAG_array_type, name: "[5]usize", scope: !4, baseType: !73, size: 320, align: 64, elements: !562)
!562 = !{!563}
!563 = !DISubrange(count: 5, lowerBound: 0)
!564 = !DIDerivedType(tag: DW_TAG_member, name: "features", scope: !542, baseType: !557, size: 320, align: 64, offset: 64)
!565 = !DIDerivedType(tag: DW_TAG_member, name: "arch", scope: !542, baseType: !541, size: 8, align: 8, offset: 384)
!566 = !{!567, !568, !569, !570, !571, !572, !573, !574, !575, !576, !577, !578, !579, !580, !581, !582, !583, !584, !585, !586, !587, !588, !589, !590, !591, !592, !593, !594, !595, !596, !597, !598, !599, !600, !601, !602, !603, !604, !605, !606, !607, !608, !609, !610, !611, !612, !613, !614, !615, !616, !617, !618, !619, !620, !621, !622, !623, !624}
!567 = !DIEnumerator(name: "aarch64", value: 0, isUnsigned: true)
!568 = !DIEnumerator(name: "aarch64_be", value: 1, isUnsigned: true)
!569 = !DIEnumerator(name: "alpha", value: 2, isUnsigned: true)
!570 = !DIEnumerator(name: "amdgcn", value: 3, isUnsigned: true)
!571 = !DIEnumerator(name: "arc", value: 4, isUnsigned: true)
!572 = !DIEnumerator(name: "arceb", value: 5, isUnsigned: true)
!573 = !DIEnumerator(name: "arm", value: 6, isUnsigned: true)
!574 = !DIEnumerator(name: "armeb", value: 7, isUnsigned: true)
!575 = !DIEnumerator(name: "avr", value: 8, isUnsigned: true)
!576 = !DIEnumerator(name: "bpfeb", value: 9, isUnsigned: true)
!577 = !DIEnumerator(name: "bpfel", value: 10, isUnsigned: true)
!578 = !DIEnumerator(name: "csky", value: 11, isUnsigned: true)
!579 = !DIEnumerator(name: "hexagon", value: 12, isUnsigned: true)
!580 = !DIEnumerator(name: "hppa", value: 13, isUnsigned: true)
!581 = !DIEnumerator(name: "hppa64", value: 14, isUnsigned: true)
!582 = !DIEnumerator(name: "kalimba", value: 15, isUnsigned: true)
!583 = !DIEnumerator(name: "kvx", value: 16, isUnsigned: true)
!584 = !DIEnumerator(name: "lanai", value: 17, isUnsigned: true)
!585 = !DIEnumerator(name: "loongarch32", value: 18, isUnsigned: true)
!586 = !DIEnumerator(name: "loongarch64", value: 19, isUnsigned: true)
!587 = !DIEnumerator(name: "m68k", value: 20, isUnsigned: true)
!588 = !DIEnumerator(name: "microblaze", value: 21, isUnsigned: true)
!589 = !DIEnumerator(name: "microblazeel", value: 22, isUnsigned: true)
!590 = !DIEnumerator(name: "mips", value: 23, isUnsigned: true)
!591 = !DIEnumerator(name: "mipsel", value: 24, isUnsigned: true)
!592 = !DIEnumerator(name: "mips64", value: 25, isUnsigned: true)
!593 = !DIEnumerator(name: "mips64el", value: 26, isUnsigned: true)
!594 = !DIEnumerator(name: "msp430", value: 27, isUnsigned: true)
!595 = !DIEnumerator(name: "nvptx", value: 28, isUnsigned: true)
!596 = !DIEnumerator(name: "nvptx64", value: 29, isUnsigned: true)
!597 = !DIEnumerator(name: "or1k", value: 30, isUnsigned: true)
!598 = !DIEnumerator(name: "powerpc", value: 31, isUnsigned: true)
!599 = !DIEnumerator(name: "powerpcle", value: 32, isUnsigned: true)
!600 = !DIEnumerator(name: "powerpc64", value: 33, isUnsigned: true)
!601 = !DIEnumerator(name: "powerpc64le", value: 34, isUnsigned: true)
!602 = !DIEnumerator(name: "propeller", value: 35, isUnsigned: true)
!603 = !DIEnumerator(name: "riscv32", value: 36, isUnsigned: true)
!604 = !DIEnumerator(name: "riscv32be", value: 37, isUnsigned: true)
!605 = !DIEnumerator(name: "riscv64", value: 38, isUnsigned: true)
!606 = !DIEnumerator(name: "riscv64be", value: 39, isUnsigned: true)
!607 = !DIEnumerator(name: "s390x", value: 40, isUnsigned: true)
!608 = !DIEnumerator(name: "sh", value: 41, isUnsigned: true)
!609 = !DIEnumerator(name: "sheb", value: 42, isUnsigned: true)
!610 = !DIEnumerator(name: "sparc", value: 43, isUnsigned: true)
!611 = !DIEnumerator(name: "sparc64", value: 44, isUnsigned: true)
!612 = !DIEnumerator(name: "spirv32", value: 45, isUnsigned: true)
!613 = !DIEnumerator(name: "spirv64", value: 46, isUnsigned: true)
!614 = !DIEnumerator(name: "thumb", value: 47, isUnsigned: true)
!615 = !DIEnumerator(name: "thumbeb", value: 48, isUnsigned: true)
!616 = !DIEnumerator(name: "ve", value: 49, isUnsigned: true)
!617 = !DIEnumerator(name: "wasm32", value: 50, isUnsigned: true)
!618 = !DIEnumerator(name: "wasm64", value: 51, isUnsigned: true)
!619 = !DIEnumerator(name: "x86_16", value: 52, isUnsigned: true)
!620 = !DIEnumerator(name: "x86", value: 53, isUnsigned: true)
!621 = !DIEnumerator(name: "x86_64", value: 54, isUnsigned: true)
!622 = !DIEnumerator(name: "xcore", value: 55, isUnsigned: true)
!623 = !DIEnumerator(name: "xtensa", value: 56, isUnsigned: true)
!624 = !DIEnumerator(name: "xtensaeb", value: 57, isUnsigned: true)
!625 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "builtin.OutputMode", scope: !210, file: !210, line: 862, baseType: !18, size: 8, align: 8, elements: !626)
!626 = !{!627, !628, !629}
!627 = !DIEnumerator(name: "Exe", value: 0, isUnsigned: true)
!628 = !DIEnumerator(name: "Lib", value: 1, isUnsigned: true)
!629 = !DIEnumerator(name: "Obj", value: 2, isUnsigned: true)
!630 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "crypto.SideChannelsMitigations", scope: !631, file: !631, line: 247, baseType: !18, size: 8, align: 8, elements: !632)
!631 = !DIFile(filename: "crypto.zig", directory: "/Users/sulky/.zvm/master/lib/std")
!632 = !{!633, !634, !635, !636}
!633 = !DIEnumerator(name: "none", value: 0, isUnsigned: true)
!634 = !DIEnumerator(name: "basic", value: 1, isUnsigned: true)
!635 = !DIEnumerator(name: "medium", value: 2, isUnsigned: true)
!636 = !DIEnumerator(name: "full", value: 3, isUnsigned: true)
!637 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "log.Level", scope: !638, file: !638, line: 50, baseType: !18, size: 8, align: 8, elements: !639)
!638 = !DIFile(filename: "log.zig", directory: "/Users/sulky/.zvm/master/lib/std")
!639 = !{!640, !641, !642, !643}
!640 = !DIEnumerator(name: "err", value: 0, isUnsigned: true)
!641 = !DIEnumerator(name: "warn", value: 1, isUnsigned: true)
!642 = !DIEnumerator(name: "info", value: 2, isUnsigned: true)
!643 = !DIEnumerator(name: "debug", value: 3, isUnsigned: true)
!644 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "builtin.OptimizeMode", scope: !210, file: !210, line: 112, baseType: !18, size: 8, align: 8, elements: !645)
!645 = !{!646, !647, !648, !649}
!646 = !DIEnumerator(name: "Debug", value: 0, isUnsigned: true)
!647 = !DIEnumerator(name: "ReleaseSafe", value: 1, isUnsigned: true)
!648 = !DIEnumerator(name: "ReleaseFast", value: 2, isUnsigned: true)
!649 = !DIEnumerator(name: "ReleaseSmall", value: 3, isUnsigned: true)
!650 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "c.darwin.E", scope: !651, file: !651, line: 1270, baseType: !652, size: 16, align: 16, elements: !653)
!651 = !DIFile(filename: "darwin.zig", directory: "/Users/sulky/.zvm/master/lib/std/c")
!652 = !DIBasicType(name: "u16", size: 16, encoding: DW_ATE_unsigned)
!653 = !{!654, !655, !656, !657, !658, !659, !660, !661, !662, !663, !664, !665, !666, !667, !668, !669, !670, !671, !672, !673, !674, !675, !676, !677, !678, !679, !680, !681, !682, !683, !684, !685, !686, !687, !688, !689, !690, !691, !692, !693, !694, !695, !696, !697, !698, !699, !700, !701, !702, !703, !704, !705, !706, !707, !708, !709, !710, !711, !712, !713, !714, !715, !716, !717, !718, !719, !720, !721, !722, !723, !724, !725, !726, !727, !728, !729, !730, !731, !732, !733, !734, !735, !736, !737, !738, !739, !740, !741, !742, !743, !744, !745, !746, !747, !748, !749, !750, !751, !752, !753, !754, !755, !756, !757, !758, !759}
!654 = !DIEnumerator(name: "SUCCESS", value: 0, isUnsigned: true)
!655 = !DIEnumerator(name: "PERM", value: 1, isUnsigned: true)
!656 = !DIEnumerator(name: "NOENT", value: 2, isUnsigned: true)
!657 = !DIEnumerator(name: "SRCH", value: 3, isUnsigned: true)
!658 = !DIEnumerator(name: "INTR", value: 4, isUnsigned: true)
!659 = !DIEnumerator(name: "IO", value: 5, isUnsigned: true)
!660 = !DIEnumerator(name: "NXIO", value: 6, isUnsigned: true)
!661 = !DIEnumerator(name: "2BIG", value: 7, isUnsigned: true)
!662 = !DIEnumerator(name: "NOEXEC", value: 8, isUnsigned: true)
!663 = !DIEnumerator(name: "BADF", value: 9, isUnsigned: true)
!664 = !DIEnumerator(name: "CHILD", value: 10, isUnsigned: true)
!665 = !DIEnumerator(name: "DEADLK", value: 11, isUnsigned: true)
!666 = !DIEnumerator(name: "NOMEM", value: 12, isUnsigned: true)
!667 = !DIEnumerator(name: "ACCES", value: 13, isUnsigned: true)
!668 = !DIEnumerator(name: "FAULT", value: 14, isUnsigned: true)
!669 = !DIEnumerator(name: "NOTBLK", value: 15, isUnsigned: true)
!670 = !DIEnumerator(name: "BUSY", value: 16, isUnsigned: true)
!671 = !DIEnumerator(name: "EXIST", value: 17, isUnsigned: true)
!672 = !DIEnumerator(name: "XDEV", value: 18, isUnsigned: true)
!673 = !DIEnumerator(name: "NODEV", value: 19, isUnsigned: true)
!674 = !DIEnumerator(name: "NOTDIR", value: 20, isUnsigned: true)
!675 = !DIEnumerator(name: "ISDIR", value: 21, isUnsigned: true)
!676 = !DIEnumerator(name: "INVAL", value: 22, isUnsigned: true)
!677 = !DIEnumerator(name: "NFILE", value: 23, isUnsigned: true)
!678 = !DIEnumerator(name: "MFILE", value: 24, isUnsigned: true)
!679 = !DIEnumerator(name: "NOTTY", value: 25, isUnsigned: true)
!680 = !DIEnumerator(name: "TXTBSY", value: 26, isUnsigned: true)
!681 = !DIEnumerator(name: "FBIG", value: 27, isUnsigned: true)
!682 = !DIEnumerator(name: "NOSPC", value: 28, isUnsigned: true)
!683 = !DIEnumerator(name: "SPIPE", value: 29, isUnsigned: true)
!684 = !DIEnumerator(name: "ROFS", value: 30, isUnsigned: true)
!685 = !DIEnumerator(name: "MLINK", value: 31, isUnsigned: true)
!686 = !DIEnumerator(name: "PIPE", value: 32, isUnsigned: true)
!687 = !DIEnumerator(name: "DOM", value: 33, isUnsigned: true)
!688 = !DIEnumerator(name: "RANGE", value: 34, isUnsigned: true)
!689 = !DIEnumerator(name: "AGAIN", value: 35, isUnsigned: true)
!690 = !DIEnumerator(name: "INPROGRESS", value: 36, isUnsigned: true)
!691 = !DIEnumerator(name: "ALREADY", value: 37, isUnsigned: true)
!692 = !DIEnumerator(name: "NOTSOCK", value: 38, isUnsigned: true)
!693 = !DIEnumerator(name: "DESTADDRREQ", value: 39, isUnsigned: true)
!694 = !DIEnumerator(name: "MSGSIZE", value: 40, isUnsigned: true)
!695 = !DIEnumerator(name: "PROTOTYPE", value: 41, isUnsigned: true)
!696 = !DIEnumerator(name: "NOPROTOOPT", value: 42, isUnsigned: true)
!697 = !DIEnumerator(name: "PROTONOSUPPORT", value: 43, isUnsigned: true)
!698 = !DIEnumerator(name: "SOCKTNOSUPPORT", value: 44, isUnsigned: true)
!699 = !DIEnumerator(name: "OPNOTSUPP", value: 45, isUnsigned: true)
!700 = !DIEnumerator(name: "PFNOSUPPORT", value: 46, isUnsigned: true)
!701 = !DIEnumerator(name: "AFNOSUPPORT", value: 47, isUnsigned: true)
!702 = !DIEnumerator(name: "ADDRINUSE", value: 48, isUnsigned: true)
!703 = !DIEnumerator(name: "ADDRNOTAVAIL", value: 49, isUnsigned: true)
!704 = !DIEnumerator(name: "NETDOWN", value: 50, isUnsigned: true)
!705 = !DIEnumerator(name: "NETUNREACH", value: 51, isUnsigned: true)
!706 = !DIEnumerator(name: "NETRESET", value: 52, isUnsigned: true)
!707 = !DIEnumerator(name: "CONNABORTED", value: 53, isUnsigned: true)
!708 = !DIEnumerator(name: "CONNRESET", value: 54, isUnsigned: true)
!709 = !DIEnumerator(name: "NOBUFS", value: 55, isUnsigned: true)
!710 = !DIEnumerator(name: "ISCONN", value: 56, isUnsigned: true)
!711 = !DIEnumerator(name: "NOTCONN", value: 57, isUnsigned: true)
!712 = !DIEnumerator(name: "SHUTDOWN", value: 58, isUnsigned: true)
!713 = !DIEnumerator(name: "TOOMANYREFS", value: 59, isUnsigned: true)
!714 = !DIEnumerator(name: "TIMEDOUT", value: 60, isUnsigned: true)
!715 = !DIEnumerator(name: "CONNREFUSED", value: 61, isUnsigned: true)
!716 = !DIEnumerator(name: "LOOP", value: 62, isUnsigned: true)
!717 = !DIEnumerator(name: "NAMETOOLONG", value: 63, isUnsigned: true)
!718 = !DIEnumerator(name: "HOSTDOWN", value: 64, isUnsigned: true)
!719 = !DIEnumerator(name: "HOSTUNREACH", value: 65, isUnsigned: true)
!720 = !DIEnumerator(name: "NOTEMPTY", value: 66, isUnsigned: true)
!721 = !DIEnumerator(name: "PROCLIM", value: 67, isUnsigned: true)
!722 = !DIEnumerator(name: "USERS", value: 68, isUnsigned: true)
!723 = !DIEnumerator(name: "DQUOT", value: 69, isUnsigned: true)
!724 = !DIEnumerator(name: "STALE", value: 70, isUnsigned: true)
!725 = !DIEnumerator(name: "REMOTE", value: 71, isUnsigned: true)
!726 = !DIEnumerator(name: "BADRPC", value: 72, isUnsigned: true)
!727 = !DIEnumerator(name: "RPCMISMATCH", value: 73, isUnsigned: true)
!728 = !DIEnumerator(name: "PROGUNAVAIL", value: 74, isUnsigned: true)
!729 = !DIEnumerator(name: "PROGMISMATCH", value: 75, isUnsigned: true)
!730 = !DIEnumerator(name: "PROCUNAVAIL", value: 76, isUnsigned: true)
!731 = !DIEnumerator(name: "NOLCK", value: 77, isUnsigned: true)
!732 = !DIEnumerator(name: "NOSYS", value: 78, isUnsigned: true)
!733 = !DIEnumerator(name: "FTYPE", value: 79, isUnsigned: true)
!734 = !DIEnumerator(name: "AUTH", value: 80, isUnsigned: true)
!735 = !DIEnumerator(name: "NEEDAUTH", value: 81, isUnsigned: true)
!736 = !DIEnumerator(name: "PWROFF", value: 82, isUnsigned: true)
!737 = !DIEnumerator(name: "DEVERR", value: 83, isUnsigned: true)
!738 = !DIEnumerator(name: "OVERFLOW", value: 84, isUnsigned: true)
!739 = !DIEnumerator(name: "BADEXEC", value: 85, isUnsigned: true)
!740 = !DIEnumerator(name: "BADARCH", value: 86, isUnsigned: true)
!741 = !DIEnumerator(name: "SHLIBVERS", value: 87, isUnsigned: true)
!742 = !DIEnumerator(name: "BADMACHO", value: 88, isUnsigned: true)
!743 = !DIEnumerator(name: "CANCELED", value: 89, isUnsigned: true)
!744 = !DIEnumerator(name: "IDRM", value: 90, isUnsigned: true)
!745 = !DIEnumerator(name: "NOMSG", value: 91, isUnsigned: true)
!746 = !DIEnumerator(name: "ILSEQ", value: 92, isUnsigned: true)
!747 = !DIEnumerator(name: "NOATTR", value: 93, isUnsigned: true)
!748 = !DIEnumerator(name: "BADMSG", value: 94, isUnsigned: true)
!749 = !DIEnumerator(name: "MULTIHOP", value: 95, isUnsigned: true)
!750 = !DIEnumerator(name: "NODATA", value: 96, isUnsigned: true)
!751 = !DIEnumerator(name: "NOLINK", value: 97, isUnsigned: true)
!752 = !DIEnumerator(name: "NOSR", value: 98, isUnsigned: true)
!753 = !DIEnumerator(name: "NOSTR", value: 99, isUnsigned: true)
!754 = !DIEnumerator(name: "PROTO", value: 100, isUnsigned: true)
!755 = !DIEnumerator(name: "TIME", value: 101, isUnsigned: true)
!756 = !DIEnumerator(name: "NOPOLICY", value: 103, isUnsigned: true)
!757 = !DIEnumerator(name: "NOTRECOVERABLE", value: 104, isUnsigned: true)
!758 = !DIEnumerator(name: "OWNERDEAD", value: 105, isUnsigned: true)
!759 = !DIEnumerator(name: "QFULL", value: 106, isUnsigned: true)
!760 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "@typeInfo(Io.Operation).@\22union\22.tag_type.?", scope: !761, file: !25, line: 447, baseType: !18, size: 8, align: 8, elements: !830)
!761 = !DICompositeType(tag: DW_TAG_structure_type, name: "Io.Operation", scope: !25, file: !25, line: 447, size: 448, align: 64, elements: !762)
!762 = !{!763, !829}
!763 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !761, baseType: !764, size: 384, align: 64)
!764 = !DICompositeType(tag: DW_TAG_union_type, name: "Io.Operation:Payload", scope: !25, file: !25, line: 447, size: 384, align: 64, elements: !765)
!765 = !{!766, !791, !803, !812}
!766 = !DIDerivedType(tag: DW_TAG_member, name: "file_read_streaming", scope: !764, baseType: !767, size: 192)
!767 = !DICompositeType(tag: DW_TAG_structure_type, name: "Io.Operation.FileReadStreaming", scope: !761, file: !25, line: 294, size: 192, align: 64, elements: !768)
!768 = !{!769, !780}
!769 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !767, baseType: !770, size: 128, align: 64)
!770 = !DICompositeType(tag: DW_TAG_structure_type, name: "[]const []u8", scope: !4, size: 128, align: 64, elements: !771)
!771 = !{!772, !779}
!772 = !DIDerivedType(tag: DW_TAG_member, name: "ptr", scope: !770, baseType: !773, size: 64, align: 64)
!773 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "[*]const []u8", scope: !4, baseType: !774, size: 64, align: 64)
!774 = !DICompositeType(tag: DW_TAG_structure_type, name: "[]u8", scope: !4, size: 128, align: 64, elements: !775)
!775 = !{!776, !778}
!776 = !DIDerivedType(tag: DW_TAG_member, name: "ptr", scope: !774, baseType: !777, size: 64, align: 64)
!777 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "[*]u8", scope: !4, baseType: !116, size: 64, align: 64)
!778 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !774, baseType: !73, size: 64, align: 64, offset: 64)
!779 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !770, baseType: !73, size: 64, align: 64, offset: 64)
!780 = !DIDerivedType(tag: DW_TAG_member, name: "file", scope: !767, baseType: !781, size: 64, align: 32, offset: 128)
!781 = !DICompositeType(tag: DW_TAG_structure_type, name: "Io.File", scope: !782, file: !782, line: 757, size: 64, align: 32, elements: !783)
!782 = !DIFile(filename: "File.zig", directory: "/Users/sulky/.zvm/master/lib/std/Io")
!783 = !{!784, !786}
!784 = !DIDerivedType(tag: DW_TAG_member, name: "handle", scope: !781, baseType: !785, size: 32, align: 32)
!785 = !DIBasicType(name: "i32", size: 32, encoding: DW_ATE_signed)
!786 = !DIDerivedType(tag: DW_TAG_member, name: "flags", scope: !781, baseType: !787, size: 8, align: 8, offset: 32)
!787 = !DICompositeType(tag: DW_TAG_structure_type, name: "Io.File.Flags", scope: !782, file: !782, line: 15, size: 8, align: 8, elements: !788)
!788 = !{!789}
!789 = !DIDerivedType(tag: DW_TAG_member, name: "nonblocking", scope: !787, baseType: !790, size: 8, align: 8)
!790 = !DIBasicType(name: "bool", size: 8, encoding: DW_ATE_boolean)
!791 = !DIDerivedType(tag: DW_TAG_member, name: "file_write_streaming", scope: !764, baseType: !792, size: 384)
!792 = !DICompositeType(tag: DW_TAG_structure_type, name: "Io.Operation.FileWriteStreaming", scope: !761, file: !25, line: 328, size: 384, align: 64, elements: !793)
!793 = !{!794, !795, !801, !802}
!794 = !DIDerivedType(tag: DW_TAG_member, name: "header", scope: !792, baseType: !112, size: 128, align: 64)
!795 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !792, baseType: !796, size: 128, align: 64, offset: 128)
!796 = !DICompositeType(tag: DW_TAG_structure_type, name: "[]const []const u8", scope: !4, size: 128, align: 64, elements: !797)
!797 = !{!798, !800}
!798 = !DIDerivedType(tag: DW_TAG_member, name: "ptr", scope: !796, baseType: !799, size: 64, align: 64)
!799 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "[*]const []const u8", scope: !4, baseType: !112, size: 64, align: 64)
!800 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !796, baseType: !73, size: 64, align: 64, offset: 64)
!801 = !DIDerivedType(tag: DW_TAG_member, name: "splat", scope: !792, baseType: !73, size: 64, align: 64, offset: 256)
!802 = !DIDerivedType(tag: DW_TAG_member, name: "file", scope: !792, baseType: !781, size: 64, align: 32, offset: 320)
!803 = !DIDerivedType(tag: DW_TAG_member, name: "device_io_control", scope: !764, baseType: !804, size: 192)
!804 = !DICompositeType(tag: DW_TAG_structure_type, name: "Io.Operation.DeviceIoControl__struct_2997", scope: !761, file: !25, line: 349, size: 192, align: 64, elements: !805)
!805 = !{!806, !810, !811}
!806 = !DIDerivedType(tag: DW_TAG_member, name: "arg", scope: !804, baseType: !807, size: 64, align: 64)
!807 = !DIDerivedType(tag: DW_TAG_typedef, name: "?*anyopaque", scope: !4, baseType: !808, size: 64, align: 64)
!808 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*anyopaque", scope: !4, baseType: !809, size: 64, align: 64)
!809 = !DIBasicType(name: "anyopaque", encoding: DW_ATE_signed)
!810 = !DIDerivedType(tag: DW_TAG_member, name: "file", scope: !804, baseType: !781, size: 64, align: 32, offset: 64)
!811 = !DIDerivedType(tag: DW_TAG_member, name: "code", scope: !804, baseType: !33, size: 32, align: 32, offset: 128)
!812 = !DIDerivedType(tag: DW_TAG_member, name: "net_receive", scope: !764, baseType: !813, size: 320)
!813 = !DICompositeType(tag: DW_TAG_structure_type, name: "Io.Operation.NetReceive", scope: !761, file: !25, line: 386, size: 320, align: 64, elements: !814)
!814 = !{!815, !822, !823, !824}
!815 = !DIDerivedType(tag: DW_TAG_member, name: "message_buffer", scope: !813, baseType: !816, size: 128, align: 64)
!816 = !DICompositeType(tag: DW_TAG_structure_type, name: "[]Io.net.IncomingMessage", scope: !4, size: 128, align: 64, elements: !817)
!817 = !{!818, !821}
!818 = !DIDerivedType(tag: DW_TAG_member, name: "ptr", scope: !816, baseType: !819, size: 64, align: 64)
!819 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "[*]Io.net.IncomingMessage", scope: !4, baseType: !820, size: 64, align: 64)
!820 = !DIBasicType(name: "Io.net.IncomingMessage", encoding: DW_ATE_signed)
!821 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !816, baseType: !73, size: 64, align: 64, offset: 64)
!822 = !DIDerivedType(tag: DW_TAG_member, name: "data_buffer", scope: !813, baseType: !774, size: 128, align: 64, offset: 128)
!823 = !DIDerivedType(tag: DW_TAG_member, name: "socket_handle", scope: !813, baseType: !785, size: 32, align: 32, offset: 256)
!824 = !DIDerivedType(tag: DW_TAG_member, name: "flags", scope: !813, baseType: !825, size: 8, align: 8, offset: 288)
!825 = !DICompositeType(tag: DW_TAG_structure_type, name: "Io.net.ReceiveFlags", scope: !826, file: !826, line: 917, size: 8, align: 8, elements: !827)
!826 = !DIFile(filename: "net.zig", directory: "/Users/sulky/.zvm/master/lib/std/Io")
!827 = !{!828}
!828 = !DIDerivedType(tag: DW_TAG_member, name: "bits", scope: !825, baseType: !116, size: 8, align: 8)
!829 = !DIDerivedType(tag: DW_TAG_member, name: "tag", scope: !761, baseType: !760, size: 8, align: 8, offset: 384)
!830 = !{!831, !832, !833, !834}
!831 = !DIEnumerator(name: "file_read_streaming", value: 0, isUnsigned: true)
!832 = !DIEnumerator(name: "file_write_streaming", value: 1, isUnsigned: true)
!833 = !DIEnumerator(name: "device_io_control", value: 2, isUnsigned: true)
!834 = !DIEnumerator(name: "net_receive", value: 3, isUnsigned: true)
!835 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "mem.Alignment", scope: !836, file: !836, line: 80, baseType: !165, size: 8, align: 8, elements: !837)
!836 = !DIFile(filename: "mem.zig", directory: "/Users/sulky/.zvm/master/lib/std")
!837 = !{!838, !839, !840, !841, !842, !843, !844}
!838 = !DIEnumerator(name: "1", value: 0, isUnsigned: true)
!839 = !DIEnumerator(name: "2", value: 1, isUnsigned: true)
!840 = !DIEnumerator(name: "4", value: 2, isUnsigned: true)
!841 = !DIEnumerator(name: "8", value: 3, isUnsigned: true)
!842 = !DIEnumerator(name: "16", value: 4, isUnsigned: true)
!843 = !DIEnumerator(name: "32", value: 5, isUnsigned: true)
!844 = !DIEnumerator(name: "64", value: 6, isUnsigned: true)
!845 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "anyerror", scope: !4, baseType: !846, size: 16, align: 16, elements: !847)
!846 = !DIBasicType(size: 16, encoding: DW_ATE_unsigned)
!847 = !{!848, !849, !850, !851, !852, !853, !854, !855, !856, !857, !858, !859, !860, !861, !862, !863, !864, !865, !866, !867, !868, !869, !870, !871, !872, !873, !874, !875, !876, !877, !878, !879, !880, !881, !882, !883, !884, !885, !886, !887, !888, !889, !890, !891, !892, !893, !894, !895, !896, !897, !898, !899, !900, !901, !902, !903, !904, !905, !906, !907, !908, !909, !910, !911, !912, !913, !914, !915, !916, !917, !918, !919, !920, !921, !922, !923, !924, !925, !926, !927, !928, !929, !930, !931, !932, !933, !934, !935, !936, !937, !938, !939, !940, !941, !942, !943, !944, !945, !946, !947, !948, !949}
!848 = !DIEnumerator(name: "null", value: 0, isUnsigned: true)
!849 = !DIEnumerator(name: "error.PermissionDenied", value: 1, isUnsigned: true)
!850 = !DIEnumerator(name: "error.SystemResources", value: 2, isUnsigned: true)
!851 = !DIEnumerator(name: "error.Unsupported", value: 3, isUnsigned: true)
!852 = !DIEnumerator(name: "error.Unexpected", value: 4, isUnsigned: true)
!853 = !DIEnumerator(name: "error.DiskQuota", value: 5, isUnsigned: true)
!854 = !DIEnumerator(name: "error.FileTooBig", value: 6, isUnsigned: true)
!855 = !DIEnumerator(name: "error.InputOutput", value: 7, isUnsigned: true)
!856 = !DIEnumerator(name: "error.NoSpaceLeft", value: 8, isUnsigned: true)
!857 = !DIEnumerator(name: "error.DeviceBusy", value: 9, isUnsigned: true)
!858 = !DIEnumerator(name: "error.AccessDenied", value: 10, isUnsigned: true)
!859 = !DIEnumerator(name: "error.BrokenPipe", value: 11, isUnsigned: true)
!860 = !DIEnumerator(name: "error.NotOpenForWriting", value: 12, isUnsigned: true)
!861 = !DIEnumerator(name: "error.LockViolation", value: 13, isUnsigned: true)
!862 = !DIEnumerator(name: "error.WouldBlock", value: 14, isUnsigned: true)
!863 = !DIEnumerator(name: "error.NoDevice", value: 15, isUnsigned: true)
!864 = !DIEnumerator(name: "error.FileBusy", value: 16, isUnsigned: true)
!865 = !DIEnumerator(name: "error.Canceled", value: 17, isUnsigned: true)
!866 = !DIEnumerator(name: "error.Unimplemented", value: 18, isUnsigned: true)
!867 = !DIEnumerator(name: "error.CorruptedData", value: 19, isUnsigned: true)
!868 = !DIEnumerator(name: "error.EndOfStream", value: 20, isUnsigned: true)
!869 = !DIEnumerator(name: "error.ReadFailed", value: 21, isUnsigned: true)
!870 = !DIEnumerator(name: "error.Unseekable", value: 22, isUnsigned: true)
!871 = !DIEnumerator(name: "error.UnsupportedOperation", value: 23, isUnsigned: true)
!872 = !DIEnumerator(name: "error.EnvironmentVariableMissing", value: 24, isUnsigned: true)
!873 = !DIEnumerator(name: "error.UnrecognizedFormat", value: 25, isUnsigned: true)
!874 = !DIEnumerator(name: "error.OutOfMemory", value: 26, isUnsigned: true)
!875 = !DIEnumerator(name: "error.SizeTooSmall", value: 27, isUnsigned: true)
!876 = !DIEnumerator(name: "error.WriteFailed", value: 28, isUnsigned: true)
!877 = !DIEnumerator(name: "error.IsDir", value: 29, isUnsigned: true)
!878 = !DIEnumerator(name: "error.ConnectionResetByPeer", value: 30, isUnsigned: true)
!879 = !DIEnumerator(name: "error.NotOpenForReading", value: 31, isUnsigned: true)
!880 = !DIEnumerator(name: "error.SocketUnconnected", value: 32, isUnsigned: true)
!881 = !DIEnumerator(name: "error.ProcessFdQuotaExceeded", value: 33, isUnsigned: true)
!882 = !DIEnumerator(name: "error.SystemFdQuotaExceeded", value: 34, isUnsigned: true)
!883 = !DIEnumerator(name: "error.MessageOversize", value: 35, isUnsigned: true)
!884 = !DIEnumerator(name: "error.NetworkDown", value: 36, isUnsigned: true)
!885 = !DIEnumerator(name: "error.PortUnreachable", value: 37, isUnsigned: true)
!886 = !DIEnumerator(name: "error.ConcurrencyUnavailable", value: 38, isUnsigned: true)
!887 = !DIEnumerator(name: "error.Timeout", value: 39, isUnsigned: true)
!888 = !DIEnumerator(name: "error.PathAlreadyExists", value: 40, isUnsigned: true)
!889 = !DIEnumerator(name: "error.SymLinkLoop", value: 41, isUnsigned: true)
!890 = !DIEnumerator(name: "error.LinkQuotaExceeded", value: 42, isUnsigned: true)
!891 = !DIEnumerator(name: "error.FileNotFound", value: 43, isUnsigned: true)
!892 = !DIEnumerator(name: "error.NotDir", value: 44, isUnsigned: true)
!893 = !DIEnumerator(name: "error.ReadOnlyFileSystem", value: 45, isUnsigned: true)
!894 = !DIEnumerator(name: "error.NetworkNotFound", value: 46, isUnsigned: true)
!895 = !DIEnumerator(name: "error.NameTooLong", value: 47, isUnsigned: true)
!896 = !DIEnumerator(name: "error.BadPathName", value: 48, isUnsigned: true)
!897 = !DIEnumerator(name: "error.PipeBusy", value: 49, isUnsigned: true)
!898 = !DIEnumerator(name: "error.AntivirusInterference", value: 50, isUnsigned: true)
!899 = !DIEnumerator(name: "error.FileLocksUnsupported", value: 51, isUnsigned: true)
!900 = !DIEnumerator(name: "error.Streaming", value: 52, isUnsigned: true)
!901 = !DIEnumerator(name: "error.OperationUnsupported", value: 53, isUnsigned: true)
!902 = !DIEnumerator(name: "error.FileSystem", value: 54, isUnsigned: true)
!903 = !DIEnumerator(name: "error.UnrecognizedVolume", value: 55, isUnsigned: true)
!904 = !DIEnumerator(name: "error.DirNotEmpty", value: 56, isUnsigned: true)
!905 = !DIEnumerator(name: "error.CrossDevice", value: 57, isUnsigned: true)
!906 = !DIEnumerator(name: "error.HardwareFailure", value: 58, isUnsigned: true)
!907 = !DIEnumerator(name: "error.NotLink", value: 59, isUnsigned: true)
!908 = !DIEnumerator(name: "error.UnsupportedReparsePointType", value: 60, isUnsigned: true)
!909 = !DIEnumerator(name: "error.NotTerminalDevice", value: 61, isUnsigned: true)
!910 = !DIEnumerator(name: "error.NonResizable", value: 62, isUnsigned: true)
!911 = !DIEnumerator(name: "error.LockedMemoryLimitExceeded", value: 63, isUnsigned: true)
!912 = !DIEnumerator(name: "error.ProcessNotFound", value: 64, isUnsigned: true)
!913 = !DIEnumerator(name: "error.CurrentDirUnlinked", value: 65, isUnsigned: true)
!914 = !DIEnumerator(name: "error.InvalidWtf8", value: 66, isUnsigned: true)
!915 = !DIEnumerator(name: "error.InvalidExe", value: 67, isUnsigned: true)
!916 = !DIEnumerator(name: "error.InvalidBatchScriptArg", value: 68, isUnsigned: true)
!917 = !DIEnumerator(name: "error.ResourceLimitReached", value: 69, isUnsigned: true)
!918 = !DIEnumerator(name: "error.InvalidUserId", value: 70, isUnsigned: true)
!919 = !DIEnumerator(name: "error.InvalidProcessGroupId", value: 71, isUnsigned: true)
!920 = !DIEnumerator(name: "error.InvalidName", value: 72, isUnsigned: true)
!921 = !DIEnumerator(name: "error.ProcessAlreadyExec", value: 73, isUnsigned: true)
!922 = !DIEnumerator(name: "error.ClockUnavailable", value: 74, isUnsigned: true)
!923 = !DIEnumerator(name: "error.EntropyUnavailable", value: 75, isUnsigned: true)
!924 = !DIEnumerator(name: "error.AddressInUse", value: 76, isUnsigned: true)
!925 = !DIEnumerator(name: "error.AddressUnavailable", value: 77, isUnsigned: true)
!926 = !DIEnumerator(name: "error.AddressFamilyUnsupported", value: 78, isUnsigned: true)
!927 = !DIEnumerator(name: "error.ProtocolUnsupportedBySystem", value: 79, isUnsigned: true)
!928 = !DIEnumerator(name: "error.ProtocolUnsupportedByAddressFamily", value: 80, isUnsigned: true)
!929 = !DIEnumerator(name: "error.SocketModeUnsupported", value: 81, isUnsigned: true)
!930 = !DIEnumerator(name: "error.OptionUnsupported", value: 82, isUnsigned: true)
!931 = !DIEnumerator(name: "error.SocketNotListening", value: 83, isUnsigned: true)
!932 = !DIEnumerator(name: "error.ConnectionAborted", value: 84, isUnsigned: true)
!933 = !DIEnumerator(name: "error.BlockedByFirewall", value: 85, isUnsigned: true)
!934 = !DIEnumerator(name: "error.ProtocolFailure", value: 86, isUnsigned: true)
!935 = !DIEnumerator(name: "error.ConnectionPending", value: 87, isUnsigned: true)
!936 = !DIEnumerator(name: "error.ConnectionRefused", value: 88, isUnsigned: true)
!937 = !DIEnumerator(name: "error.HostUnreachable", value: 89, isUnsigned: true)
!938 = !DIEnumerator(name: "error.NetworkUnreachable", value: 90, isUnsigned: true)
!939 = !DIEnumerator(name: "error.FastOpenAlreadyInProgress", value: 91, isUnsigned: true)
!940 = !DIEnumerator(name: "error.SocketNotBound", value: 92, isUnsigned: true)
!941 = !DIEnumerator(name: "error.InterfaceNotFound", value: 93, isUnsigned: true)
!942 = !DIEnumerator(name: "error.UnknownHostName", value: 94, isUnsigned: true)
!943 = !DIEnumerator(name: "error.ResolvConfParseFailed", value: 95, isUnsigned: true)
!944 = !DIEnumerator(name: "error.InvalidDnsARecord", value: 96, isUnsigned: true)
!945 = !DIEnumerator(name: "error.InvalidDnsAAAARecord", value: 97, isUnsigned: true)
!946 = !DIEnumerator(name: "error.InvalidDnsCnameRecord", value: 98, isUnsigned: true)
!947 = !DIEnumerator(name: "error.NameServerFailure", value: 99, isUnsigned: true)
!948 = !DIEnumerator(name: "error.NoAddressReturned", value: 100, isUnsigned: true)
!949 = !DIEnumerator(name: "error.DetectingNetworkConfigurationFailed", value: 101, isUnsigned: true)
!950 = !{!951, !954, !956, !958, !960, !963, !965, !967, !969, !971, !987, !989, !992, !994, !997, !999, !1001, !1003, !1005, !1007, !1009, !1011, !1013, !1015, !1017, !1019, !1021, !1799, !1803, !1806, !1808, !1811, !1813, !1815, !1817, !1845, !1847, !0, !1849, !1863, !1865, !1867, !1869, !1871, !1873, !1875, !1877, !1879, !1881, !1883, !1885, !1887, !1889, !1891, !1893, !1895, !1897}
!951 = !DIGlobalVariableExpression(var: !952, expr: !DIExpression())
!952 = distinct !DIGlobalVariable(name: "output_mode", linkageName: "builtin.output_mode", scope: !953, file: !953, line: 8, type: !625, isLocal: true, isDefinition: true)
!953 = !DIFile(filename: "builtin.zig", directory: "/Users/sulky/.cache/zig/b/06407eda9f0eca61b8ec3e8a563fea22")
!954 = !DIGlobalVariableExpression(var: !955, expr: !DIExpression())
!955 = distinct !DIGlobalVariable(name: "link_libc", linkageName: "builtin.link_libc", scope: !953, file: !953, line: 109, type: !790, isLocal: true, isDefinition: true)
!956 = !DIGlobalVariableExpression(var: !957, expr: !DIExpression())
!957 = distinct !DIGlobalVariable(name: "empty", linkageName: "Target.Cpu.Feature.Set.empty", scope: !92, file: !92, line: 1214, type: !557, isLocal: true, isDefinition: true)
!958 = !DIGlobalVariableExpression(var: !959, expr: !DIExpression())
!959 = distinct !DIGlobalVariable(name: "cpu", linkageName: "builtin.cpu", scope: !953, file: !953, line: 14, type: !542, isLocal: true, isDefinition: true)
!960 = !DIGlobalVariableExpression(var: !961, expr: !DIExpression())
!961 = distinct !DIGlobalVariable(name: "native_arch", linkageName: "start.native_arch", scope: !962, file: !962, line: 4, type: !541, isLocal: true, isDefinition: true)
!962 = !DIFile(filename: "start.zig", directory: "/Users/sulky/.zvm/master/lib/std")
!963 = !DIGlobalVariableExpression(var: !964, expr: !DIExpression())
!964 = distinct !DIGlobalVariable(name: "is_wasm", linkageName: "start.is_wasm", scope: !962, file: !962, line: 6, type: !790, isLocal: true, isDefinition: true)
!965 = !DIGlobalVariableExpression(var: !966, expr: !DIExpression())
!966 = distinct !DIGlobalVariable(name: "os", linkageName: "builtin.os", scope: !953, file: !953, line: 85, type: !93, isLocal: true, isDefinition: true)
!967 = !DIGlobalVariableExpression(var: !968, expr: !DIExpression())
!968 = distinct !DIGlobalVariable(name: "abi", linkageName: "builtin.abi", scope: !953, file: !953, line: 13, type: !511, isLocal: true, isDefinition: true)
!969 = !DIGlobalVariableExpression(var: !970, expr: !DIExpression())
!970 = distinct !DIGlobalVariable(name: "object_format", linkageName: "builtin.object_format", scope: !953, file: !953, line: 107, type: !500, isLocal: true, isDefinition: true)
!971 = !DIGlobalVariableExpression(var: !972, expr: !DIExpression())
!972 = distinct !DIGlobalVariable(name: "target", linkageName: "builtin.target", scope: !953, file: !953, line: 100, type: !973, isLocal: true, isDefinition: true)
!973 = !DICompositeType(tag: DW_TAG_structure_type, name: "Target", scope: !92, file: !92, line: 3739, size: 4032, align: 64, elements: !974)
!974 = !{!975, !976, !977, !978, !979}
!975 = !DIDerivedType(tag: DW_TAG_member, name: "cpu", scope: !973, baseType: !542, size: 448, align: 64)
!976 = !DIDerivedType(tag: DW_TAG_member, name: "os", scope: !973, baseType: !93, size: 1472, align: 64, offset: 448)
!977 = !DIDerivedType(tag: DW_TAG_member, name: "abi", scope: !973, baseType: !511, size: 8, align: 8, offset: 1920)
!978 = !DIDerivedType(tag: DW_TAG_member, name: "ofmt", scope: !973, baseType: !500, size: 8, align: 8, offset: 1928)
!979 = !DIDerivedType(tag: DW_TAG_member, name: "dynamic_linker", scope: !973, baseType: !980, size: 2048, align: 8, offset: 1936)
!980 = !DICompositeType(tag: DW_TAG_structure_type, name: "Target.DynamicLinker", scope: !92, file: !92, line: 2828, size: 2048, align: 8, elements: !981)
!981 = !{!982, !986}
!982 = !DIDerivedType(tag: DW_TAG_member, name: "buffer", scope: !980, baseType: !983, size: 2040, align: 8)
!983 = !DICompositeType(tag: DW_TAG_array_type, name: "[255]u8", scope: !4, baseType: !116, size: 2040, align: 8, elements: !984)
!984 = !{!985}
!985 = !DISubrange(count: 255, lowerBound: 0)
!986 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !980, baseType: !116, size: 8, align: 8, offset: 2040)
!987 = !DIGlobalVariableExpression(var: !988, expr: !DIExpression())
!988 = distinct !DIGlobalVariable(name: "c", linkageName: "builtin.CallingConvention.c", scope: !210, file: !210, line: 130, type: !211, isLocal: true, isDefinition: true)
!989 = !DIGlobalVariableExpression(var: !990, expr: !DIExpression())
!990 = distinct !DIGlobalVariable(name: "native_os", linkageName: "process.Environ.native_os", scope: !991, file: !991, line: 4, type: !91, isLocal: true, isDefinition: true)
!991 = !DIFile(filename: "Environ.zig", directory: "/Users/sulky/.zvm/master/lib/std/process")
!992 = !DIGlobalVariableExpression(var: !993, expr: !DIExpression())
!993 = distinct !DIGlobalVariable(name: "native_os", linkageName: "Io.Threaded.native_os", scope: !8, file: !8, line: 4, type: !91, isLocal: true, isDefinition: true)
!994 = !DIGlobalVariableExpression(var: !995, expr: !DIExpression())
!995 = distinct !DIGlobalVariable(name: "use_libc", linkageName: "posix.use_libc", scope: !996, file: !996, line: 26, type: !790, isLocal: true, isDefinition: true)
!996 = !DIFile(filename: "posix.zig", directory: "/Users/sulky/.zvm/master/lib/std")
!997 = !DIGlobalVariableExpression(var: !998, expr: !DIExpression())
!998 = distinct !DIGlobalVariable(name: "native_os", linkageName: "c.native_os", scope: !39, file: !39, line: 4, type: !91, isLocal: true, isDefinition: true)
!999 = !DIGlobalVariableExpression(var: !1000, expr: !DIExpression())
!1000 = distinct !DIGlobalVariable(name: "have_sig_io", linkageName: "Io.Threaded.have_sig_io", scope: !8, file: !8, line: 1977, type: !790, isLocal: true, isDefinition: true)
!1001 = !DIGlobalVariableExpression(var: !1002, expr: !DIExpression())
!1002 = distinct !DIGlobalVariable(name: "have_sig_pipe", linkageName: "Io.Threaded.have_sig_pipe", scope: !8, file: !8, line: 1978, type: !790, isLocal: true, isDefinition: true)
!1003 = !DIGlobalVariableExpression(var: !1004, expr: !DIExpression())
!1004 = distinct !DIGlobalVariable(name: "have_sendfile", linkageName: "Io.Threaded.have_sendfile", scope: !8, file: !8, line: 1979, type: !790, isLocal: true, isDefinition: true)
!1005 = !DIGlobalVariableExpression(var: !1006, expr: !DIExpression())
!1006 = distinct !DIGlobalVariable(name: "have_copy_file_range", linkageName: "Io.Threaded.have_copy_file_range", scope: !8, file: !8, line: 1980, type: !790, isLocal: true, isDefinition: true)
!1007 = !DIGlobalVariableExpression(var: !1008, expr: !DIExpression())
!1008 = distinct !DIGlobalVariable(name: "is_darwin", linkageName: "Io.Threaded.is_darwin", scope: !8, file: !8, line: 6, type: !790, isLocal: true, isDefinition: true)
!1009 = !DIGlobalVariableExpression(var: !1010, expr: !DIExpression())
!1010 = distinct !DIGlobalVariable(name: "have_fcopyfile", linkageName: "Io.Threaded.have_fcopyfile", scope: !8, file: !8, line: 1984, type: !790, isLocal: true, isDefinition: true)
!1011 = !DIGlobalVariableExpression(var: !1012, expr: !DIExpression())
!1012 = distinct !DIGlobalVariable(name: "have_fchmodat2", linkageName: "Io.Threaded.have_fchmodat2", scope: !8, file: !8, line: 1985, type: !790, isLocal: true, isDefinition: true)
!1013 = !DIGlobalVariableExpression(var: !1014, expr: !DIExpression())
!1014 = distinct !DIGlobalVariable(name: "native_os", linkageName: "Thread.native_os", scope: !2, file: !2, line: 6, type: !91, isLocal: true, isDefinition: true)
!1015 = !DIGlobalVariableExpression(var: !1016, expr: !DIExpression())
!1016 = distinct !DIGlobalVariable(name: "use_dev_urandom", linkageName: "Io.Threaded.use_dev_urandom", scope: !8, file: !8, line: 2061, type: !790, isLocal: true, isDefinition: true)
!1017 = !DIGlobalVariableExpression(var: !1018, expr: !DIExpression())
!1018 = distinct !DIGlobalVariable(name: "is_windows", linkageName: "Io.Threaded.is_windows", scope: !8, file: !8, line: 5, type: !790, isLocal: true, isDefinition: true)
!1019 = !DIGlobalVariableExpression(var: !1020, expr: !DIExpression())
!1020 = distinct !DIGlobalVariable(name: "is_windows", linkageName: "Io.Terminal.is_windows", scope: !14, file: !14, line: 6, type: !790, isLocal: true, isDefinition: true)
!1021 = !DIGlobalVariableExpression(var: !1022, expr: !DIExpression())
!1022 = distinct !DIGlobalVariable(name: "global_single_threaded", linkageName: "Io.Threaded.global_single_threaded", scope: !8, file: !8, line: 1701, type: !1023, isLocal: true, isDefinition: true)
!1023 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*Io.Threaded", scope: !4, baseType: !1024, size: 64, align: 64)
!1024 = !DICompositeType(tag: DW_TAG_structure_type, name: "Io.Threaded", scope: !8, file: !8, line: 18906, size: 6784, align: 64, elements: !1025)
!1025 = !{!1026, !1647, !1655, !1667, !1668, !1676, !1677, !1678, !1679, !1686, !1718, !1739, !1740, !1741, !1742, !1768, !1769, !1783, !1787, !1788, !1791, !1792, !1793, !1794, !1795, !1796, !1797, !1798}
!1026 = !DIDerivedType(tag: DW_TAG_member, name: "stderr_writer", scope: !1024, baseType: !1027, size: 576, align: 64)
!1027 = !DICompositeType(tag: DW_TAG_structure_type, name: "Io.File.Writer", scope: !1028, file: !1028, line: 259, size: 576, align: 64, elements: !1029)
!1028 = !DIFile(filename: "Writer.zig", directory: "/Users/sulky/.zvm/master/lib/std/Io/File")
!1029 = !{!1030, !1594, !1595, !1638, !1639, !1642, !1644, !1646}
!1030 = !DIDerivedType(tag: DW_TAG_member, name: "io", scope: !1027, baseType: !1031, size: 128, align: 64)
!1031 = !DICompositeType(tag: DW_TAG_structure_type, name: "Io", scope: !25, file: !25, line: 3461, size: 128, align: 64, elements: !1032)
!1032 = !{!1033, !1034}
!1033 = !DIDerivedType(tag: DW_TAG_member, name: "userdata", scope: !1031, baseType: !807, size: 64, align: 64)
!1034 = !DIDerivedType(tag: DW_TAG_member, name: "vtable", scope: !1031, baseType: !1035, size: 64, align: 64, offset: 64)
!1035 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const Io.VTable", scope: !4, baseType: !1036, size: 64, align: 64)
!1036 = !DICompositeType(tag: DW_TAG_structure_type, name: "Io.VTable", scope: !25, file: !25, line: 254, size: 6976, align: 64, elements: !1037)
!1037 = !{!1038, !1042, !1053, !1063, !1067, !1068, !1077, !1085, !1094, !1098, !1099, !1102, !1106, !1108, !1113, !1114, !1150, !1156, !1158, !1162, !1164, !1166, !1168, !1170, !1172, !1174, !1176, !1178, !1180, !1182, !1192, !1210, !1212, !1214, !1216, !1218, !1220, !1222, !1224, !1226, !1228, !1230, !1232, !1234, !1236, !1238, !1240, !1251, !1260, !1270, !1282, !1292, !1302, !1312, !1316, !1325, !1334, !1343, !1344, !1353, !1367, !1369, !1371, !1373, !1375, !1379, !1388, !1398, !1400, !1402, !1408, !1417, !1425, !1433, !1435, !1445, !1447, !1449, !1450, !1460, !1462, !1471, !1473, !1475, !1477, !1479, !1481, !1487, !1497, !1499, !1501, !1503, !1507, !1516, !1518, !1520, !1522, !1524, !1526, !1538, !1540, !1542, !1557, !1567, !1577, !1586, !1588, !1590, !1592}
!1038 = !DIDerivedType(tag: DW_TAG_member, name: "crashHandler", scope: !1036, baseType: !1039, size: 64, align: 64)
!1039 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque) void", scope: !4, baseType: !1040, size: 64, align: 64)
!1040 = !DISubroutineType(types: !1041)
!1041 = !{!99, !807}
!1042 = !DIDerivedType(tag: DW_TAG_member, name: "async", scope: !1036, baseType: !1043, size: 64, align: 64, offset: 64)
!1043 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, []u8, mem.Alignment, []const u8, mem.Alignment, *const fn (*const anyopaque, *anyopaque) void) ?*Io.AnyFuture", scope: !4, baseType: !1044, size: 64, align: 64)
!1044 = !DISubroutineType(types: !1045)
!1045 = !{!1046, !807, !774, !835, !112, !835, !1049}
!1046 = !DIDerivedType(tag: DW_TAG_typedef, name: "?*Io.AnyFuture", scope: !4, baseType: !1047, size: 64, align: 64)
!1047 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*Io.AnyFuture", scope: !4, baseType: !1048, size: 64, align: 64)
!1048 = !DICompositeType(tag: DW_TAG_structure_type, name: "Io.AnyFuture", scope: !25, file: !25, line: 1174, align: 8)
!1049 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (*const anyopaque, *anyopaque) void", scope: !4, baseType: !1050, size: 64, align: 64)
!1050 = !DISubroutineType(types: !1051)
!1051 = !{!99, !1052, !808}
!1052 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const anyopaque", scope: !4, baseType: !809, size: 64, align: 64)
!1053 = !DIDerivedType(tag: DW_TAG_member, name: "concurrent", scope: !1036, baseType: !1054, size: 64, align: 64, offset: 128)
!1054 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, usize, mem.Alignment, []const u8, mem.Alignment, *const fn (*const anyopaque, *anyopaque) void) error{ConcurrencyUnavailable}!*Io.AnyFuture", scope: !4, baseType: !1055, size: 64, align: 64)
!1055 = !DISubroutineType(types: !1056)
!1056 = !{!99, !1057, !807, !73, !835, !112, !835, !1049}
!1057 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*error{ConcurrencyUnavailable}!*Io.AnyFuture", scope: !4, baseType: !1058, size: 64, align: 64)
!1058 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{ConcurrencyUnavailable}!*Io.AnyFuture", scope: !4, size: 128, align: 64, elements: !1059)
!1059 = !{!1060, !1062}
!1060 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1058, baseType: !1061, size: 16, align: 16, offset: 64)
!1061 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{ConcurrencyUnavailable}", scope: !4, baseType: !845, size: 16, align: 16)
!1062 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1058, baseType: !1047, size: 64, align: 64)
!1063 = !DIDerivedType(tag: DW_TAG_member, name: "await", scope: !1036, baseType: !1064, size: 64, align: 64, offset: 192)
!1064 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, *Io.AnyFuture, []u8, mem.Alignment) void", scope: !4, baseType: !1065, size: 64, align: 64)
!1065 = !DISubroutineType(types: !1066)
!1066 = !{!99, !807, !1047, !774, !835}
!1067 = !DIDerivedType(tag: DW_TAG_member, name: "cancel", scope: !1036, baseType: !1064, size: 64, align: 64, offset: 256)
!1068 = !DIDerivedType(tag: DW_TAG_member, name: "groupAsync", scope: !1036, baseType: !1069, size: 64, align: 64, offset: 320)
!1069 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, *Io.Group, []const u8, mem.Alignment, *const fn (*const anyopaque) void) void", scope: !4, baseType: !1070, size: 64, align: 64)
!1070 = !DISubroutineType(types: !1071)
!1071 = !{!99, !807, !1072, !112, !835, !1074}
!1072 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*Io.Group", scope: !4, baseType: !1073, size: 64, align: 64)
!1073 = !DIBasicType(name: "Io.Group", encoding: DW_ATE_signed)
!1074 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (*const anyopaque) void", scope: !4, baseType: !1075, size: 64, align: 64)
!1075 = !DISubroutineType(types: !1076)
!1076 = !{!99, !1052}
!1077 = !DIDerivedType(tag: DW_TAG_member, name: "groupConcurrent", scope: !1036, baseType: !1078, size: 64, align: 64, offset: 384)
!1078 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, *Io.Group, []const u8, mem.Alignment, *const fn (*const anyopaque) void) error{ConcurrencyUnavailable}!void", scope: !4, baseType: !1079, size: 64, align: 64)
!1079 = !DISubroutineType(types: !1080)
!1080 = !{!1081, !807, !1072, !112, !835, !1074}
!1081 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{ConcurrencyUnavailable}!void", scope: !4, size: 16, align: 16, elements: !1082)
!1082 = !{!1083, !1084}
!1083 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1081, baseType: !1061, size: 16, align: 16)
!1084 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1081, baseType: !99, align: 8, offset: 16)
!1085 = !DIDerivedType(tag: DW_TAG_member, name: "groupAwait", scope: !1036, baseType: !1086, size: 64, align: 64, offset: 448)
!1086 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, *Io.Group, *anyopaque) error{Canceled}!void", scope: !4, baseType: !1087, size: 64, align: 64)
!1087 = !DISubroutineType(types: !1088)
!1088 = !{!1089, !807, !1072, !808}
!1089 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{Canceled}!void", scope: !4, size: 16, align: 16, elements: !1090)
!1090 = !{!1091, !1093}
!1091 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1089, baseType: !1092, size: 16, align: 16)
!1092 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{Canceled}", scope: !4, baseType: !845, size: 16, align: 16)
!1093 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1089, baseType: !99, align: 8, offset: 16)
!1094 = !DIDerivedType(tag: DW_TAG_member, name: "groupCancel", scope: !1036, baseType: !1095, size: 64, align: 64, offset: 512)
!1095 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, *Io.Group, *anyopaque) void", scope: !4, baseType: !1096, size: 64, align: 64)
!1096 = !DISubroutineType(types: !1097)
!1097 = !{!99, !807, !1072, !808}
!1098 = !DIDerivedType(tag: DW_TAG_member, name: "recancel", scope: !1036, baseType: !1039, size: 64, align: 64, offset: 576)
!1099 = !DIDerivedType(tag: DW_TAG_member, name: "swapCancelProtection", scope: !1036, baseType: !1100, size: 64, align: 64, offset: 640)
!1100 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.CancelProtection) Io.CancelProtection", scope: !4, baseType: !1101, size: 64, align: 64)
!1101 = !DISubroutineType(types: null)
!1102 = !DIDerivedType(tag: DW_TAG_member, name: "checkCancel", scope: !1036, baseType: !1103, size: 64, align: 64, offset: 704)
!1103 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque) error{Canceled}!void", scope: !4, baseType: !1104, size: 64, align: 64)
!1104 = !DISubroutineType(types: !1105)
!1105 = !{!1089, !807}
!1106 = !DIDerivedType(tag: DW_TAG_member, name: "futexWait", scope: !1036, baseType: !1107, size: 64, align: 64, offset: 768)
!1107 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, *const u32, u32, Io.Timeout) error{Canceled}!void", scope: !4, baseType: !1101, size: 64, align: 64)
!1108 = !DIDerivedType(tag: DW_TAG_member, name: "futexWaitUncancelable", scope: !1036, baseType: !1109, size: 64, align: 64, offset: 832)
!1109 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, *const u32, u32) void", scope: !4, baseType: !1110, size: 64, align: 64)
!1110 = !DISubroutineType(types: !1111)
!1111 = !{!99, !807, !1112, !33}
!1112 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const u32", scope: !4, baseType: !33, size: 64, align: 64)
!1113 = !DIDerivedType(tag: DW_TAG_member, name: "futexWake", scope: !1036, baseType: !1109, size: 64, align: 64, offset: 896)
!1114 = !DIDerivedType(tag: DW_TAG_member, name: "operate", scope: !1036, baseType: !1115, size: 64, align: 64, offset: 960)
!1115 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Operation) error{Canceled}!Io.Operation.Result__union_3184", scope: !4, baseType: !1116, size: 64, align: 64)
!1116 = !DISubroutineType(types: !1117)
!1117 = !{!99, !1118, !807, !1149}
!1118 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*error{Canceled}!Io.Operation.Result__union_3184", scope: !4, baseType: !1119, size: 64, align: 64)
!1119 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{Canceled}!Io.Operation.Result__union_3184", scope: !4, size: 256, align: 64, elements: !1120)
!1120 = !{!1121, !1122}
!1121 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1119, baseType: !1092, size: 16, align: 16, offset: 192)
!1122 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1119, baseType: !1123, size: 192, align: 64)
!1123 = !DICompositeType(tag: DW_TAG_structure_type, name: "Io.Operation.Result__union_3184", scope: !761, file: !25, line: 396, size: 192, align: 64, elements: !1124)
!1124 = !{!1125, !1148}
!1125 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1123, baseType: !1126, size: 128, align: 64)
!1126 = !DICompositeType(tag: DW_TAG_union_type, name: "Io.Operation.Result__union_3184:Payload", scope: !761, file: !25, line: 396, size: 128, align: 64, elements: !1127)
!1127 = !{!1128, !1134, !1140, !1141}
!1128 = !DIDerivedType(tag: DW_TAG_member, name: "file_read_streaming", scope: !1126, baseType: !1129, size: 128)
!1129 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{AccessDenied,ConnectionResetByPeer,EndOfStream,InputOutput,IsDir,LockViolation,NotOpenForReading,SocketUnconnected,SystemResources,Unexpected,WouldBlock}!usize", scope: !4, size: 128, align: 64, elements: !1130)
!1130 = !{!1131, !1133}
!1131 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1129, baseType: !1132, size: 16, align: 16, offset: 64)
!1132 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{AccessDenied,ConnectionResetByPeer,EndOfStream,InputOutput,IsDir,LockViolation,NotOpenForReading,SocketUnconnected,SystemResources,Unexpected,WouldBlock}", scope: !4, baseType: !845, size: 16, align: 16)
!1133 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1129, baseType: !73, size: 64, align: 64)
!1134 = !DIDerivedType(tag: DW_TAG_member, name: "file_write_streaming", scope: !1126, baseType: !1135, size: 128)
!1135 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{AccessDenied,BrokenPipe,DeviceBusy,DiskQuota,FileBusy,FileTooBig,InputOutput,LockViolation,NoDevice,NoSpaceLeft,NotOpenForWriting,PermissionDenied,SystemResources,Unexpected,WouldBlock}!usize", scope: !4, size: 128, align: 64, elements: !1136)
!1136 = !{!1137, !1139}
!1137 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1135, baseType: !1138, size: 16, align: 16, offset: 64)
!1138 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{AccessDenied,BrokenPipe,DeviceBusy,DiskQuota,FileBusy,FileTooBig,InputOutput,LockViolation,NoDevice,NoSpaceLeft,NotOpenForWriting,PermissionDenied,SystemResources,Unexpected,WouldBlock}", scope: !4, baseType: !845, size: 16, align: 16)
!1139 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1135, baseType: !73, size: 64, align: 64)
!1140 = !DIDerivedType(tag: DW_TAG_member, name: "device_io_control", scope: !1126, baseType: !785, size: 32)
!1141 = !DIDerivedType(tag: DW_TAG_member, name: "net_receive", scope: !1126, baseType: !1142, size: 128)
!1142 = !DICompositeType(tag: DW_TAG_structure_type, name: "struct { ?error{Canceled,ConnectionResetByPeer,MessageOversize,NetworkDown,PortUnreachable,ProcessFdQuotaExceeded,SocketUnconnected,SystemFdQuotaExceeded,SystemResources,Unexpected}, usize }", scope: !4, size: 128, align: 64, elements: !1143)
!1143 = !{!1144, !1147}
!1144 = !DIDerivedType(tag: DW_TAG_member, name: "0", scope: !1142, baseType: !1145, size: 16, align: 16)
!1145 = !DIDerivedType(tag: DW_TAG_typedef, name: "?error{Canceled,ConnectionResetByPeer,MessageOversize,NetworkDown,PortUnreachable,ProcessFdQuotaExceeded,SocketUnconnected,SystemFdQuotaExceeded,SystemResources,Unexpected}", scope: !4, baseType: !1146, size: 16, align: 16)
!1146 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{Canceled,ConnectionResetByPeer,MessageOversize,NetworkDown,PortUnreachable,ProcessFdQuotaExceeded,SocketUnconnected,SystemFdQuotaExceeded,SystemResources,Unexpected}", scope: !4, baseType: !845, size: 16, align: 16)
!1147 = !DIDerivedType(tag: DW_TAG_member, name: "1", scope: !1142, baseType: !73, size: 64, align: 64, offset: 64)
!1148 = !DIDerivedType(tag: DW_TAG_member, name: "tag", scope: !1123, baseType: !760, size: 8, align: 8, offset: 128)
!1149 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const Io.Operation", scope: !4, baseType: !761, size: 64, align: 64)
!1150 = !DIDerivedType(tag: DW_TAG_member, name: "batchAwaitAsync", scope: !1036, baseType: !1151, size: 64, align: 64, offset: 1024)
!1151 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, *Io.Batch) error{Canceled}!void", scope: !4, baseType: !1152, size: 64, align: 64)
!1152 = !DISubroutineType(types: !1153)
!1153 = !{!1089, !807, !1154}
!1154 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*Io.Batch", scope: !4, baseType: !1155, size: 64, align: 64)
!1155 = !DIBasicType(name: "Io.Batch", encoding: DW_ATE_signed)
!1156 = !DIDerivedType(tag: DW_TAG_member, name: "batchAwaitConcurrent", scope: !1036, baseType: !1157, size: 64, align: 64, offset: 1088)
!1157 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, *Io.Batch, Io.Timeout) error{Canceled,ConcurrencyUnavailable,Timeout}!void", scope: !4, baseType: !1101, size: 64, align: 64)
!1158 = !DIDerivedType(tag: DW_TAG_member, name: "batchCancel", scope: !1036, baseType: !1159, size: 64, align: 64, offset: 1152)
!1159 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, *Io.Batch) void", scope: !4, baseType: !1160, size: 64, align: 64)
!1160 = !DISubroutineType(types: !1161)
!1161 = !{!99, !807, !1154}
!1162 = !DIDerivedType(tag: DW_TAG_member, name: "dirCreateDir", scope: !1036, baseType: !1163, size: 64, align: 64, offset: 1216)
!1163 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Dir, []const u8, Io.File.Permissions__enum_3284) error{AccessDenied,BadPathName,Canceled,DiskQuota,FileNotFound,LinkQuotaExceeded,NameTooLong,NetworkNotFound,NoDevice,NoSpaceLeft,NotDir,PathAlreadyExists,PermissionDenied,ReadOnlyFileSystem,SymLinkLoop,SystemResources,Unexpected}!void", scope: !4, baseType: !1101, size: 64, align: 64)
!1164 = !DIDerivedType(tag: DW_TAG_member, name: "dirCreateDirPath", scope: !1036, baseType: !1165, size: 64, align: 64, offset: 1280)
!1165 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Dir, []const u8, Io.File.Permissions__enum_3284) error{AccessDenied,AntivirusInterference,BadPathName,Canceled,DeviceBusy,DiskQuota,FileBusy,FileLocksUnsupported,FileNotFound,FileTooBig,IsDir,LinkQuotaExceeded,NameTooLong,NetworkNotFound,NoDevice,NoSpaceLeft,NotDir,PathAlreadyExists,PermissionDenied,PipeBusy,ProcessFdQuotaExceeded,ReadOnlyFileSystem,Streaming,SymLinkLoop,SystemFdQuotaExceeded,SystemResources,Unexpected,WouldBlock}!Io.Dir.CreatePathStatus", scope: !4, baseType: !1101, size: 64, align: 64)
!1166 = !DIDerivedType(tag: DW_TAG_member, name: "dirCreateDirPathOpen", scope: !1036, baseType: !1167, size: 64, align: 64, offset: 1344)
!1167 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Dir, []const u8, Io.File.Permissions__enum_3284, Io.Dir.OpenOptions) error{AccessDenied,AntivirusInterference,BadPathName,Canceled,DeviceBusy,DiskQuota,FileBusy,FileLocksUnsupported,FileNotFound,FileTooBig,IsDir,LinkQuotaExceeded,NameTooLong,NetworkNotFound,NoDevice,NoSpaceLeft,NotDir,PathAlreadyExists,PermissionDenied,PipeBusy,ProcessFdQuotaExceeded,ReadOnlyFileSystem,Streaming,SymLinkLoop,SystemFdQuotaExceeded,SystemResources,Unexpected,WouldBlock}!Io.Dir", scope: !4, baseType: !1101, size: 64, align: 64)
!1168 = !DIDerivedType(tag: DW_TAG_member, name: "dirOpenDir", scope: !1036, baseType: !1169, size: 64, align: 64, offset: 1408)
!1169 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Dir, []const u8, Io.Dir.OpenOptions) error{AccessDenied,BadPathName,Canceled,FileNotFound,NameTooLong,NetworkNotFound,NoDevice,NotDir,PermissionDenied,ProcessFdQuotaExceeded,SymLinkLoop,SystemFdQuotaExceeded,SystemResources,Unexpected}!Io.Dir", scope: !4, baseType: !1101, size: 64, align: 64)
!1170 = !DIDerivedType(tag: DW_TAG_member, name: "dirStat", scope: !1036, baseType: !1171, size: 64, align: 64, offset: 1472)
!1171 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Dir) error{AccessDenied,Canceled,PermissionDenied,Streaming,SystemResources,Unexpected}!Io.File.Stat", scope: !4, baseType: !1101, size: 64, align: 64)
!1172 = !DIDerivedType(tag: DW_TAG_member, name: "dirStatFile", scope: !1036, baseType: !1173, size: 64, align: 64, offset: 1536)
!1173 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Dir, []const u8, Io.Dir.StatFileOptions) error{AccessDenied,AntivirusInterference,BadPathName,Canceled,DeviceBusy,FileBusy,FileLocksUnsupported,FileNotFound,FileTooBig,IsDir,NameTooLong,NetworkNotFound,NoDevice,NoSpaceLeft,NotDir,PathAlreadyExists,PermissionDenied,PipeBusy,ProcessFdQuotaExceeded,ReadOnlyFileSystem,Streaming,SymLinkLoop,SystemFdQuotaExceeded,SystemResources,Unexpected,WouldBlock}!Io.File.Stat", scope: !4, baseType: !1101, size: 64, align: 64)
!1174 = !DIDerivedType(tag: DW_TAG_member, name: "dirAccess", scope: !1036, baseType: !1175, size: 64, align: 64, offset: 1600)
!1175 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Dir, []const u8, Io.Dir.AccessOptions) error{AccessDenied,BadPathName,Canceled,FileBusy,FileNotFound,InputOutput,NameTooLong,PermissionDenied,ReadOnlyFileSystem,SymLinkLoop,SystemResources,Unexpected}!void", scope: !4, baseType: !1101, size: 64, align: 64)
!1176 = !DIDerivedType(tag: DW_TAG_member, name: "dirCreateFile", scope: !1036, baseType: !1177, size: 64, align: 64, offset: 1664)
!1177 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Dir, []const u8, Io.Dir.CreateFileOptions) error{AccessDenied,AntivirusInterference,BadPathName,Canceled,DeviceBusy,FileBusy,FileLocksUnsupported,FileNotFound,FileTooBig,IsDir,NameTooLong,NetworkNotFound,NoDevice,NoSpaceLeft,NotDir,PathAlreadyExists,PermissionDenied,PipeBusy,ProcessFdQuotaExceeded,ReadOnlyFileSystem,SymLinkLoop,SystemFdQuotaExceeded,SystemResources,Unexpected,WouldBlock}!Io.File", scope: !4, baseType: !1101, size: 64, align: 64)
!1178 = !DIDerivedType(tag: DW_TAG_member, name: "dirCreateFileAtomic", scope: !1036, baseType: !1179, size: 64, align: 64, offset: 1728)
!1179 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Dir, []const u8, Io.Dir.CreateFileAtomicOptions) error{AccessDenied,AntivirusInterference,BadPathName,Canceled,FileBusy,FileNotFound,NameTooLong,NetworkNotFound,NoDevice,NoSpaceLeft,NotDir,PermissionDenied,ProcessFdQuotaExceeded,ReadOnlyFileSystem,SymLinkLoop,SystemFdQuotaExceeded,SystemResources,Unexpected,WouldBlock}!Io.File.Atomic", scope: !4, baseType: !1101, size: 64, align: 64)
!1180 = !DIDerivedType(tag: DW_TAG_member, name: "dirOpenFile", scope: !1036, baseType: !1181, size: 64, align: 64, offset: 1792)
!1181 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Dir, []const u8, Io.Dir.OpenFileOptions) error{AccessDenied,AntivirusInterference,BadPathName,Canceled,DeviceBusy,FileBusy,FileLocksUnsupported,FileNotFound,FileTooBig,IsDir,NameTooLong,NetworkNotFound,NoDevice,NoSpaceLeft,NotDir,PathAlreadyExists,PermissionDenied,PipeBusy,ProcessFdQuotaExceeded,ReadOnlyFileSystem,SymLinkLoop,SystemFdQuotaExceeded,SystemResources,Unexpected,WouldBlock}!Io.File", scope: !4, baseType: !1101, size: 64, align: 64)
!1182 = !DIDerivedType(tag: DW_TAG_member, name: "dirClose", scope: !1036, baseType: !1183, size: 64, align: 64, offset: 1856)
!1183 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, []const Io.Dir) void", scope: !4, baseType: !1184, size: 64, align: 64)
!1184 = !DISubroutineType(types: !1185)
!1185 = !{!99, !807, !1186}
!1186 = !DICompositeType(tag: DW_TAG_structure_type, name: "[]const Io.Dir", scope: !4, size: 128, align: 64, elements: !1187)
!1187 = !{!1188, !1191}
!1188 = !DIDerivedType(tag: DW_TAG_member, name: "ptr", scope: !1186, baseType: !1189, size: 64, align: 64)
!1189 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "[*]const Io.Dir", scope: !4, baseType: !1190, size: 64, align: 64)
!1190 = !DIBasicType(name: "Io.Dir", encoding: DW_ATE_signed)
!1191 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !1186, baseType: !73, size: 64, align: 64, offset: 64)
!1192 = !DIDerivedType(tag: DW_TAG_member, name: "dirRead", scope: !1036, baseType: !1193, size: 64, align: 64, offset: 1920)
!1193 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, *Io.Dir.Reader, []Io.Dir.Entry) error{AccessDenied,Canceled,PermissionDenied,SystemResources,Unexpected}!usize", scope: !4, baseType: !1194, size: 64, align: 64)
!1194 = !DISubroutineType(types: !1195)
!1195 = !{!99, !1196, !807, !1202, !1204}
!1196 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*error{AccessDenied,Canceled,PermissionDenied,SystemResources,Unexpected}!usize", scope: !4, baseType: !1197, size: 64, align: 64)
!1197 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{AccessDenied,Canceled,PermissionDenied,SystemResources,Unexpected}!usize", scope: !4, size: 128, align: 64, elements: !1198)
!1198 = !{!1199, !1201}
!1199 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1197, baseType: !1200, size: 16, align: 16, offset: 64)
!1200 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{AccessDenied,Canceled,PermissionDenied,SystemResources,Unexpected}", scope: !4, baseType: !845, size: 16, align: 16)
!1201 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1197, baseType: !73, size: 64, align: 64)
!1202 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*Io.Dir.Reader", scope: !4, baseType: !1203, size: 64, align: 64)
!1203 = !DIBasicType(name: "Io.Dir.Reader", encoding: DW_ATE_signed)
!1204 = !DICompositeType(tag: DW_TAG_structure_type, name: "[]Io.Dir.Entry", scope: !4, size: 128, align: 64, elements: !1205)
!1205 = !{!1206, !1209}
!1206 = !DIDerivedType(tag: DW_TAG_member, name: "ptr", scope: !1204, baseType: !1207, size: 64, align: 64)
!1207 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "[*]Io.Dir.Entry", scope: !4, baseType: !1208, size: 64, align: 64)
!1208 = !DIBasicType(name: "Io.Dir.Entry", encoding: DW_ATE_signed)
!1209 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !1204, baseType: !73, size: 64, align: 64, offset: 64)
!1210 = !DIDerivedType(tag: DW_TAG_member, name: "dirRealPath", scope: !1036, baseType: !1211, size: 64, align: 64, offset: 1984)
!1211 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Dir, []u8) error{AccessDenied,AntivirusInterference,Canceled,DeviceBusy,FileBusy,FileNotFound,FileSystem,FileTooBig,InputOutput,IsDir,NameTooLong,NetworkNotFound,NoDevice,NoSpaceLeft,NotDir,OperationUnsupported,PathAlreadyExists,PermissionDenied,PipeBusy,ProcessFdQuotaExceeded,SymLinkLoop,SystemFdQuotaExceeded,SystemResources,Unexpected,UnrecognizedVolume}!usize", scope: !4, baseType: !1101, size: 64, align: 64)
!1212 = !DIDerivedType(tag: DW_TAG_member, name: "dirRealPathFile", scope: !1036, baseType: !1213, size: 64, align: 64, offset: 2048)
!1213 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Dir, []const u8, []u8) error{AccessDenied,AntivirusInterference,BadPathName,Canceled,DeviceBusy,FileBusy,FileNotFound,FileSystem,FileTooBig,InputOutput,IsDir,NameTooLong,NetworkNotFound,NoDevice,NoSpaceLeft,NotDir,OperationUnsupported,PathAlreadyExists,PermissionDenied,PipeBusy,ProcessFdQuotaExceeded,SymLinkLoop,SystemFdQuotaExceeded,SystemResources,Unexpected,UnrecognizedVolume}!usize", scope: !4, baseType: !1101, size: 64, align: 64)
!1214 = !DIDerivedType(tag: DW_TAG_member, name: "dirDeleteFile", scope: !1036, baseType: !1215, size: 64, align: 64, offset: 2112)
!1215 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Dir, []const u8) error{AccessDenied,BadPathName,Canceled,FileBusy,FileNotFound,FileSystem,IsDir,NameTooLong,NetworkNotFound,NotDir,PermissionDenied,ReadOnlyFileSystem,SymLinkLoop,SystemResources,Unexpected}!void", scope: !4, baseType: !1101, size: 64, align: 64)
!1216 = !DIDerivedType(tag: DW_TAG_member, name: "dirDeleteDir", scope: !1036, baseType: !1217, size: 64, align: 64, offset: 2176)
!1217 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Dir, []const u8) error{AccessDenied,BadPathName,Canceled,DirNotEmpty,FileBusy,FileNotFound,FileSystem,NameTooLong,NetworkNotFound,NotDir,PermissionDenied,ReadOnlyFileSystem,SymLinkLoop,SystemResources,Unexpected}!void", scope: !4, baseType: !1101, size: 64, align: 64)
!1218 = !DIDerivedType(tag: DW_TAG_member, name: "dirRename", scope: !1036, baseType: !1219, size: 64, align: 64, offset: 2240)
!1219 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Dir, []const u8, Io.Dir, []const u8) error{AccessDenied,AntivirusInterference,BadPathName,Canceled,CrossDevice,DirNotEmpty,DiskQuota,FileBusy,FileNotFound,HardwareFailure,IsDir,LinkQuotaExceeded,NameTooLong,NetworkNotFound,NoDevice,NoSpaceLeft,NotDir,PermissionDenied,PipeBusy,ReadOnlyFileSystem,SymLinkLoop,SystemResources,Unexpected}!void", scope: !4, baseType: !1101, size: 64, align: 64)
!1220 = !DIDerivedType(tag: DW_TAG_member, name: "dirRenamePreserve", scope: !1036, baseType: !1221, size: 64, align: 64, offset: 2304)
!1221 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Dir, []const u8, Io.Dir, []const u8) error{AccessDenied,AntivirusInterference,BadPathName,Canceled,CrossDevice,DirNotEmpty,DiskQuota,FileBusy,FileNotFound,HardwareFailure,IsDir,LinkQuotaExceeded,NameTooLong,NetworkNotFound,NoDevice,NoSpaceLeft,NotDir,OperationUnsupported,PathAlreadyExists,PermissionDenied,PipeBusy,ReadOnlyFileSystem,SymLinkLoop,SystemResources,Unexpected}!void", scope: !4, baseType: !1101, size: 64, align: 64)
!1222 = !DIDerivedType(tag: DW_TAG_member, name: "dirSymLink", scope: !1036, baseType: !1223, size: 64, align: 64, offset: 2368)
!1223 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Dir, []const u8, []const u8, Io.Dir.SymLinkFlags) error{AccessDenied,BadPathName,Canceled,DiskQuota,FileNotFound,FileSystem,NameTooLong,NetworkNotFound,NoSpaceLeft,NotDir,PathAlreadyExists,PermissionDenied,ReadOnlyFileSystem,SymLinkLoop,SystemResources,Unexpected}!void", scope: !4, baseType: !1101, size: 64, align: 64)
!1224 = !DIDerivedType(tag: DW_TAG_member, name: "dirReadLink", scope: !1036, baseType: !1225, size: 64, align: 64, offset: 2432)
!1225 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Dir, []const u8, []u8) error{AccessDenied,AntivirusInterference,BadPathName,Canceled,FileBusy,FileNotFound,FileSystem,NameTooLong,NetworkNotFound,NotDir,NotLink,PermissionDenied,SymLinkLoop,SystemResources,Unexpected,UnsupportedReparsePointType}!usize", scope: !4, baseType: !1101, size: 64, align: 64)
!1226 = !DIDerivedType(tag: DW_TAG_member, name: "dirSetOwner", scope: !1036, baseType: !1227, size: 64, align: 64, offset: 2496)
!1227 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Dir, ?u32, ?u32) error{AccessDenied,Canceled,FileNotFound,InputOutput,PermissionDenied,ReadOnlyFileSystem,SymLinkLoop,SystemResources,Unexpected}!void", scope: !4, baseType: !1101, size: 64, align: 64)
!1228 = !DIDerivedType(tag: DW_TAG_member, name: "dirSetFileOwner", scope: !1036, baseType: !1229, size: 64, align: 64, offset: 2560)
!1229 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Dir, []const u8, ?u32, ?u32, Io.Dir.SetFileOwnerOptions) error{AccessDenied,BadPathName,Canceled,FileNotFound,InputOutput,NameTooLong,PermissionDenied,ReadOnlyFileSystem,SymLinkLoop,SystemResources,Unexpected}!void", scope: !4, baseType: !1101, size: 64, align: 64)
!1230 = !DIDerivedType(tag: DW_TAG_member, name: "dirSetPermissions", scope: !1036, baseType: !1231, size: 64, align: 64, offset: 2624)
!1231 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Dir, Io.File.Permissions__enum_3284) error{AccessDenied,Canceled,FileNotFound,InputOutput,PermissionDenied,ReadOnlyFileSystem,SymLinkLoop,SystemResources,Unexpected}!void", scope: !4, baseType: !1101, size: 64, align: 64)
!1232 = !DIDerivedType(tag: DW_TAG_member, name: "dirSetFilePermissions", scope: !1036, baseType: !1233, size: 64, align: 64, offset: 2688)
!1233 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Dir, []const u8, Io.File.Permissions__enum_3284, Io.Dir.SetFilePermissionsOptions) error{AccessDenied,BadPathName,Canceled,FileNotFound,InputOutput,NameTooLong,OperationUnsupported,PermissionDenied,ProcessFdQuotaExceeded,ReadOnlyFileSystem,SymLinkLoop,SystemFdQuotaExceeded,SystemResources,Unexpected}!void", scope: !4, baseType: !1101, size: 64, align: 64)
!1234 = !DIDerivedType(tag: DW_TAG_member, name: "dirSetTimestamps", scope: !1036, baseType: !1235, size: 64, align: 64, offset: 2752)
!1235 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Dir, []const u8, Io.Dir.SetTimestampsOptions) error{AccessDenied,BadPathName,Canceled,NameTooLong,PermissionDenied,ReadOnlyFileSystem,Unexpected}!void", scope: !4, baseType: !1101, size: 64, align: 64)
!1236 = !DIDerivedType(tag: DW_TAG_member, name: "dirHardLink", scope: !1036, baseType: !1237, size: 64, align: 64, offset: 2816)
!1237 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Dir, []const u8, Io.Dir, []const u8, Io.File.HardLinkOptions) error{AccessDenied,BadPathName,Canceled,CrossDevice,DiskQuota,FileNotFound,HardwareFailure,LinkQuotaExceeded,NameTooLong,NoSpaceLeft,NotDir,OperationUnsupported,PathAlreadyExists,PermissionDenied,ReadOnlyFileSystem,SymLinkLoop,SystemResources,Unexpected}!void", scope: !4, baseType: !1101, size: 64, align: 64)
!1238 = !DIDerivedType(tag: DW_TAG_member, name: "fileStat", scope: !1036, baseType: !1239, size: 64, align: 64, offset: 2880)
!1239 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.File) error{AccessDenied,Canceled,PermissionDenied,Streaming,SystemResources,Unexpected}!Io.File.Stat", scope: !4, baseType: !1101, size: 64, align: 64)
!1240 = !DIDerivedType(tag: DW_TAG_member, name: "fileLength", scope: !1036, baseType: !1241, size: 64, align: 64, offset: 2944)
!1241 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.File) error{AccessDenied,Canceled,PermissionDenied,Streaming,SystemResources,Unexpected}!u64", scope: !4, baseType: !1242, size: 64, align: 64)
!1242 = !DISubroutineType(types: !1243)
!1243 = !{!99, !1244, !807, !1250}
!1244 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*error{AccessDenied,Canceled,PermissionDenied,Streaming,SystemResources,Unexpected}!u64", scope: !4, baseType: !1245, size: 64, align: 64)
!1245 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{AccessDenied,Canceled,PermissionDenied,Streaming,SystemResources,Unexpected}!u64", scope: !4, size: 128, align: 64, elements: !1246)
!1246 = !{!1247, !1249}
!1247 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1245, baseType: !1248, size: 16, align: 16, offset: 64)
!1248 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{AccessDenied,Canceled,PermissionDenied,Streaming,SystemResources,Unexpected}", scope: !4, baseType: !845, size: 16, align: 16)
!1249 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1245, baseType: !227, size: 64, align: 64)
!1250 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const Io.File", scope: !4, baseType: !781, size: 64, align: 64)
!1251 = !DIDerivedType(tag: DW_TAG_member, name: "fileClose", scope: !1036, baseType: !1252, size: 64, align: 64, offset: 3008)
!1252 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, []const Io.File) void", scope: !4, baseType: !1253, size: 64, align: 64)
!1253 = !DISubroutineType(types: !1254)
!1254 = !{!99, !807, !1255}
!1255 = !DICompositeType(tag: DW_TAG_structure_type, name: "[]const Io.File", scope: !4, size: 128, align: 64, elements: !1256)
!1256 = !{!1257, !1259}
!1257 = !DIDerivedType(tag: DW_TAG_member, name: "ptr", scope: !1255, baseType: !1258, size: 64, align: 64)
!1258 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "[*]const Io.File", scope: !4, baseType: !781, size: 64, align: 64)
!1259 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !1255, baseType: !73, size: 64, align: 64, offset: 64)
!1260 = !DIDerivedType(tag: DW_TAG_member, name: "fileWritePositional", scope: !1036, baseType: !1261, size: 64, align: 64, offset: 3072)
!1261 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.File, []const u8, []const []const u8, usize, u64) error{AccessDenied,BrokenPipe,Canceled,DeviceBusy,DiskQuota,FileBusy,FileTooBig,InputOutput,LockViolation,NoDevice,NoSpaceLeft,NotOpenForWriting,PermissionDenied,SystemResources,Unexpected,Unseekable,WouldBlock}!usize", scope: !4, baseType: !1262, size: 64, align: 64)
!1262 = !DISubroutineType(types: !1263)
!1263 = !{!99, !1264, !807, !1250, !112, !796, !73, !227}
!1264 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*error{AccessDenied,BrokenPipe,Canceled,DeviceBusy,DiskQuota,FileBusy,FileTooBig,InputOutput,LockViolation,NoDevice,NoSpaceLeft,NotOpenForWriting,PermissionDenied,SystemResources,Unexpected,Unseekable,WouldBlock}!usize", scope: !4, baseType: !1265, size: 64, align: 64)
!1265 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{AccessDenied,BrokenPipe,Canceled,DeviceBusy,DiskQuota,FileBusy,FileTooBig,InputOutput,LockViolation,NoDevice,NoSpaceLeft,NotOpenForWriting,PermissionDenied,SystemResources,Unexpected,Unseekable,WouldBlock}!usize", scope: !4, size: 128, align: 64, elements: !1266)
!1266 = !{!1267, !1269}
!1267 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1265, baseType: !1268, size: 16, align: 16, offset: 64)
!1268 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{AccessDenied,BrokenPipe,Canceled,DeviceBusy,DiskQuota,FileBusy,FileTooBig,InputOutput,LockViolation,NoDevice,NoSpaceLeft,NotOpenForWriting,PermissionDenied,SystemResources,Unexpected,Unseekable,WouldBlock}", scope: !4, baseType: !845, size: 16, align: 16)
!1269 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1265, baseType: !73, size: 64, align: 64)
!1270 = !DIDerivedType(tag: DW_TAG_member, name: "fileWriteFileStreaming", scope: !1036, baseType: !1271, size: 64, align: 64, offset: 3136)
!1271 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.File, []const u8, *Io.File.Reader, Io.Limit) error{AccessDenied,BrokenPipe,Canceled,CorruptedData,DeviceBusy,DiskQuota,EndOfStream,FileBusy,FileTooBig,InputOutput,LockViolation,NoDevice,NoSpaceLeft,NotOpenForWriting,PermissionDenied,ReadFailed,SystemResources,Unexpected,Unimplemented,WouldBlock}!usize", scope: !4, baseType: !1272, size: 64, align: 64)
!1272 = !DISubroutineType(types: !1273)
!1273 = !{!99, !1274, !807, !1250, !112, !1280, !72}
!1274 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*error{AccessDenied,BrokenPipe,Canceled,CorruptedData,DeviceBusy,DiskQuota,EndOfStream,FileBusy,FileTooBig,InputOutput,LockViolation,NoDevice,NoSpaceLeft,NotOpenForWriting,PermissionDenied,ReadFailed,SystemResources,Unexpected,Unimplemented,WouldBlock}!usize", scope: !4, baseType: !1275, size: 64, align: 64)
!1275 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{AccessDenied,BrokenPipe,Canceled,CorruptedData,DeviceBusy,DiskQuota,EndOfStream,FileBusy,FileTooBig,InputOutput,LockViolation,NoDevice,NoSpaceLeft,NotOpenForWriting,PermissionDenied,ReadFailed,SystemResources,Unexpected,Unimplemented,WouldBlock}!usize", scope: !4, size: 128, align: 64, elements: !1276)
!1276 = !{!1277, !1279}
!1277 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1275, baseType: !1278, size: 16, align: 16, offset: 64)
!1278 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{AccessDenied,BrokenPipe,Canceled,CorruptedData,DeviceBusy,DiskQuota,EndOfStream,FileBusy,FileTooBig,InputOutput,LockViolation,NoDevice,NoSpaceLeft,NotOpenForWriting,PermissionDenied,ReadFailed,SystemResources,Unexpected,Unimplemented,WouldBlock}", scope: !4, baseType: !845, size: 16, align: 16)
!1279 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1275, baseType: !73, size: 64, align: 64)
!1280 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*Io.File.Reader", scope: !4, baseType: !1281, size: 64, align: 64)
!1281 = !DIBasicType(name: "Io.File.Reader", encoding: DW_ATE_signed)
!1282 = !DIDerivedType(tag: DW_TAG_member, name: "fileWriteFilePositional", scope: !1036, baseType: !1283, size: 64, align: 64, offset: 3200)
!1283 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.File, []const u8, *Io.File.Reader, Io.Limit, u64) error{AccessDenied,BrokenPipe,Canceled,CorruptedData,DeviceBusy,DiskQuota,EndOfStream,FileBusy,FileTooBig,InputOutput,LockViolation,NoDevice,NoSpaceLeft,NotOpenForWriting,PermissionDenied,ReadFailed,SystemResources,Unexpected,Unimplemented,Unseekable,WouldBlock}!usize", scope: !4, baseType: !1284, size: 64, align: 64)
!1284 = !DISubroutineType(types: !1285)
!1285 = !{!99, !1286, !807, !1250, !112, !1280, !72, !227}
!1286 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*error{AccessDenied,BrokenPipe,Canceled,CorruptedData,DeviceBusy,DiskQuota,EndOfStream,FileBusy,FileTooBig,InputOutput,LockViolation,NoDevice,NoSpaceLeft,NotOpenForWriting,PermissionDenied,ReadFailed,SystemResources,Unexpected,Unimplemented,Unseekable,WouldBlock}!usize", scope: !4, baseType: !1287, size: 64, align: 64)
!1287 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{AccessDenied,BrokenPipe,Canceled,CorruptedData,DeviceBusy,DiskQuota,EndOfStream,FileBusy,FileTooBig,InputOutput,LockViolation,NoDevice,NoSpaceLeft,NotOpenForWriting,PermissionDenied,ReadFailed,SystemResources,Unexpected,Unimplemented,Unseekable,WouldBlock}!usize", scope: !4, size: 128, align: 64, elements: !1288)
!1288 = !{!1289, !1291}
!1289 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1287, baseType: !1290, size: 16, align: 16, offset: 64)
!1290 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{AccessDenied,BrokenPipe,Canceled,CorruptedData,DeviceBusy,DiskQuota,EndOfStream,FileBusy,FileTooBig,InputOutput,LockViolation,NoDevice,NoSpaceLeft,NotOpenForWriting,PermissionDenied,ReadFailed,SystemResources,Unexpected,Unimplemented,Unseekable,WouldBlock}", scope: !4, baseType: !845, size: 16, align: 16)
!1291 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1287, baseType: !73, size: 64, align: 64)
!1292 = !DIDerivedType(tag: DW_TAG_member, name: "fileReadPositional", scope: !1036, baseType: !1293, size: 64, align: 64, offset: 3264)
!1293 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.File, []const []u8, u64) error{AccessDenied,Canceled,InputOutput,IsDir,LockViolation,NotOpenForReading,SystemResources,Unexpected,Unseekable,WouldBlock}!usize", scope: !4, baseType: !1294, size: 64, align: 64)
!1294 = !DISubroutineType(types: !1295)
!1295 = !{!99, !1296, !807, !1250, !770, !227}
!1296 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*error{AccessDenied,Canceled,InputOutput,IsDir,LockViolation,NotOpenForReading,SystemResources,Unexpected,Unseekable,WouldBlock}!usize", scope: !4, baseType: !1297, size: 64, align: 64)
!1297 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{AccessDenied,Canceled,InputOutput,IsDir,LockViolation,NotOpenForReading,SystemResources,Unexpected,Unseekable,WouldBlock}!usize", scope: !4, size: 128, align: 64, elements: !1298)
!1298 = !{!1299, !1301}
!1299 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1297, baseType: !1300, size: 16, align: 16, offset: 64)
!1300 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{AccessDenied,Canceled,InputOutput,IsDir,LockViolation,NotOpenForReading,SystemResources,Unexpected,Unseekable,WouldBlock}", scope: !4, baseType: !845, size: 16, align: 16)
!1301 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1297, baseType: !73, size: 64, align: 64)
!1302 = !DIDerivedType(tag: DW_TAG_member, name: "fileSeekBy", scope: !1036, baseType: !1303, size: 64, align: 64, offset: 3328)
!1303 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.File, i64) error{AccessDenied,Canceled,Unexpected,Unseekable}!void", scope: !4, baseType: !1304, size: 64, align: 64)
!1304 = !DISubroutineType(types: !1305)
!1305 = !{!1306, !807, !1250, !1311}
!1306 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{AccessDenied,Canceled,Unexpected,Unseekable}!void", scope: !4, size: 16, align: 16, elements: !1307)
!1307 = !{!1308, !1310}
!1308 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1306, baseType: !1309, size: 16, align: 16)
!1309 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{AccessDenied,Canceled,Unexpected,Unseekable}", scope: !4, baseType: !845, size: 16, align: 16)
!1310 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1306, baseType: !99, align: 8, offset: 16)
!1311 = !DIBasicType(name: "i64", size: 64, encoding: DW_ATE_signed)
!1312 = !DIDerivedType(tag: DW_TAG_member, name: "fileSeekTo", scope: !1036, baseType: !1313, size: 64, align: 64, offset: 3392)
!1313 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.File, u64) error{AccessDenied,Canceled,Unexpected,Unseekable}!void", scope: !4, baseType: !1314, size: 64, align: 64)
!1314 = !DISubroutineType(types: !1315)
!1315 = !{!1306, !807, !1250, !227}
!1316 = !DIDerivedType(tag: DW_TAG_member, name: "fileSync", scope: !1036, baseType: !1317, size: 64, align: 64, offset: 3456)
!1317 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.File) error{AccessDenied,Canceled,DiskQuota,InputOutput,NoSpaceLeft,Unexpected}!void", scope: !4, baseType: !1318, size: 64, align: 64)
!1318 = !DISubroutineType(types: !1319)
!1319 = !{!1320, !807, !1250}
!1320 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{AccessDenied,Canceled,DiskQuota,InputOutput,NoSpaceLeft,Unexpected}!void", scope: !4, size: 16, align: 16, elements: !1321)
!1321 = !{!1322, !1324}
!1322 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1320, baseType: !1323, size: 16, align: 16)
!1323 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{AccessDenied,Canceled,DiskQuota,InputOutput,NoSpaceLeft,Unexpected}", scope: !4, baseType: !845, size: 16, align: 16)
!1324 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1320, baseType: !99, align: 8, offset: 16)
!1325 = !DIDerivedType(tag: DW_TAG_member, name: "fileIsTty", scope: !1036, baseType: !1326, size: 64, align: 64, offset: 3520)
!1326 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.File) error{Canceled}!bool", scope: !4, baseType: !1327, size: 64, align: 64)
!1327 = !DISubroutineType(types: !1328)
!1328 = !{!99, !1329, !807, !1250}
!1329 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*error{Canceled}!bool", scope: !4, baseType: !1330, size: 64, align: 64)
!1330 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{Canceled}!bool", scope: !4, size: 32, align: 16, elements: !1331)
!1331 = !{!1332, !1333}
!1332 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1330, baseType: !1092, size: 16, align: 16)
!1333 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1330, baseType: !790, size: 8, align: 8, offset: 16)
!1334 = !DIDerivedType(tag: DW_TAG_member, name: "fileEnableAnsiEscapeCodes", scope: !1036, baseType: !1335, size: 64, align: 64, offset: 3584)
!1335 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.File) error{Canceled,NotTerminalDevice,Unexpected}!void", scope: !4, baseType: !1336, size: 64, align: 64)
!1336 = !DISubroutineType(types: !1337)
!1337 = !{!1338, !807, !1250}
!1338 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{Canceled,NotTerminalDevice,Unexpected}!void", scope: !4, size: 16, align: 16, elements: !1339)
!1339 = !{!1340, !1342}
!1340 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1338, baseType: !1341, size: 16, align: 16)
!1341 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{Canceled,NotTerminalDevice,Unexpected}", scope: !4, baseType: !845, size: 16, align: 16)
!1342 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1338, baseType: !99, align: 8, offset: 16)
!1343 = !DIDerivedType(tag: DW_TAG_member, name: "fileSupportsAnsiEscapeCodes", scope: !1036, baseType: !1326, size: 64, align: 64, offset: 3648)
!1344 = !DIDerivedType(tag: DW_TAG_member, name: "fileSetLength", scope: !1036, baseType: !1345, size: 64, align: 64, offset: 3712)
!1345 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.File, u64) error{AccessDenied,Canceled,FileBusy,FileTooBig,InputOutput,NonResizable,PermissionDenied,Unexpected}!void", scope: !4, baseType: !1346, size: 64, align: 64)
!1346 = !DISubroutineType(types: !1347)
!1347 = !{!1348, !807, !1250, !227}
!1348 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{AccessDenied,Canceled,FileBusy,FileTooBig,InputOutput,NonResizable,PermissionDenied,Unexpected}!void", scope: !4, size: 16, align: 16, elements: !1349)
!1349 = !{!1350, !1352}
!1350 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1348, baseType: !1351, size: 16, align: 16)
!1351 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{AccessDenied,Canceled,FileBusy,FileTooBig,InputOutput,NonResizable,PermissionDenied,Unexpected}", scope: !4, baseType: !845, size: 16, align: 16)
!1352 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1348, baseType: !99, align: 8, offset: 16)
!1353 = !DIDerivedType(tag: DW_TAG_member, name: "fileSetOwner", scope: !1036, baseType: !1354, size: 64, align: 64, offset: 3776)
!1354 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.File, ?u32, ?u32) error{AccessDenied,Canceled,FileNotFound,InputOutput,PermissionDenied,ReadOnlyFileSystem,SymLinkLoop,SystemResources,Unexpected}!void", scope: !4, baseType: !1355, size: 64, align: 64)
!1355 = !DISubroutineType(types: !1356)
!1356 = !{!1357, !807, !1250, !1362, !1362}
!1357 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{AccessDenied,Canceled,FileNotFound,InputOutput,PermissionDenied,ReadOnlyFileSystem,SymLinkLoop,SystemResources,Unexpected}!void", scope: !4, size: 16, align: 16, elements: !1358)
!1358 = !{!1359, !1361}
!1359 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1357, baseType: !1360, size: 16, align: 16)
!1360 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{AccessDenied,Canceled,FileNotFound,InputOutput,PermissionDenied,ReadOnlyFileSystem,SymLinkLoop,SystemResources,Unexpected}", scope: !4, baseType: !845, size: 16, align: 16)
!1361 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1357, baseType: !99, align: 8, offset: 16)
!1362 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const ?u32", scope: !4, baseType: !1363, size: 64, align: 64)
!1363 = !DICompositeType(tag: DW_TAG_structure_type, name: "?u32", scope: !4, size: 64, align: 32, elements: !1364)
!1364 = !{!1365, !1366}
!1365 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1363, baseType: !33, size: 32, align: 32)
!1366 = !DIDerivedType(tag: DW_TAG_member, name: "some", scope: !1363, baseType: !116, size: 8, align: 8, offset: 32)
!1367 = !DIDerivedType(tag: DW_TAG_member, name: "fileSetPermissions", scope: !1036, baseType: !1368, size: 64, align: 64, offset: 3840)
!1368 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.File, Io.File.Permissions__enum_3284) error{AccessDenied,Canceled,FileNotFound,InputOutput,PermissionDenied,ReadOnlyFileSystem,SymLinkLoop,SystemResources,Unexpected}!void", scope: !4, baseType: !1101, size: 64, align: 64)
!1369 = !DIDerivedType(tag: DW_TAG_member, name: "fileSetTimestamps", scope: !1036, baseType: !1370, size: 64, align: 64, offset: 3904)
!1370 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.File, Io.File.SetTimestampsOptions) error{AccessDenied,Canceled,PermissionDenied,ReadOnlyFileSystem,Unexpected}!void", scope: !4, baseType: !1101, size: 64, align: 64)
!1371 = !DIDerivedType(tag: DW_TAG_member, name: "fileLock", scope: !1036, baseType: !1372, size: 64, align: 64, offset: 3968)
!1372 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.File, Io.File.Lock) error{Canceled,FileLocksUnsupported,SystemResources,Unexpected}!void", scope: !4, baseType: !1101, size: 64, align: 64)
!1373 = !DIDerivedType(tag: DW_TAG_member, name: "fileTryLock", scope: !1036, baseType: !1374, size: 64, align: 64, offset: 4032)
!1374 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.File, Io.File.Lock) error{Canceled,FileLocksUnsupported,SystemResources,Unexpected}!bool", scope: !4, baseType: !1101, size: 64, align: 64)
!1375 = !DIDerivedType(tag: DW_TAG_member, name: "fileUnlock", scope: !1036, baseType: !1376, size: 64, align: 64, offset: 4096)
!1376 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.File) void", scope: !4, baseType: !1377, size: 64, align: 64)
!1377 = !DISubroutineType(types: !1378)
!1378 = !{!99, !807, !1250}
!1379 = !DIDerivedType(tag: DW_TAG_member, name: "fileDowngradeLock", scope: !1036, baseType: !1380, size: 64, align: 64, offset: 4160)
!1380 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.File) error{Canceled,Unexpected}!void", scope: !4, baseType: !1381, size: 64, align: 64)
!1381 = !DISubroutineType(types: !1382)
!1382 = !{!1383, !807, !1250}
!1383 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{Canceled,Unexpected}!void", scope: !4, size: 16, align: 16, elements: !1384)
!1384 = !{!1385, !1387}
!1385 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1383, baseType: !1386, size: 16, align: 16)
!1386 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{Canceled,Unexpected}", scope: !4, baseType: !845, size: 16, align: 16)
!1387 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1383, baseType: !99, align: 8, offset: 16)
!1388 = !DIDerivedType(tag: DW_TAG_member, name: "fileRealPath", scope: !1036, baseType: !1389, size: 64, align: 64, offset: 4224)
!1389 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.File, []u8) error{AccessDenied,AntivirusInterference,Canceled,DeviceBusy,FileBusy,FileNotFound,FileSystem,FileTooBig,InputOutput,IsDir,NameTooLong,NetworkNotFound,NoDevice,NoSpaceLeft,NotDir,OperationUnsupported,PathAlreadyExists,PermissionDenied,PipeBusy,ProcessFdQuotaExceeded,SymLinkLoop,SystemFdQuotaExceeded,SystemResources,Unexpected,UnrecognizedVolume}!usize", scope: !4, baseType: !1390, size: 64, align: 64)
!1390 = !DISubroutineType(types: !1391)
!1391 = !{!99, !1392, !807, !1250, !774}
!1392 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*error{AccessDenied,AntivirusInterference,Canceled,DeviceBusy,FileBusy,FileNotFound,FileSystem,FileTooBig,InputOutput,IsDir,NameTooLong,NetworkNotFound,NoDevice,NoSpaceLeft,NotDir,OperationUnsupported,PathAlreadyExists,PermissionDenied,PipeBusy,ProcessFdQuotaExceeded,SymLinkLoop,SystemFdQuotaExceeded,SystemResources,Unexpected,UnrecognizedVolume}!usize", scope: !4, baseType: !1393, size: 64, align: 64)
!1393 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{AccessDenied,AntivirusInterference,Canceled,DeviceBusy,FileBusy,FileNotFound,FileSystem,FileTooBig,InputOutput,IsDir,NameTooLong,NetworkNotFound,NoDevice,NoSpaceLeft,NotDir,OperationUnsupported,PathAlreadyExists,PermissionDenied,PipeBusy,ProcessFdQuotaExceeded,SymLinkLoop,SystemFdQuotaExceeded,SystemResources,Unexpected,UnrecognizedVolume}!usize", scope: !4, size: 128, align: 64, elements: !1394)
!1394 = !{!1395, !1397}
!1395 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1393, baseType: !1396, size: 16, align: 16, offset: 64)
!1396 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{AccessDenied,AntivirusInterference,Canceled,DeviceBusy,FileBusy,FileNotFound,FileSystem,FileTooBig,InputOutput,IsDir,NameTooLong,NetworkNotFound,NoDevice,NoSpaceLeft,NotDir,OperationUnsupported,PathAlreadyExists,PermissionDenied,PipeBusy,ProcessFdQuotaExceeded,SymLinkLoop,SystemFdQuotaExceeded,SystemResources,Unexpected,UnrecognizedVolume}", scope: !4, baseType: !845, size: 16, align: 16)
!1397 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1393, baseType: !73, size: 64, align: 64)
!1398 = !DIDerivedType(tag: DW_TAG_member, name: "fileHardLink", scope: !1036, baseType: !1399, size: 64, align: 64, offset: 4288)
!1399 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.File, Io.Dir, []const u8, Io.File.HardLinkOptions) error{AccessDenied,BadPathName,Canceled,CrossDevice,DiskQuota,FileNotFound,HardwareFailure,LinkQuotaExceeded,NameTooLong,NoSpaceLeft,NotDir,OperationUnsupported,PathAlreadyExists,PermissionDenied,ReadOnlyFileSystem,SymLinkLoop,SystemResources,Unexpected}!void", scope: !4, baseType: !1101, size: 64, align: 64)
!1400 = !DIDerivedType(tag: DW_TAG_member, name: "fileMemoryMapCreate", scope: !1036, baseType: !1401, size: 64, align: 64, offset: 4352)
!1401 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.File, Io.File.MemoryMap.CreateOptions) error{AccessDenied,Canceled,InputOutput,IsDir,LockViolation,LockedMemoryLimitExceeded,NotOpenForReading,OutOfMemory,PermissionDenied,ProcessFdQuotaExceeded,SystemFdQuotaExceeded,SystemResources,Unexpected,Unseekable,WouldBlock}!Io.File.MemoryMap", scope: !4, baseType: !1101, size: 64, align: 64)
!1402 = !DIDerivedType(tag: DW_TAG_member, name: "fileMemoryMapDestroy", scope: !1036, baseType: !1403, size: 64, align: 64, offset: 4416)
!1403 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, *Io.File.MemoryMap) void", scope: !4, baseType: !1404, size: 64, align: 64)
!1404 = !DISubroutineType(types: !1405)
!1405 = !{!99, !807, !1406}
!1406 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*Io.File.MemoryMap", scope: !4, baseType: !1407, size: 64, align: 64)
!1407 = !DIBasicType(name: "Io.File.MemoryMap", encoding: DW_ATE_signed)
!1408 = !DIDerivedType(tag: DW_TAG_member, name: "fileMemoryMapSetLength", scope: !1036, baseType: !1409, size: 64, align: 64, offset: 4480)
!1409 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, *Io.File.MemoryMap, usize) error{AccessDenied,Canceled,FileBusy,FileTooBig,InputOutput,LockedMemoryLimitExceeded,NonResizable,OperationUnsupported,OutOfMemory,PermissionDenied,ProcessFdQuotaExceeded,SystemFdQuotaExceeded,Unexpected}!void", scope: !4, baseType: !1410, size: 64, align: 64)
!1410 = !DISubroutineType(types: !1411)
!1411 = !{!1412, !807, !1406, !73}
!1412 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{AccessDenied,Canceled,FileBusy,FileTooBig,InputOutput,LockedMemoryLimitExceeded,NonResizable,OperationUnsupported,OutOfMemory,PermissionDenied,ProcessFdQuotaExceeded,SystemFdQuotaExceeded,Unexpected}!void", scope: !4, size: 16, align: 16, elements: !1413)
!1413 = !{!1414, !1416}
!1414 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1412, baseType: !1415, size: 16, align: 16)
!1415 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{AccessDenied,Canceled,FileBusy,FileTooBig,InputOutput,LockedMemoryLimitExceeded,NonResizable,OperationUnsupported,OutOfMemory,PermissionDenied,ProcessFdQuotaExceeded,SystemFdQuotaExceeded,Unexpected}", scope: !4, baseType: !845, size: 16, align: 16)
!1416 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1412, baseType: !99, align: 8, offset: 16)
!1417 = !DIDerivedType(tag: DW_TAG_member, name: "fileMemoryMapRead", scope: !1036, baseType: !1418, size: 64, align: 64, offset: 4544)
!1418 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, *Io.File.MemoryMap) error{AccessDenied,Canceled,InputOutput,IsDir,LockViolation,NotOpenForReading,SystemResources,Unexpected,Unseekable,WouldBlock}!void", scope: !4, baseType: !1419, size: 64, align: 64)
!1419 = !DISubroutineType(types: !1420)
!1420 = !{!1421, !807, !1406}
!1421 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{AccessDenied,Canceled,InputOutput,IsDir,LockViolation,NotOpenForReading,SystemResources,Unexpected,Unseekable,WouldBlock}!void", scope: !4, size: 16, align: 16, elements: !1422)
!1422 = !{!1423, !1424}
!1423 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1421, baseType: !1300, size: 16, align: 16)
!1424 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1421, baseType: !99, align: 8, offset: 16)
!1425 = !DIDerivedType(tag: DW_TAG_member, name: "fileMemoryMapWrite", scope: !1036, baseType: !1426, size: 64, align: 64, offset: 4608)
!1426 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, *Io.File.MemoryMap) error{AccessDenied,BrokenPipe,Canceled,DeviceBusy,DiskQuota,FileBusy,FileTooBig,InputOutput,LockViolation,NoDevice,NoSpaceLeft,NotOpenForWriting,PermissionDenied,SystemResources,Unexpected,Unseekable,WouldBlock}!void", scope: !4, baseType: !1427, size: 64, align: 64)
!1427 = !DISubroutineType(types: !1428)
!1428 = !{!1429, !807, !1406}
!1429 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{AccessDenied,BrokenPipe,Canceled,DeviceBusy,DiskQuota,FileBusy,FileTooBig,InputOutput,LockViolation,NoDevice,NoSpaceLeft,NotOpenForWriting,PermissionDenied,SystemResources,Unexpected,Unseekable,WouldBlock}!void", scope: !4, size: 16, align: 16, elements: !1430)
!1430 = !{!1431, !1432}
!1431 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1429, baseType: !1268, size: 16, align: 16)
!1432 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1429, baseType: !99, align: 8, offset: 16)
!1433 = !DIDerivedType(tag: DW_TAG_member, name: "processExecutableOpen", scope: !1036, baseType: !1434, size: 64, align: 64, offset: 4672)
!1434 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Dir.OpenFileOptions) error{AccessDenied,AntivirusInterference,BadPathName,Canceled,DeviceBusy,FileBusy,FileLocksUnsupported,FileNotFound,FileSystem,FileTooBig,InputOutput,IsDir,NameTooLong,NetworkNotFound,NoDevice,NoSpaceLeft,NotDir,NotLink,OperationUnsupported,PathAlreadyExists,PermissionDenied,PipeBusy,ProcessFdQuotaExceeded,ProcessNotFound,ReadOnlyFileSystem,SymLinkLoop,SystemFdQuotaExceeded,SystemResources,Unexpected,UnrecognizedVolume,WouldBlock}!Io.File", scope: !4, baseType: !1101, size: 64, align: 64)
!1435 = !DIDerivedType(tag: DW_TAG_member, name: "processExecutablePath", scope: !1036, baseType: !1436, size: 64, align: 64, offset: 4736)
!1436 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, []u8) error{AccessDenied,AntivirusInterference,BadPathName,Canceled,DeviceBusy,FileNotFound,FileSystem,FileTooBig,InputOutput,IsDir,NameTooLong,NetworkNotFound,NoDevice,NoSpaceLeft,NotDir,NotLink,OperationUnsupported,PathAlreadyExists,PermissionDenied,PipeBusy,ProcessFdQuotaExceeded,ProcessNotFound,SymLinkLoop,SystemFdQuotaExceeded,SystemResources,Unexpected,UnrecognizedVolume}!usize", scope: !4, baseType: !1437, size: 64, align: 64)
!1437 = !DISubroutineType(types: !1438)
!1438 = !{!99, !1439, !807, !774}
!1439 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*error{AccessDenied,AntivirusInterference,BadPathName,Canceled,DeviceBusy,FileNotFound,FileSystem,FileTooBig,InputOutput,IsDir,NameTooLong,NetworkNotFound,NoDevice,NoSpaceLeft,NotDir,NotLink,OperationUnsupported,PathAlreadyExists,PermissionDenied,PipeBusy,ProcessFdQuotaExceeded,ProcessNotFound,SymLinkLoop,SystemFdQuotaExceeded,SystemResources,Unexpected,UnrecognizedVolume}!usize", scope: !4, baseType: !1440, size: 64, align: 64)
!1440 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{AccessDenied,AntivirusInterference,BadPathName,Canceled,DeviceBusy,FileNotFound,FileSystem,FileTooBig,InputOutput,IsDir,NameTooLong,NetworkNotFound,NoDevice,NoSpaceLeft,NotDir,NotLink,OperationUnsupported,PathAlreadyExists,PermissionDenied,PipeBusy,ProcessFdQuotaExceeded,ProcessNotFound,SymLinkLoop,SystemFdQuotaExceeded,SystemResources,Unexpected,UnrecognizedVolume}!usize", scope: !4, size: 128, align: 64, elements: !1441)
!1441 = !{!1442, !1444}
!1442 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1440, baseType: !1443, size: 16, align: 16, offset: 64)
!1443 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{AccessDenied,AntivirusInterference,BadPathName,Canceled,DeviceBusy,FileNotFound,FileSystem,FileTooBig,InputOutput,IsDir,NameTooLong,NetworkNotFound,NoDevice,NoSpaceLeft,NotDir,NotLink,OperationUnsupported,PathAlreadyExists,PermissionDenied,PipeBusy,ProcessFdQuotaExceeded,ProcessNotFound,SymLinkLoop,SystemFdQuotaExceeded,SystemResources,Unexpected,UnrecognizedVolume}", scope: !4, baseType: !845, size: 16, align: 16)
!1444 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1440, baseType: !73, size: 64, align: 64)
!1445 = !DIDerivedType(tag: DW_TAG_member, name: "lockStderr", scope: !1036, baseType: !1446, size: 64, align: 64, offset: 4800)
!1446 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, ?Io.Terminal.Mode) error{Canceled}!Io.LockedStderr", scope: !4, baseType: !1101, size: 64, align: 64)
!1447 = !DIDerivedType(tag: DW_TAG_member, name: "tryLockStderr", scope: !1036, baseType: !1448, size: 64, align: 64, offset: 4864)
!1448 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, ?Io.Terminal.Mode) error{Canceled}!?Io.LockedStderr", scope: !4, baseType: !1101, size: 64, align: 64)
!1449 = !DIDerivedType(tag: DW_TAG_member, name: "unlockStderr", scope: !1036, baseType: !1039, size: 64, align: 64, offset: 4928)
!1450 = !DIDerivedType(tag: DW_TAG_member, name: "processCurrentPath", scope: !1036, baseType: !1451, size: 64, align: 64, offset: 4992)
!1451 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, []u8) error{Canceled,CurrentDirUnlinked,NameTooLong,Unexpected}!usize", scope: !4, baseType: !1452, size: 64, align: 64)
!1452 = !DISubroutineType(types: !1453)
!1453 = !{!99, !1454, !807, !774}
!1454 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*error{Canceled,CurrentDirUnlinked,NameTooLong,Unexpected}!usize", scope: !4, baseType: !1455, size: 64, align: 64)
!1455 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{Canceled,CurrentDirUnlinked,NameTooLong,Unexpected}!usize", scope: !4, size: 128, align: 64, elements: !1456)
!1456 = !{!1457, !1459}
!1457 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1455, baseType: !1458, size: 16, align: 16, offset: 64)
!1458 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{Canceled,CurrentDirUnlinked,NameTooLong,Unexpected}", scope: !4, baseType: !845, size: 16, align: 16)
!1459 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1455, baseType: !73, size: 64, align: 64)
!1460 = !DIDerivedType(tag: DW_TAG_member, name: "processSetCurrentDir", scope: !1036, baseType: !1461, size: 64, align: 64, offset: 5056)
!1461 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Dir) error{AccessDenied,BadPathName,Canceled,FileNotFound,FileSystem,NameTooLong,NoDevice,NotDir,OperationUnsupported,Unexpected,UnrecognizedVolume}!void", scope: !4, baseType: !1101, size: 64, align: 64)
!1462 = !DIDerivedType(tag: DW_TAG_member, name: "processSetCurrentPath", scope: !1036, baseType: !1463, size: 64, align: 64, offset: 5120)
!1463 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, []const u8) error{AccessDenied,BadPathName,Canceled,FileNotFound,FileSystem,InvalidWtf8,NameTooLong,NoDevice,NotDir,OperationUnsupported,SymLinkLoop,SystemResources,Unexpected}!void", scope: !4, baseType: !1464, size: 64, align: 64)
!1464 = !DISubroutineType(types: !1465)
!1465 = !{!1466, !807, !112}
!1466 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{AccessDenied,BadPathName,Canceled,FileNotFound,FileSystem,InvalidWtf8,NameTooLong,NoDevice,NotDir,OperationUnsupported,SymLinkLoop,SystemResources,Unexpected}!void", scope: !4, size: 16, align: 16, elements: !1467)
!1467 = !{!1468, !1470}
!1468 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1466, baseType: !1469, size: 16, align: 16)
!1469 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{AccessDenied,BadPathName,Canceled,FileNotFound,FileSystem,InvalidWtf8,NameTooLong,NoDevice,NotDir,OperationUnsupported,SymLinkLoop,SystemResources,Unexpected}", scope: !4, baseType: !845, size: 16, align: 16)
!1470 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1466, baseType: !99, align: 8, offset: 16)
!1471 = !DIDerivedType(tag: DW_TAG_member, name: "processReplace", scope: !1036, baseType: !1472, size: 64, align: 64, offset: 5184)
!1472 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, process.ReplaceOptions) error{AccessDenied,BadPathName,Canceled,FileBusy,FileNotFound,FileSystem,InvalidExe,IsDir,NameTooLong,NotDir,OperationUnsupported,OutOfMemory,PermissionDenied,ProcessFdQuotaExceeded,SystemFdQuotaExceeded,SystemResources,Unexpected}", scope: !4, baseType: !1101, size: 64, align: 64)
!1473 = !DIDerivedType(tag: DW_TAG_member, name: "processReplacePath", scope: !1036, baseType: !1474, size: 64, align: 64, offset: 5248)
!1474 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Dir, process.ReplaceOptions) error{AccessDenied,BadPathName,Canceled,FileBusy,FileNotFound,FileSystem,InvalidExe,IsDir,NameTooLong,NotDir,OperationUnsupported,OutOfMemory,PermissionDenied,ProcessFdQuotaExceeded,SystemFdQuotaExceeded,SystemResources,Unexpected}", scope: !4, baseType: !1101, size: 64, align: 64)
!1475 = !DIDerivedType(tag: DW_TAG_member, name: "processSpawn", scope: !1036, baseType: !1476, size: 64, align: 64, offset: 5312)
!1476 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, process.SpawnOptions) error{AccessDenied,AntivirusInterference,BadPathName,Canceled,DeviceBusy,FileBusy,FileLocksUnsupported,FileNotFound,FileSystem,FileTooBig,InvalidBatchScriptArg,InvalidExe,InvalidName,InvalidProcessGroupId,InvalidUserId,InvalidWtf8,IsDir,NameTooLong,NetworkNotFound,NoDevice,NoSpaceLeft,NotDir,OperationUnsupported,OutOfMemory,PathAlreadyExists,PermissionDenied,PipeBusy,ProcessAlreadyExec,ProcessFdQuotaExceeded,ReadOnlyFileSystem,ResourceLimitReached,SymLinkLoop,SystemFdQuotaExceeded,SystemResources,Unexpected,UnrecognizedVolume,WouldBlock}!process.Child", scope: !4, baseType: !1101, size: 64, align: 64)
!1477 = !DIDerivedType(tag: DW_TAG_member, name: "processSpawnPath", scope: !1036, baseType: !1478, size: 64, align: 64, offset: 5376)
!1478 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Dir, process.SpawnOptions) error{AccessDenied,AntivirusInterference,BadPathName,Canceled,DeviceBusy,FileBusy,FileLocksUnsupported,FileNotFound,FileSystem,FileTooBig,InvalidBatchScriptArg,InvalidExe,InvalidName,InvalidProcessGroupId,InvalidUserId,InvalidWtf8,IsDir,NameTooLong,NetworkNotFound,NoDevice,NoSpaceLeft,NotDir,OperationUnsupported,OutOfMemory,PathAlreadyExists,PermissionDenied,PipeBusy,ProcessAlreadyExec,ProcessFdQuotaExceeded,ReadOnlyFileSystem,ResourceLimitReached,SymLinkLoop,SystemFdQuotaExceeded,SystemResources,Unexpected,UnrecognizedVolume,WouldBlock}!process.Child", scope: !4, baseType: !1101, size: 64, align: 64)
!1479 = !DIDerivedType(tag: DW_TAG_member, name: "childWait", scope: !1036, baseType: !1480, size: 64, align: 64, offset: 5440)
!1480 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, *process.Child) error{AccessDenied,Canceled,Unexpected}!process.Child.Term", scope: !4, baseType: !1101, size: 64, align: 64)
!1481 = !DIDerivedType(tag: DW_TAG_member, name: "childKill", scope: !1036, baseType: !1482, size: 64, align: 64, offset: 5504)
!1482 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, *process.Child) void", scope: !4, baseType: !1483, size: 64, align: 64)
!1483 = !DISubroutineType(types: !1484)
!1484 = !{!99, !807, !1485}
!1485 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*process.Child", scope: !4, baseType: !1486, size: 64, align: 64)
!1486 = !DIBasicType(name: "process.Child", encoding: DW_ATE_signed)
!1487 = !DIDerivedType(tag: DW_TAG_member, name: "progressParentFile", scope: !1036, baseType: !1488, size: 64, align: 64, offset: 5568)
!1488 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque) error{EnvironmentVariableMissing,UnrecognizedFormat,UnsupportedOperation}!Io.File", scope: !4, baseType: !1489, size: 64, align: 64)
!1489 = !DISubroutineType(types: !1490)
!1490 = !{!99, !1491, !807}
!1491 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*error{EnvironmentVariableMissing,UnrecognizedFormat,UnsupportedOperation}!Io.File", scope: !4, baseType: !1492, size: 64, align: 64)
!1492 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{EnvironmentVariableMissing,UnrecognizedFormat,UnsupportedOperation}!Io.File", scope: !4, size: 96, align: 32, elements: !1493)
!1493 = !{!1494, !1496}
!1494 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1492, baseType: !1495, size: 16, align: 16, offset: 64)
!1495 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{EnvironmentVariableMissing,UnrecognizedFormat,UnsupportedOperation}", scope: !4, baseType: !845, size: 16, align: 16)
!1496 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1492, baseType: !781, size: 64, align: 32)
!1497 = !DIDerivedType(tag: DW_TAG_member, name: "now", scope: !1036, baseType: !1498, size: 64, align: 64, offset: 5632)
!1498 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Clock) Io.Timestamp", scope: !4, baseType: !1101, size: 64, align: 64)
!1499 = !DIDerivedType(tag: DW_TAG_member, name: "clockResolution", scope: !1036, baseType: !1500, size: 64, align: 64, offset: 5696)
!1500 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Clock) error{ClockUnavailable,Unexpected}!Io.Duration", scope: !4, baseType: !1101, size: 64, align: 64)
!1501 = !DIDerivedType(tag: DW_TAG_member, name: "sleep", scope: !1036, baseType: !1502, size: 64, align: 64, offset: 5760)
!1502 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.Timeout) error{Canceled}!void", scope: !4, baseType: !1101, size: 64, align: 64)
!1503 = !DIDerivedType(tag: DW_TAG_member, name: "random", scope: !1036, baseType: !1504, size: 64, align: 64, offset: 5824)
!1504 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, []u8) void", scope: !4, baseType: !1505, size: 64, align: 64)
!1505 = !DISubroutineType(types: !1506)
!1506 = !{!99, !807, !774}
!1507 = !DIDerivedType(tag: DW_TAG_member, name: "randomSecure", scope: !1036, baseType: !1508, size: 64, align: 64, offset: 5888)
!1508 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, []u8) error{Canceled,EntropyUnavailable}!void", scope: !4, baseType: !1509, size: 64, align: 64)
!1509 = !DISubroutineType(types: !1510)
!1510 = !{!1511, !807, !774}
!1511 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{Canceled,EntropyUnavailable}!void", scope: !4, size: 16, align: 16, elements: !1512)
!1512 = !{!1513, !1515}
!1513 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1511, baseType: !1514, size: 16, align: 16)
!1514 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{Canceled,EntropyUnavailable}", scope: !4, baseType: !845, size: 16, align: 16)
!1515 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1511, baseType: !99, align: 8, offset: 16)
!1516 = !DIDerivedType(tag: DW_TAG_member, name: "netListenIp", scope: !1036, baseType: !1517, size: 64, align: 64, offset: 5952)
!1517 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, *const Io.net.IpAddress, Io.net.IpAddress.ListenOptions) error{AddressFamilyUnsupported,AddressInUse,AddressUnavailable,Canceled,NetworkDown,OptionUnsupported,ProcessFdQuotaExceeded,ProtocolUnsupportedByAddressFamily,ProtocolUnsupportedBySystem,SocketModeUnsupported,SystemFdQuotaExceeded,SystemResources,Unexpected}!Io.net.Socket", scope: !4, baseType: !1101, size: 64, align: 64)
!1518 = !DIDerivedType(tag: DW_TAG_member, name: "netAccept", scope: !1036, baseType: !1519, size: 64, align: 64, offset: 6016)
!1519 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, i32, void) error{BlockedByFirewall,Canceled,ConnectionAborted,NetworkDown,ProcessFdQuotaExceeded,ProtocolFailure,SocketNotListening,SystemFdQuotaExceeded,SystemResources,Unexpected,WouldBlock}!Io.net.Socket", scope: !4, baseType: !1101, size: 64, align: 64)
!1520 = !DIDerivedType(tag: DW_TAG_member, name: "netBindIp", scope: !1036, baseType: !1521, size: 64, align: 64, offset: 6080)
!1521 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, *const Io.net.IpAddress, Io.net.IpAddress.BindOptions) error{AddressFamilyUnsupported,AddressInUse,AddressUnavailable,Canceled,NetworkDown,OptionUnsupported,ProcessFdQuotaExceeded,ProtocolUnsupportedByAddressFamily,ProtocolUnsupportedBySystem,SocketModeUnsupported,SystemFdQuotaExceeded,SystemResources,Unexpected}!Io.net.Socket", scope: !4, baseType: !1101, size: 64, align: 64)
!1522 = !DIDerivedType(tag: DW_TAG_member, name: "netConnectIp", scope: !1036, baseType: !1523, size: 64, align: 64, offset: 6144)
!1523 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, *const Io.net.IpAddress, Io.net.IpAddress.ConnectOptions) error{AccessDenied,AddressFamilyUnsupported,AddressUnavailable,Canceled,ConnectionPending,ConnectionRefused,ConnectionResetByPeer,HostUnreachable,NetworkDown,NetworkUnreachable,OptionUnsupported,ProcessFdQuotaExceeded,ProtocolUnsupportedByAddressFamily,ProtocolUnsupportedBySystem,SocketModeUnsupported,SystemFdQuotaExceeded,SystemResources,Timeout,Unexpected,WouldBlock}!Io.net.Socket", scope: !4, baseType: !1101, size: 64, align: 64)
!1524 = !DIDerivedType(tag: DW_TAG_member, name: "netListenUnix", scope: !1036, baseType: !1525, size: 64, align: 64, offset: 6208)
!1525 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, *const Io.net.UnixAddress, Io.net.UnixAddress.ListenOptions) error{AccessDenied,AddressFamilyUnsupported,AddressInUse,AddressUnavailable,Canceled,FileNotFound,NetworkDown,NotDir,PermissionDenied,ProcessFdQuotaExceeded,ReadOnlyFileSystem,SymLinkLoop,SystemFdQuotaExceeded,SystemResources,Unexpected}!i32", scope: !4, baseType: !1101, size: 64, align: 64)
!1526 = !DIDerivedType(tag: DW_TAG_member, name: "netConnectUnix", scope: !1036, baseType: !1527, size: 64, align: 64, offset: 6272)
!1527 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, *const Io.net.UnixAddress) error{AccessDenied,AddressFamilyUnsupported,Canceled,FileNotFound,NetworkDown,NotDir,PermissionDenied,ProcessFdQuotaExceeded,ProtocolUnsupportedBySystem,ReadOnlyFileSystem,SocketModeUnsupported,SymLinkLoop,SystemFdQuotaExceeded,SystemResources,Unexpected,WouldBlock}!i32", scope: !4, baseType: !1528, size: 64, align: 64)
!1528 = !DISubroutineType(types: !1529)
!1529 = !{!99, !1530, !807, !1536}
!1530 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*error{AccessDenied,AddressFamilyUnsupported,Canceled,FileNotFound,NetworkDown,NotDir,PermissionDenied,ProcessFdQuotaExceeded,ProtocolUnsupportedBySystem,ReadOnlyFileSystem,SocketModeUnsupported,SymLinkLoop,SystemFdQuotaExceeded,SystemResources,Unexpected,WouldBlock}!i32", scope: !4, baseType: !1531, size: 64, align: 64)
!1531 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{AccessDenied,AddressFamilyUnsupported,Canceled,FileNotFound,NetworkDown,NotDir,PermissionDenied,ProcessFdQuotaExceeded,ProtocolUnsupportedBySystem,ReadOnlyFileSystem,SocketModeUnsupported,SymLinkLoop,SystemFdQuotaExceeded,SystemResources,Unexpected,WouldBlock}!i32", scope: !4, size: 64, align: 32, elements: !1532)
!1532 = !{!1533, !1535}
!1533 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1531, baseType: !1534, size: 16, align: 16, offset: 32)
!1534 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{AccessDenied,AddressFamilyUnsupported,Canceled,FileNotFound,NetworkDown,NotDir,PermissionDenied,ProcessFdQuotaExceeded,ProtocolUnsupportedBySystem,ReadOnlyFileSystem,SocketModeUnsupported,SymLinkLoop,SystemFdQuotaExceeded,SystemResources,Unexpected,WouldBlock}", scope: !4, baseType: !845, size: 16, align: 16)
!1535 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1531, baseType: !785, size: 32, align: 32)
!1536 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const Io.net.UnixAddress", scope: !4, baseType: !1537, size: 64, align: 64)
!1537 = !DIBasicType(name: "Io.net.UnixAddress", encoding: DW_ATE_signed)
!1538 = !DIDerivedType(tag: DW_TAG_member, name: "netSocketCreatePair", scope: !1036, baseType: !1539, size: 64, align: 64, offset: 6336)
!1539 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.net.Socket.CreatePairOptions) error{AccessDenied,AddressFamilyUnsupported,Canceled,OperationUnsupported,ProcessFdQuotaExceeded,ProtocolUnsupportedByAddressFamily,ProtocolUnsupportedBySystem,SocketModeUnsupported,SystemFdQuotaExceeded,SystemResources,Unexpected}![2]Io.net.Socket", scope: !4, baseType: !1101, size: 64, align: 64)
!1540 = !DIDerivedType(tag: DW_TAG_member, name: "netSend", scope: !1036, baseType: !1541, size: 64, align: 64, offset: 6400)
!1541 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, i32, []Io.net.OutgoingMessage, Io.net.SendFlags) struct { ?error{AccessDenied,AddressFamilyUnsupported,Canceled,ConnectionRefused,ConnectionResetByPeer,FastOpenAlreadyInProgress,HostUnreachable,MessageOversize,NetworkDown,NetworkUnreachable,SocketUnconnected,SystemResources,Unexpected}, usize }", scope: !4, baseType: !1101, size: 64, align: 64)
!1542 = !DIDerivedType(tag: DW_TAG_member, name: "netRead", scope: !1036, baseType: !1543, size: 64, align: 64, offset: 6464)
!1543 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, i32, [][]u8) error{AccessDenied,Canceled,ConnectionResetByPeer,NetworkDown,SocketUnconnected,SystemResources,Timeout,Unexpected}!usize", scope: !4, baseType: !1544, size: 64, align: 64)
!1544 = !DISubroutineType(types: !1545)
!1545 = !{!99, !1546, !807, !785, !1552}
!1546 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*error{AccessDenied,Canceled,ConnectionResetByPeer,NetworkDown,SocketUnconnected,SystemResources,Timeout,Unexpected}!usize", scope: !4, baseType: !1547, size: 64, align: 64)
!1547 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{AccessDenied,Canceled,ConnectionResetByPeer,NetworkDown,SocketUnconnected,SystemResources,Timeout,Unexpected}!usize", scope: !4, size: 128, align: 64, elements: !1548)
!1548 = !{!1549, !1551}
!1549 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1547, baseType: !1550, size: 16, align: 16, offset: 64)
!1550 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{AccessDenied,Canceled,ConnectionResetByPeer,NetworkDown,SocketUnconnected,SystemResources,Timeout,Unexpected}", scope: !4, baseType: !845, size: 16, align: 16)
!1551 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1547, baseType: !73, size: 64, align: 64)
!1552 = !DICompositeType(tag: DW_TAG_structure_type, name: "[][]u8", scope: !4, size: 128, align: 64, elements: !1553)
!1553 = !{!1554, !1556}
!1554 = !DIDerivedType(tag: DW_TAG_member, name: "ptr", scope: !1552, baseType: !1555, size: 64, align: 64)
!1555 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "[*][]u8", scope: !4, baseType: !774, size: 64, align: 64)
!1556 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !1552, baseType: !73, size: 64, align: 64, offset: 64)
!1557 = !DIDerivedType(tag: DW_TAG_member, name: "netWrite", scope: !1036, baseType: !1558, size: 64, align: 64, offset: 6528)
!1558 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, i32, []const u8, []const []const u8, usize) error{AddressFamilyUnsupported,Canceled,ConnectionRefused,ConnectionResetByPeer,FastOpenAlreadyInProgress,HostUnreachable,NetworkDown,NetworkUnreachable,SocketNotBound,SocketUnconnected,SystemResources,Unexpected}!usize", scope: !4, baseType: !1559, size: 64, align: 64)
!1559 = !DISubroutineType(types: !1560)
!1560 = !{!99, !1561, !807, !785, !112, !796, !73}
!1561 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*error{AddressFamilyUnsupported,Canceled,ConnectionRefused,ConnectionResetByPeer,FastOpenAlreadyInProgress,HostUnreachable,NetworkDown,NetworkUnreachable,SocketNotBound,SocketUnconnected,SystemResources,Unexpected}!usize", scope: !4, baseType: !1562, size: 64, align: 64)
!1562 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{AddressFamilyUnsupported,Canceled,ConnectionRefused,ConnectionResetByPeer,FastOpenAlreadyInProgress,HostUnreachable,NetworkDown,NetworkUnreachable,SocketNotBound,SocketUnconnected,SystemResources,Unexpected}!usize", scope: !4, size: 128, align: 64, elements: !1563)
!1563 = !{!1564, !1566}
!1564 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1562, baseType: !1565, size: 16, align: 16, offset: 64)
!1565 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{AddressFamilyUnsupported,Canceled,ConnectionRefused,ConnectionResetByPeer,FastOpenAlreadyInProgress,HostUnreachable,NetworkDown,NetworkUnreachable,SocketNotBound,SocketUnconnected,SystemResources,Unexpected}", scope: !4, baseType: !845, size: 16, align: 16)
!1566 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1562, baseType: !73, size: 64, align: 64)
!1567 = !DIDerivedType(tag: DW_TAG_member, name: "netWriteFile", scope: !1036, baseType: !1568, size: 64, align: 64, offset: 6592)
!1568 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, i32, []const u8, *Io.File.Reader, Io.Limit) error{Canceled,NetworkDown,Unexpected}!usize", scope: !4, baseType: !1569, size: 64, align: 64)
!1569 = !DISubroutineType(types: !1570)
!1570 = !{!99, !1571, !807, !785, !112, !1280, !72}
!1571 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*error{Canceled,NetworkDown,Unexpected}!usize", scope: !4, baseType: !1572, size: 64, align: 64)
!1572 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{Canceled,NetworkDown,Unexpected}!usize", scope: !4, size: 128, align: 64, elements: !1573)
!1573 = !{!1574, !1576}
!1574 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1572, baseType: !1575, size: 16, align: 16, offset: 64)
!1575 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{Canceled,NetworkDown,Unexpected}", scope: !4, baseType: !845, size: 16, align: 16)
!1576 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1572, baseType: !73, size: 64, align: 64)
!1577 = !DIDerivedType(tag: DW_TAG_member, name: "netClose", scope: !1036, baseType: !1578, size: 64, align: 64, offset: 6656)
!1578 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, []const i32) void", scope: !4, baseType: !1579, size: 64, align: 64)
!1579 = !DISubroutineType(types: !1580)
!1580 = !{!99, !807, !1581}
!1581 = !DICompositeType(tag: DW_TAG_structure_type, name: "[]const i32", scope: !4, size: 128, align: 64, elements: !1582)
!1582 = !{!1583, !1585}
!1583 = !DIDerivedType(tag: DW_TAG_member, name: "ptr", scope: !1581, baseType: !1584, size: 64, align: 64)
!1584 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "[*]const i32", scope: !4, baseType: !785, size: 64, align: 64)
!1585 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !1581, baseType: !73, size: 64, align: 64, offset: 64)
!1586 = !DIDerivedType(tag: DW_TAG_member, name: "netShutdown", scope: !1036, baseType: !1587, size: 64, align: 64, offset: 6720)
!1587 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, i32, Io.net.ShutdownHow) error{Canceled,ConnectionAborted,ConnectionResetByPeer,NetworkDown,SocketUnconnected,SystemResources,Unexpected}!void", scope: !4, baseType: !1101, size: 64, align: 64)
!1588 = !DIDerivedType(tag: DW_TAG_member, name: "netInterfaceNameResolve", scope: !1036, baseType: !1589, size: 64, align: 64, offset: 6784)
!1589 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, *const Io.net.Interface.Name) error{AccessDenied,Canceled,InterfaceNotFound,SystemResources,Unexpected}!Io.net.Interface", scope: !4, baseType: !1101, size: 64, align: 64)
!1590 = !DIDerivedType(tag: DW_TAG_member, name: "netInterfaceName", scope: !1036, baseType: !1591, size: 64, align: 64, offset: 6848)
!1591 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.net.Interface) error{Canceled,InterfaceNotFound,NameTooLong,Unexpected}!Io.net.Interface.Name", scope: !4, baseType: !1101, size: 64, align: 64)
!1592 = !DIDerivedType(tag: DW_TAG_member, name: "netLookup", scope: !1036, baseType: !1593, size: 64, align: 64, offset: 6912)
!1593 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (?*anyopaque, Io.net.HostName, *Io.Queue(Io.net.HostName.LookupResult), Io.net.HostName.LookupOptions) error{AddressFamilyUnsupported,AddressInUse,AddressUnavailable,Canceled,DetectingNetworkConfigurationFailed,InvalidDnsAAAARecord,InvalidDnsARecord,InvalidDnsCnameRecord,NameServerFailure,NetworkDown,NoAddressReturned,OptionUnsupported,ProcessFdQuotaExceeded,ProtocolUnsupportedByAddressFamily,ProtocolUnsupportedBySystem,ResolvConfParseFailed,SocketModeUnsupported,SystemFdQuotaExceeded,SystemResources,Unexpected,UnknownHostName}!void", scope: !4, baseType: !1101, size: 64, align: 64)
!1594 = !DIDerivedType(tag: DW_TAG_member, name: "pos", scope: !1027, baseType: !227, size: 64, align: 64, offset: 128)
!1595 = !DIDerivedType(tag: DW_TAG_member, name: "interface", scope: !1027, baseType: !1596, size: 256, align: 64, offset: 192)
!1596 = !DICompositeType(tag: DW_TAG_structure_type, name: "Io.Writer", scope: !1597, file: !1597, line: 2886, size: 256, align: 64, elements: !1598)
!1597 = !DIFile(filename: "Writer.zig", directory: "/Users/sulky/.zvm/master/lib/std/Io")
!1598 = !{!1599, !1636, !1637}
!1599 = !DIDerivedType(tag: DW_TAG_member, name: "vtable", scope: !1596, baseType: !1600, size: 64, align: 64)
!1600 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const Io.Writer.VTable", scope: !4, baseType: !1601, size: 64, align: 64)
!1601 = !DICompositeType(tag: DW_TAG_structure_type, name: "Io.Writer.VTable", scope: !1597, file: !1597, line: 20, size: 256, align: 64, elements: !1602)
!1602 = !{!1603, !1614, !1624, !1632}
!1603 = !DIDerivedType(tag: DW_TAG_member, name: "drain", scope: !1601, baseType: !1604, size: 64, align: 64)
!1604 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (*Io.Writer, []const []const u8, usize) error{WriteFailed}!usize", scope: !4, baseType: !1605, size: 64, align: 64)
!1605 = !DISubroutineType(types: !1606)
!1606 = !{!99, !1607, !1613, !796, !73}
!1607 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*error{WriteFailed}!usize", scope: !4, baseType: !1608, size: 64, align: 64)
!1608 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{WriteFailed}!usize", scope: !4, size: 128, align: 64, elements: !1609)
!1609 = !{!1610, !1612}
!1610 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1608, baseType: !1611, size: 16, align: 16, offset: 64)
!1611 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{WriteFailed}", scope: !4, baseType: !845, size: 16, align: 16)
!1612 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1608, baseType: !73, size: 64, align: 64)
!1613 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*Io.Writer", scope: !4, baseType: !1596, size: 64, align: 64)
!1614 = !DIDerivedType(tag: DW_TAG_member, name: "sendFile", scope: !1601, baseType: !1615, size: 64, align: 64, offset: 64)
!1615 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (*Io.Writer, *Io.File.Reader, Io.Limit) error{EndOfStream,ReadFailed,Unimplemented,WriteFailed}!usize", scope: !4, baseType: !1616, size: 64, align: 64)
!1616 = !DISubroutineType(types: !1617)
!1617 = !{!99, !1618, !1613, !1280, !72}
!1618 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*error{EndOfStream,ReadFailed,Unimplemented,WriteFailed}!usize", scope: !4, baseType: !1619, size: 64, align: 64)
!1619 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{EndOfStream,ReadFailed,Unimplemented,WriteFailed}!usize", scope: !4, size: 128, align: 64, elements: !1620)
!1620 = !{!1621, !1623}
!1621 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1619, baseType: !1622, size: 16, align: 16, offset: 64)
!1622 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{EndOfStream,ReadFailed,Unimplemented,WriteFailed}", scope: !4, baseType: !845, size: 16, align: 16)
!1623 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1619, baseType: !73, size: 64, align: 64)
!1624 = !DIDerivedType(tag: DW_TAG_member, name: "flush", scope: !1601, baseType: !1625, size: 64, align: 64, offset: 128)
!1625 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (*Io.Writer) error{WriteFailed}!void", scope: !4, baseType: !1626, size: 64, align: 64)
!1626 = !DISubroutineType(types: !1627)
!1627 = !{!1628, !1613}
!1628 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{WriteFailed}!void", scope: !4, size: 16, align: 16, elements: !1629)
!1629 = !{!1630, !1631}
!1630 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1628, baseType: !1611, size: 16, align: 16)
!1631 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1628, baseType: !99, align: 8, offset: 16)
!1632 = !DIDerivedType(tag: DW_TAG_member, name: "rebase", scope: !1601, baseType: !1633, size: 64, align: 64, offset: 192)
!1633 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (*Io.Writer, usize, usize) error{WriteFailed}!void", scope: !4, baseType: !1634, size: 64, align: 64)
!1634 = !DISubroutineType(types: !1635)
!1635 = !{!1628, !1613, !73, !73}
!1636 = !DIDerivedType(tag: DW_TAG_member, name: "buffer", scope: !1596, baseType: !774, size: 128, align: 64, offset: 64)
!1637 = !DIDerivedType(tag: DW_TAG_member, name: "end", scope: !1596, baseType: !73, size: 64, align: 64, offset: 192)
!1638 = !DIDerivedType(tag: DW_TAG_member, name: "file", scope: !1027, baseType: !781, size: 64, align: 32, offset: 448)
!1639 = !DIDerivedType(tag: DW_TAG_member, name: "err", scope: !1027, baseType: !1640, size: 16, align: 16, offset: 512)
!1640 = !DIDerivedType(tag: DW_TAG_typedef, name: "?error{AccessDenied,BrokenPipe,Canceled,DeviceBusy,DiskQuota,FileBusy,FileTooBig,InputOutput,LockViolation,NoDevice,NoSpaceLeft,NotOpenForWriting,PermissionDenied,SystemResources,Unexpected,WouldBlock}", scope: !4, baseType: !1641, size: 16, align: 16)
!1641 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{AccessDenied,BrokenPipe,Canceled,DeviceBusy,DiskQuota,FileBusy,FileTooBig,InputOutput,LockViolation,NoDevice,NoSpaceLeft,NotOpenForWriting,PermissionDenied,SystemResources,Unexpected,WouldBlock}", scope: !4, baseType: !845, size: 16, align: 16)
!1642 = !DIDerivedType(tag: DW_TAG_member, name: "write_file_err", scope: !1027, baseType: !1643, size: 16, align: 16, offset: 528)
!1643 = !DIDerivedType(tag: DW_TAG_typedef, name: "?error{AccessDenied,BrokenPipe,Canceled,CorruptedData,DeviceBusy,DiskQuota,EndOfStream,FileBusy,FileTooBig,InputOutput,LockViolation,NoDevice,NoSpaceLeft,NotOpenForWriting,PermissionDenied,ReadFailed,SystemResources,Unexpected,Unimplemented,WouldBlock}", scope: !4, baseType: !1278, size: 16, align: 16)
!1644 = !DIDerivedType(tag: DW_TAG_member, name: "seek_err", scope: !1027, baseType: !1645, size: 16, align: 16, offset: 544)
!1645 = !DIDerivedType(tag: DW_TAG_typedef, name: "?error{AccessDenied,Canceled,Unexpected,Unseekable}", scope: !4, baseType: !1309, size: 16, align: 16)
!1646 = !DIDerivedType(tag: DW_TAG_member, name: "mode", scope: !1027, baseType: !82, size: 8, align: 8, offset: 560)
!1647 = !DIDerivedType(tag: DW_TAG_member, name: "run_queue", scope: !1024, baseType: !1648, size: 64, align: 64, offset: 576)
!1648 = !DICompositeType(tag: DW_TAG_structure_type, name: "SinglyLinkedList", scope: !1649, file: !1649, line: 168, size: 64, align: 64, elements: !1650)
!1649 = !DIFile(filename: "SinglyLinkedList.zig", directory: "/Users/sulky/.zvm/master/lib/std")
!1650 = !{!1651}
!1651 = !DIDerivedType(tag: DW_TAG_member, name: "first", scope: !1648, baseType: !1652, size: 64, align: 64)
!1652 = !DIDerivedType(tag: DW_TAG_typedef, name: "?*SinglyLinkedList.Node", scope: !4, baseType: !1653, size: 64, align: 64)
!1653 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*SinglyLinkedList.Node", scope: !4, baseType: !1654, size: 64, align: 64)
!1654 = !DIBasicType(name: "SinglyLinkedList.Node", encoding: DW_ATE_signed)
!1655 = !DIDerivedType(tag: DW_TAG_member, name: "csprng", scope: !1024, baseType: !1656, size: 4160, align: 64, offset: 640)
!1656 = !DICompositeType(tag: DW_TAG_structure_type, name: "Io.Threaded.Csprng", scope: !8, file: !8, line: 166, size: 4160, align: 64, elements: !1657)
!1657 = !{!1658}
!1658 = !DIDerivedType(tag: DW_TAG_member, name: "rng", scope: !1656, baseType: !1659, size: 4160, align: 64)
!1659 = !DICompositeType(tag: DW_TAG_structure_type, name: "Random.ChaCha", scope: !1660, file: !1660, line: 97, size: 4160, align: 64, elements: !1661)
!1660 = !DIFile(filename: "ChaCha.zig", directory: "/Users/sulky/.zvm/master/lib/std/Random")
!1661 = !{!1662, !1663}
!1662 = !DIDerivedType(tag: DW_TAG_member, name: "offset", scope: !1659, baseType: !73, size: 64, align: 64)
!1663 = !DIDerivedType(tag: DW_TAG_member, name: "state", scope: !1659, baseType: !1664, size: 4096, align: 8, offset: 64)
!1664 = !DICompositeType(tag: DW_TAG_array_type, name: "[512]u8", scope: !4, baseType: !116, size: 4096, align: 8, elements: !1665)
!1665 = !{!1666}
!1666 = !DISubrange(count: 512, lowerBound: 0)
!1667 = !DIDerivedType(tag: DW_TAG_member, name: "stack_size", scope: !1024, baseType: !73, size: 64, align: 64, offset: 4800)
!1668 = !DIDerivedType(tag: DW_TAG_member, name: "wait_group", scope: !1024, baseType: !1669, size: 128, align: 64, offset: 4864)
!1669 = !DICompositeType(tag: DW_TAG_structure_type, name: "Io.Threaded.WaitGroup", scope: !8, file: !8, line: 18627, size: 128, align: 64, elements: !1670)
!1670 = !{!1671, !1675}
!1671 = !DIDerivedType(tag: DW_TAG_member, name: "state", scope: !1669, baseType: !1672, size: 64, align: 64)
!1672 = !DICompositeType(tag: DW_TAG_structure_type, name: "atomic.Value(usize)", scope: !30, file: !30, line: 120, size: 64, align: 64, elements: !1673)
!1673 = !{!1674}
!1674 = !DIDerivedType(tag: DW_TAG_member, name: "raw", scope: !1672, baseType: !73, size: 64, align: 64)
!1675 = !DIDerivedType(tag: DW_TAG_member, name: "event", scope: !1669, baseType: !77, size: 32, align: 32, offset: 64)
!1676 = !DIDerivedType(tag: DW_TAG_member, name: "async_limit", scope: !1024, baseType: !72, size: 64, align: 64, offset: 4992)
!1677 = !DIDerivedType(tag: DW_TAG_member, name: "concurrent_limit", scope: !1024, baseType: !72, size: 64, align: 64, offset: 5056)
!1678 = !DIDerivedType(tag: DW_TAG_member, name: "busy_count", scope: !1024, baseType: !73, size: 64, align: 64, offset: 5120)
!1679 = !DIDerivedType(tag: DW_TAG_member, name: "worker_threads", scope: !1024, baseType: !1680, size: 64, align: 64, offset: 5184)
!1680 = !DICompositeType(tag: DW_TAG_structure_type, name: "atomic.Value(?*Io.Threaded.Thread)", scope: !30, file: !30, line: 120, size: 64, align: 64, elements: !1681)
!1681 = !{!1682}
!1682 = !DIDerivedType(tag: DW_TAG_member, name: "raw", scope: !1680, baseType: !1683, size: 64, align: 64)
!1683 = !DIDerivedType(tag: DW_TAG_typedef, name: "?*Io.Threaded.Thread", scope: !4, baseType: !1684, size: 64, align: 64)
!1684 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*Io.Threaded.Thread", scope: !4, baseType: !1685, size: 64, align: 64)
!1685 = !DIBasicType(name: "Io.Threaded.Thread", encoding: DW_ATE_signed)
!1686 = !DIDerivedType(tag: DW_TAG_member, name: "environ", scope: !1024, baseType: !1687, size: 768, align: 64, offset: 5248)
!1687 = !DICompositeType(tag: DW_TAG_structure_type, name: "Io.Threaded.Environ", scope: !8, file: !8, line: 340, size: 768, align: 64, elements: !1688)
!1688 = !{!1689, !1702, !1709, !1710, !1713}
!1689 = !DIDerivedType(tag: DW_TAG_member, name: "process_environ", scope: !1687, baseType: !1690, size: 128, align: 64)
!1690 = !DICompositeType(tag: DW_TAG_structure_type, name: "process.Environ", scope: !991, file: !991, line: 1007, size: 128, align: 64, elements: !1691)
!1691 = !{!1692}
!1692 = !DIDerivedType(tag: DW_TAG_member, name: "block", scope: !1690, baseType: !1693, size: 128, align: 64)
!1693 = !DICompositeType(tag: DW_TAG_structure_type, name: "process.Environ.PosixBlock", scope: !991, file: !991, line: 71, size: 128, align: 64, elements: !1694)
!1694 = !{!1695}
!1695 = !DIDerivedType(tag: DW_TAG_member, name: "slice", scope: !1693, baseType: !1696, size: 128, align: 64)
!1696 = !DICompositeType(tag: DW_TAG_structure_type, name: "[:null]const ?[*:0]const u8", scope: !4, size: 128, align: 64, elements: !1697)
!1697 = !{!1698, !1701}
!1698 = !DIDerivedType(tag: DW_TAG_member, name: "ptr", scope: !1696, baseType: !1699, size: 64, align: 64)
!1699 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "[*:null]const ?[*:0]const u8", scope: !4, baseType: !1700, size: 64, align: 64)
!1700 = !DIDerivedType(tag: DW_TAG_typedef, name: "?[*:0]const u8", scope: !4, baseType: !554, size: 64, align: 64)
!1701 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !1696, baseType: !73, size: 64, align: 64, offset: 64)
!1702 = !DIDerivedType(tag: DW_TAG_member, name: "string", scope: !1687, baseType: !1703, size: 512, align: 64, offset: 128)
!1703 = !DICompositeType(tag: DW_TAG_structure_type, name: "Io.Threaded.Environ.String__struct_2268", scope: !1687, file: !8, line: 216, size: 512, align: 64, elements: !1704)
!1704 = !{!1705, !1706, !1707, !1708}
!1705 = !DIDerivedType(tag: DW_TAG_member, name: "PATH", scope: !1703, baseType: !550, size: 128, align: 64)
!1706 = !DIDerivedType(tag: DW_TAG_member, name: "DEBUGINFOD_CACHE_PATH", scope: !1703, baseType: !550, size: 128, align: 64, offset: 128)
!1707 = !DIDerivedType(tag: DW_TAG_member, name: "XDG_CACHE_HOME", scope: !1703, baseType: !550, size: 128, align: 64, offset: 256)
!1708 = !DIDerivedType(tag: DW_TAG_member, name: "HOME", scope: !1703, baseType: !550, size: 128, align: 64, offset: 384)
!1709 = !DIDerivedType(tag: DW_TAG_member, name: "zig_progress_file", scope: !1687, baseType: !1492, size: 96, align: 32, offset: 640)
!1710 = !DIDerivedType(tag: DW_TAG_member, name: "err", scope: !1687, baseType: !1711, size: 16, align: 16, offset: 736)
!1711 = !DIDerivedType(tag: DW_TAG_typedef, name: "?error{OutOfMemory,Unexpected}", scope: !4, baseType: !1712, size: 16, align: 16)
!1712 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{OutOfMemory,Unexpected}", scope: !4, baseType: !845, size: 16, align: 16)
!1713 = !DIDerivedType(tag: DW_TAG_member, name: "exist", scope: !1687, baseType: !1714, size: 16, align: 8, offset: 752)
!1714 = !DICompositeType(tag: DW_TAG_structure_type, name: "Io.Threaded.Environ.Exist", scope: !1687, file: !8, line: 209, size: 16, align: 8, elements: !1715)
!1715 = !{!1716, !1717}
!1716 = !DIDerivedType(tag: DW_TAG_member, name: "NO_COLOR", scope: !1714, baseType: !790, size: 8, align: 8)
!1717 = !DIDerivedType(tag: DW_TAG_member, name: "CLICOLOR_FORCE", scope: !1714, baseType: !790, size: 8, align: 8, offset: 8)
!1718 = !DIDerivedType(tag: DW_TAG_member, name: "old_sig_io", scope: !1024, baseType: !1719, size: 128, align: 64, offset: 6016)
!1719 = !DICompositeType(tag: DW_TAG_structure_type, name: "c.Sigaction__struct_2086", scope: !39, file: !39, line: 3222, size: 128, align: 64, elements: !1720)
!1720 = !{!1721, !1736, !1737}
!1721 = !DIDerivedType(tag: DW_TAG_member, name: "handler", scope: !1719, baseType: !1722, size: 64, align: 64)
!1722 = !DICompositeType(tag: DW_TAG_union_type, name: "c.Sigaction__struct_2086__union_2196", scope: !1719, file: !39, line: 3222, size: 64, align: 64, elements: !1723)
!1723 = !{!1724, !1729}
!1724 = !DIDerivedType(tag: DW_TAG_member, name: "handler", scope: !1722, baseType: !1725, size: 64)
!1725 = !DIDerivedType(tag: DW_TAG_typedef, name: "?*align(1) const fn (c.SIG__enum_2017) callconv(.c) void", scope: !4, baseType: !1726, size: 64, align: 64)
!1726 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*align(1) const fn (c.SIG__enum_2017) callconv(.c) void", scope: !4, baseType: !1727, size: 64, align: 64)
!1727 = !DISubroutineType(types: !1728)
!1728 = !{!99, !38}
!1729 = !DIDerivedType(tag: DW_TAG_member, name: "sigaction", scope: !1722, baseType: !1730, size: 64)
!1730 = !DIDerivedType(tag: DW_TAG_typedef, name: "?*const fn (c.SIG__enum_2017, *const c.siginfo_t__struct_2205, ?*anyopaque) callconv(.c) void", scope: !4, baseType: !1731, size: 64, align: 64)
!1731 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (c.SIG__enum_2017, *const c.siginfo_t__struct_2205, ?*anyopaque) callconv(.c) void", scope: !4, baseType: !1732, size: 64, align: 64)
!1732 = !DISubroutineType(types: !1733)
!1733 = !{!99, !38, !1734, !807}
!1734 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const c.siginfo_t__struct_2205", scope: !4, baseType: !1735, size: 64, align: 64)
!1735 = !DIBasicType(name: "c.siginfo_t__struct_2205", encoding: DW_ATE_signed)
!1736 = !DIDerivedType(tag: DW_TAG_member, name: "mask", scope: !1719, baseType: !33, size: 32, align: 32, offset: 64)
!1737 = !DIDerivedType(tag: DW_TAG_member, name: "flags", scope: !1719, baseType: !1738, size: 32, align: 32, offset: 96)
!1738 = !DIBasicType(name: "c_uint", size: 32, encoding: DW_ATE_unsigned)
!1739 = !DIDerivedType(tag: DW_TAG_member, name: "old_sig_pipe", scope: !1024, baseType: !1719, size: 128, align: 64, offset: 6144)
!1740 = !DIDerivedType(tag: DW_TAG_member, name: "stderr_mutex_lock_count", scope: !1024, baseType: !73, size: 64, align: 64, offset: 6272)
!1741 = !DIDerivedType(tag: DW_TAG_member, name: "stderr_mutex_locker", scope: !1024, baseType: !227, size: 64, align: 64, offset: 6336)
!1742 = !DIDerivedType(tag: DW_TAG_member, name: "allocator", scope: !1024, baseType: !1743, size: 128, align: 64, offset: 6400)
!1743 = !DICompositeType(tag: DW_TAG_structure_type, name: "mem.Allocator", scope: !1744, file: !1744, line: 535, size: 128, align: 64, elements: !1745)
!1744 = !DIFile(filename: "Allocator.zig", directory: "/Users/sulky/.zvm/master/lib/std/mem")
!1745 = !{!1746, !1747}
!1746 = !DIDerivedType(tag: DW_TAG_member, name: "ptr", scope: !1743, baseType: !808, size: 64, align: 64)
!1747 = !DIDerivedType(tag: DW_TAG_member, name: "vtable", scope: !1743, baseType: !1748, size: 64, align: 64, offset: 64)
!1748 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const mem.Allocator.VTable", scope: !4, baseType: !1749, size: 64, align: 64)
!1749 = !DICompositeType(tag: DW_TAG_structure_type, name: "mem.Allocator.VTable", scope: !1744, file: !1744, line: 22, size: 256, align: 64, elements: !1750)
!1750 = !{!1751, !1756, !1760, !1764}
!1751 = !DIDerivedType(tag: DW_TAG_member, name: "alloc", scope: !1749, baseType: !1752, size: 64, align: 64)
!1752 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (*anyopaque, usize, mem.Alignment, usize) ?[*]u8", scope: !4, baseType: !1753, size: 64, align: 64)
!1753 = !DISubroutineType(types: !1754)
!1754 = !{!1755, !808, !73, !835, !73}
!1755 = !DIDerivedType(tag: DW_TAG_typedef, name: "?[*]u8", scope: !4, baseType: !777, size: 64, align: 64)
!1756 = !DIDerivedType(tag: DW_TAG_member, name: "resize", scope: !1749, baseType: !1757, size: 64, align: 64, offset: 64)
!1757 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (*anyopaque, []u8, mem.Alignment, usize, usize) bool", scope: !4, baseType: !1758, size: 64, align: 64)
!1758 = !DISubroutineType(types: !1759)
!1759 = !{!790, !808, !774, !835, !73, !73}
!1760 = !DIDerivedType(tag: DW_TAG_member, name: "remap", scope: !1749, baseType: !1761, size: 64, align: 64, offset: 128)
!1761 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (*anyopaque, []u8, mem.Alignment, usize, usize) ?[*]u8", scope: !4, baseType: !1762, size: 64, align: 64)
!1762 = !DISubroutineType(types: !1763)
!1763 = !{!1755, !808, !774, !835, !73, !73}
!1764 = !DIDerivedType(tag: DW_TAG_member, name: "free", scope: !1749, baseType: !1765, size: 64, align: 64, offset: 192)
!1765 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const fn (*anyopaque, []u8, mem.Alignment, usize) void", scope: !4, baseType: !1766, size: 64, align: 64)
!1766 = !DISubroutineType(types: !1767)
!1767 = !{!99, !808, !774, !835, !73}
!1768 = !DIDerivedType(tag: DW_TAG_member, name: "mutex", scope: !1024, baseType: !26, size: 32, align: 32, offset: 6528)
!1769 = !DIDerivedType(tag: DW_TAG_member, name: "cond", scope: !1024, baseType: !1770, size: 64, align: 32, offset: 6560)
!1770 = !DICompositeType(tag: DW_TAG_structure_type, name: "Io.Condition", scope: !25, file: !25, line: 1762, size: 64, align: 32, elements: !1771)
!1771 = !{!1772, !1779}
!1772 = !DIDerivedType(tag: DW_TAG_member, name: "state", scope: !1770, baseType: !1773, size: 32, align: 32)
!1773 = !DICompositeType(tag: DW_TAG_structure_type, name: "atomic.Value(Io.Condition.State)", scope: !30, file: !30, line: 120, size: 32, align: 32, elements: !1774)
!1774 = !{!1775}
!1775 = !DIDerivedType(tag: DW_TAG_member, name: "raw", scope: !1773, baseType: !1776, size: 32, align: 32)
!1776 = !DICompositeType(tag: DW_TAG_structure_type, name: "Io.Condition.State", scope: !1770, file: !25, line: 1658, size: 32, align: 32, elements: !1777)
!1777 = !{!1778}
!1778 = !DIDerivedType(tag: DW_TAG_member, name: "bits", scope: !1776, baseType: !33, size: 32, align: 32)
!1779 = !DIDerivedType(tag: DW_TAG_member, name: "epoch", scope: !1770, baseType: !1780, size: 32, align: 32, offset: 32)
!1780 = !DICompositeType(tag: DW_TAG_structure_type, name: "atomic.Value(u32)", scope: !30, file: !30, line: 120, size: 32, align: 32, elements: !1781)
!1781 = !{!1782}
!1782 = !DIDerivedType(tag: DW_TAG_member, name: "raw", scope: !1780, baseType: !33, size: 32, align: 32)
!1783 = !DIDerivedType(tag: DW_TAG_member, name: "null_file", scope: !1024, baseType: !1784, size: 32, align: 32, offset: 6624)
!1784 = !DICompositeType(tag: DW_TAG_structure_type, name: "Io.Threaded.NullFile__struct_2144", scope: !8, file: !8, line: 367, size: 32, align: 32, elements: !1785)
!1785 = !{!1786}
!1786 = !DIDerivedType(tag: DW_TAG_member, name: "fd", scope: !1784, baseType: !785, size: 32, align: 32)
!1787 = !DIDerivedType(tag: DW_TAG_member, name: "stderr_mutex", scope: !1024, baseType: !26, size: 32, align: 32, offset: 6656)
!1788 = !DIDerivedType(tag: DW_TAG_member, name: "cpu_count_error", scope: !1024, baseType: !1789, size: 16, align: 16, offset: 6688)
!1789 = !DIDerivedType(tag: DW_TAG_typedef, name: "?error{PermissionDenied,SystemResources,Unexpected,Unsupported}", scope: !4, baseType: !1790, size: 16, align: 16)
!1790 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{PermissionDenied,SystemResources,Unexpected,Unsupported}", scope: !4, baseType: !845, size: 16, align: 16)
!1791 = !DIDerivedType(tag: DW_TAG_member, name: "use_fcopyfile", scope: !1024, baseType: !23, size: 8, align: 8, offset: 6704)
!1792 = !DIDerivedType(tag: DW_TAG_member, name: "disable_memory_mapping", scope: !1024, baseType: !790, size: 8, align: 8, offset: 6712)
!1793 = !DIDerivedType(tag: DW_TAG_member, name: "stderr_mode", scope: !1024, baseType: !15, size: 8, align: 8, offset: 6720)
!1794 = !DIDerivedType(tag: DW_TAG_member, name: "stderr_writer_initialized", scope: !1024, baseType: !790, size: 8, align: 8, offset: 6728)
!1795 = !DIDerivedType(tag: DW_TAG_member, name: "use_sendfile", scope: !1024, baseType: !7, size: 8, align: 8, offset: 6736)
!1796 = !DIDerivedType(tag: DW_TAG_member, name: "environ_initialized", scope: !1024, baseType: !790, size: 8, align: 8, offset: 6744)
!1797 = !DIDerivedType(tag: DW_TAG_member, name: "have_signal_handler", scope: !1024, baseType: !790, size: 8, align: 8, offset: 6752)
!1798 = !DIDerivedType(tag: DW_TAG_member, name: "join_requested", scope: !1024, baseType: !790, size: 8, align: 8, offset: 6760)
!1799 = !DIGlobalVariableExpression(var: !1800, expr: !DIExpression())
!1800 = distinct !DIGlobalVariable(name: "debug_threaded_io", linkageName: "std.Options.debug_threaded_io", scope: !1801, file: !1801, line: 195, type: !1802, isLocal: true, isDefinition: true)
!1801 = !DIFile(filename: "std.zig", directory: "/Users/sulky/.zvm/master/lib/std")
!1802 = !DIDerivedType(tag: DW_TAG_typedef, name: "?*Io.Threaded", scope: !4, baseType: !1023, size: 64, align: 64)
!1803 = !DIGlobalVariableExpression(var: !1804, expr: !DIExpression())
!1804 = distinct !DIGlobalVariable(name: "native_os", linkageName: "process.Args.native_os", scope: !1805, file: !1805, line: 4, type: !91, isLocal: true, isDefinition: true)
!1805 = !DIFile(filename: "Args.zig", directory: "/Users/sulky/.zvm/master/lib/std/process")
!1806 = !DIGlobalVariableExpression(var: !1807, expr: !DIExpression())
!1807 = distinct !DIGlobalVariable(name: "mode", linkageName: "builtin.mode", scope: !953, file: !953, line: 108, type: !644, isLocal: true, isDefinition: true)
!1808 = !DIGlobalVariableExpression(var: !1809, expr: !DIExpression())
!1809 = distinct !DIGlobalVariable(name: "runtime_safety", linkageName: "debug.runtime_safety", scope: !1810, file: !1810, line: 238, type: !790, isLocal: true, isDefinition: true)
!1810 = !DIFile(filename: "debug.zig", directory: "/Users/sulky/.zvm/master/lib/std")
!1811 = !DIGlobalVariableExpression(var: !1812, expr: !DIExpression())
!1812 = distinct !DIGlobalVariable(name: "default_enable_segfault_handler", linkageName: "debug.default_enable_segfault_handler", scope: !1810, file: !1810, line: 1382, type: !790, isLocal: true, isDefinition: true)
!1813 = !DIGlobalVariableExpression(var: !1814, expr: !DIExpression())
!1814 = distinct !DIGlobalVariable(name: "default_level", linkageName: "log.default_level", scope: !638, file: !638, line: 54, type: !637, isLocal: true, isDefinition: true)
!1815 = !DIGlobalVariableExpression(var: !1816, expr: !DIExpression())
!1816 = distinct !DIGlobalVariable(name: "strip_debug_info", linkageName: "builtin.strip_debug_info", scope: !953, file: !953, line: 117, type: !790, isLocal: true, isDefinition: true)
!1817 = !DIGlobalVariableExpression(var: !1818, expr: !DIExpression())
!1818 = distinct !DIGlobalVariable(name: "options", linkageName: "std.options", scope: !1801, file: !1801, line: 112, type: !1819, isLocal: true, isDefinition: true)
!1819 = !DICompositeType(tag: DW_TAG_structure_type, name: "std.Options", scope: !1801, file: !1801, line: 215, size: 640, align: 64, elements: !1820)
!1820 = !{!1821, !1822, !1831, !1836, !1837, !1838, !1839, !1840, !1841, !1842, !1843, !1844}
!1821 = !DIDerivedType(tag: DW_TAG_member, name: "signal_stack_size", scope: !1819, baseType: !224, size: 128, align: 64)
!1822 = !DIDerivedType(tag: DW_TAG_member, name: "log_scope_levels", scope: !1819, baseType: !1823, size: 128, align: 64, offset: 128)
!1823 = !DICompositeType(tag: DW_TAG_structure_type, name: "[]const log.ScopeLevel", scope: !4, size: 128, align: 64, elements: !1824)
!1824 = !{!1825, !1830}
!1825 = !DIDerivedType(tag: DW_TAG_member, name: "ptr", scope: !1823, baseType: !1826, size: 64, align: 64)
!1826 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "[*]const log.ScopeLevel", scope: !4, baseType: !1827, size: 64, align: 64)
!1827 = !DICompositeType(tag: DW_TAG_structure_type, name: "log.ScopeLevel", scope: !638, file: !638, line: 59, size: 8, align: 8, elements: !1828)
!1828 = !{!1829}
!1829 = !DIDerivedType(tag: DW_TAG_member, name: "level", scope: !1827, baseType: !637, size: 8, align: 8)
!1830 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !1823, baseType: !73, size: 64, align: 64, offset: 64)
!1831 = !DIDerivedType(tag: DW_TAG_member, name: "page_size_min", scope: !1819, baseType: !1832, size: 128, align: 64, offset: 256)
!1832 = !DICompositeType(tag: DW_TAG_structure_type, name: "?usize", scope: !4, size: 128, align: 64, elements: !1833)
!1833 = !{!1834, !1835}
!1834 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1832, baseType: !73, size: 64, align: 64)
!1835 = !DIDerivedType(tag: DW_TAG_member, name: "some", scope: !1832, baseType: !116, size: 8, align: 8, offset: 64)
!1836 = !DIDerivedType(tag: DW_TAG_member, name: "page_size_max", scope: !1819, baseType: !1832, size: 128, align: 64, offset: 384)
!1837 = !DIDerivedType(tag: DW_TAG_member, name: "fmt_max_depth", scope: !1819, baseType: !73, size: 64, align: 64, offset: 512)
!1838 = !DIDerivedType(tag: DW_TAG_member, name: "enable_segfault_handler", scope: !1819, baseType: !790, size: 8, align: 8, offset: 576)
!1839 = !DIDerivedType(tag: DW_TAG_member, name: "log_level", scope: !1819, baseType: !637, size: 8, align: 8, offset: 584)
!1840 = !DIDerivedType(tag: DW_TAG_member, name: "http_disable_tls", scope: !1819, baseType: !790, size: 8, align: 8, offset: 592)
!1841 = !DIDerivedType(tag: DW_TAG_member, name: "http_enable_ssl_key_log_file", scope: !1819, baseType: !790, size: 8, align: 8, offset: 600)
!1842 = !DIDerivedType(tag: DW_TAG_member, name: "side_channels_mitigations", scope: !1819, baseType: !630, size: 8, align: 8, offset: 608)
!1843 = !DIDerivedType(tag: DW_TAG_member, name: "allow_stack_tracing", scope: !1819, baseType: !790, size: 8, align: 8, offset: 616)
!1844 = !DIDerivedType(tag: DW_TAG_member, name: "networking", scope: !1819, baseType: !790, size: 8, align: 8, offset: 624)
!1845 = !DIGlobalVariableExpression(var: !1846, expr: !DIExpression())
!1846 = distinct !DIGlobalVariable(name: "enable_segfault_handler", linkageName: "debug.enable_segfault_handler", scope: !1810, file: !1810, line: 1381, type: !790, isLocal: true, isDefinition: true)
!1847 = !DIGlobalVariableExpression(var: !1848, expr: !DIExpression())
!1848 = distinct !DIGlobalVariable(name: "unexpected_error_tracing", linkageName: "posix.unexpected_error_tracing", scope: !996, file: !996, line: 1670, type: !790, isLocal: true, isDefinition: true)
!1849 = !DIGlobalVariableExpression(var: !1850, expr: !DIExpression())
!1850 = distinct !DIGlobalVariable(name: "dummy_execute_header", linkageName: "c.dummy_execute_header", scope: !39, file: !39, line: 43, type: !1851, isLocal: true, isDefinition: true)
!1851 = !DICompositeType(tag: DW_TAG_structure_type, name: "macho.mach_header_64", scope: !1852, file: !1852, line: 36, size: 256, align: 32, elements: !1853)
!1852 = !DIFile(filename: "macho.zig", directory: "/Users/sulky/.zvm/master/lib/std")
!1853 = !{!1854, !1855, !1857, !1858, !1859, !1860, !1861, !1862}
!1854 = !DIDerivedType(tag: DW_TAG_member, name: "magic", scope: !1851, baseType: !33, size: 32, align: 32)
!1855 = !DIDerivedType(tag: DW_TAG_member, name: "cputype", scope: !1851, baseType: !1856, size: 32, align: 32, offset: 32)
!1856 = !DIBasicType(name: "c_int", size: 32, encoding: DW_ATE_signed)
!1857 = !DIDerivedType(tag: DW_TAG_member, name: "cpusubtype", scope: !1851, baseType: !1856, size: 32, align: 32, offset: 64)
!1858 = !DIDerivedType(tag: DW_TAG_member, name: "filetype", scope: !1851, baseType: !33, size: 32, align: 32, offset: 96)
!1859 = !DIDerivedType(tag: DW_TAG_member, name: "ncmds", scope: !1851, baseType: !33, size: 32, align: 32, offset: 128)
!1860 = !DIDerivedType(tag: DW_TAG_member, name: "sizeofcmds", scope: !1851, baseType: !33, size: 32, align: 32, offset: 160)
!1861 = !DIDerivedType(tag: DW_TAG_member, name: "flags", scope: !1851, baseType: !33, size: 32, align: 32, offset: 192)
!1862 = !DIDerivedType(tag: DW_TAG_member, name: "reserved", scope: !1851, baseType: !33, size: 32, align: 32, offset: 224)
!1863 = !DIGlobalVariableExpression(var: !1864, expr: !DIExpression())
!1864 = distinct !DIGlobalVariable(name: "init", linkageName: "Io.Mutex.init", scope: !25, file: !25, line: 1590, type: !26, isLocal: true, isDefinition: true)
!1865 = !DIGlobalVariableExpression(var: !1866, expr: !DIExpression())
!1866 = distinct !DIGlobalVariable(name: "init", linkageName: "Io.Condition.init", scope: !25, file: !25, line: 1663, type: !1770, isLocal: true, isDefinition: true)
!1867 = !DIGlobalVariableExpression(var: !1868, expr: !DIExpression())
!1868 = distinct !DIGlobalVariable(name: "init", linkageName: "Io.Threaded.WaitGroup.init", scope: !8, file: !8, line: 18600, type: !1669, isLocal: true, isDefinition: true)
!1869 = !DIGlobalVariableExpression(var: !1870, expr: !DIExpression())
!1870 = distinct !DIGlobalVariable(name: "default", linkageName: "Io.Threaded.UseSendfile__enum_2114.default", scope: !8, file: !8, line: 406, type: !7, isLocal: true, isDefinition: true)
!1871 = !DIGlobalVariableExpression(var: !1872, expr: !DIExpression())
!1872 = distinct !DIGlobalVariable(name: "default", linkageName: "Io.Threaded.UseFcopyfile__enum_2121.default", scope: !8, file: !8, line: 424, type: !23, isLocal: true, isDefinition: true)
!1873 = !DIGlobalVariableExpression(var: !1874, expr: !DIExpression())
!1874 = distinct !DIGlobalVariable(name: "native_os", linkageName: "Io.File.native_os", scope: !782, file: !782, line: 4, type: !91, isLocal: true, isDefinition: true)
!1875 = !DIGlobalVariableExpression(var: !1876, expr: !DIExpression())
!1876 = distinct !DIGlobalVariable(name: "invalid_id", linkageName: "Io.Threaded.Thread.invalid_id", scope: !8, file: !8, line: 896, type: !227, isLocal: true, isDefinition: true)
!1877 = !DIGlobalVariableExpression(var: !1878, expr: !DIExpression())
!1878 = distinct !DIGlobalVariable(name: "uninitialized", linkageName: "Io.Threaded.Csprng.uninitialized", scope: !8, file: !8, line: 157, type: !1656, isLocal: true, isDefinition: true)
!1879 = !DIGlobalVariableExpression(var: !1880, expr: !DIExpression())
!1880 = distinct !DIGlobalVariable(name: "is_windows", linkageName: "Io.File.is_windows", scope: !782, file: !782, line: 5, type: !790, isLocal: true, isDefinition: true)
!1881 = !DIGlobalVariableExpression(var: !1882, expr: !DIExpression())
!1882 = distinct !DIGlobalVariable(name: "native_os", linkageName: "Io.net.native_os", scope: !826, file: !826, line: 2, type: !91, isLocal: true, isDefinition: true)
!1883 = !DIGlobalVariableExpression(var: !1884, expr: !DIExpression())
!1884 = distinct !DIGlobalVariable(name: "failing", linkageName: "mem.Allocator.failing", scope: !1744, file: !1744, line: 479, type: !1743, isLocal: true, isDefinition: true)
!1885 = !DIGlobalVariableExpression(var: !1886, expr: !DIExpression())
!1886 = distinct !DIGlobalVariable(name: "empty", linkageName: "process.Environ.PosixBlock.empty", scope: !991, file: !991, line: 51, type: !1693, isLocal: true, isDefinition: true)
!1887 = !DIGlobalVariableExpression(var: !1888, expr: !DIExpression())
!1888 = distinct !DIGlobalVariable(name: "empty", linkageName: "process.Environ.empty", scope: !991, file: !991, line: 17, type: !1690, isLocal: true, isDefinition: true)
!1889 = !DIGlobalVariableExpression(var: !1890, expr: !DIExpression())
!1890 = distinct !DIGlobalVariable(name: "empty", linkageName: "Io.Threaded.Environ.empty", scope: !8, file: !8, line: 205, type: !1687, isLocal: true, isDefinition: true)
!1891 = !DIGlobalVariableExpression(var: !1892, expr: !DIExpression())
!1892 = distinct !DIGlobalVariable(name: "init_single_threaded", linkageName: "Io.Threaded.init_single_threaded", scope: !8, file: !8, line: 1674, type: !1024, isLocal: true, isDefinition: true)
!1893 = !DIGlobalVariableExpression(var: !1894, expr: !DIExpression())
!1894 = distinct !DIGlobalVariable(name: "global_single_threaded_instance", linkageName: "Io.Threaded.global_single_threaded_instance", scope: !8, file: !8, line: 1690, type: !1024, isLocal: true, isDefinition: true)
!1895 = !DIGlobalVariableExpression(var: !1896, expr: !DIExpression())
!1896 = distinct !DIGlobalVariable(name: "none", linkageName: "Target.DynamicLinker.none", scope: !92, file: !92, line: 2299, type: !980, isLocal: true, isDefinition: true)
!1897 = !DIGlobalVariableExpression(var: !1898, expr: !DIExpression())
!1898 = distinct !DIGlobalVariable(name: "apple_m1", linkageName: "Target.aarch64.cpu.apple_m1", scope: !1899, file: !1899, line: 2250, type: !546, isLocal: true, isDefinition: true)
!1899 = !DIFile(filename: "aarch64.zig", directory: "/Users/sulky/.zvm/master/lib/std/Target")
!1900 = !{!1901}
!1901 = !DISubrange(count: 262144, lowerBound: 0)
!1902 = !{i32 8, !"PIC Level", i32 2}
!1903 = !{i32 2, !"Debug Info Version", i32 3}
!1904 = !{i32 7, !"Dwarf Version", i32 4}
!1905 = distinct !DISubprogram(name: "main", linkageName: "start.main", scope: !962, file: !962, line: 640, type: !1906, scopeLine: 640, flags: DIFlagStaticMember, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!1906 = !DISubroutineType(types: !1907)
!1907 = !{!1856, !1856, !1908, !1911}
!1908 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "[*][*:0]c_char", scope: !4, baseType: !1909, size: 64, align: 64)
!1909 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "[*:0]c_char", scope: !4, baseType: !1910, size: 64, align: 64)
!1910 = !DIBasicType(name: "c_char", size: 8, encoding: DW_ATE_signed)
!1911 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "[*:null]?[*:0]c_char", scope: !4, baseType: !1912, size: 64, align: 64)
!1912 = !DIDerivedType(tag: DW_TAG_typedef, name: "?[*:0]c_char", scope: !4, baseType: !1909, size: 64, align: 64)
!1913 = !DILocalVariable(name: "c_argc", arg: 1, scope: !1905, file: !962, line: 640, type: !1856)
!1914 = !DILocation(line: 640, column: 97, scope: !1905)
!1915 = !DILocalVariable(name: "c_argv", arg: 2, scope: !1905, file: !962, line: 640, type: !1908)
!1916 = !DILocalVariable(name: "c_envp", arg: 3, scope: !1905, file: !962, line: 640, type: !1911)
!1917 = !DILocalVariable(name: "env_count", scope: !1905, file: !962, line: 641, type: !73)
!1918 = !DILocation(line: 0, scope: !1905)
!1919 = !DILocation(line: 641, column: 5, scope: !1920)
!1920 = !DILexicalBlock(scope: !1905, file: !962, line: 641, column: 5)
!1921 = !DILocation(line: 642, column: 18, scope: !1922)
!1922 = !DILexicalBlock(scope: !1923, file: !962, line: 641, column: 5)
!1923 = !DILexicalBlock(scope: !1920, file: !962, line: 641, column: 5)
!1924 = !DILocation(line: 642, column: 52, scope: !1925)
!1925 = !DILexicalBlockFile(scope: !1926, file: !962, discriminator: 4)
!1926 = !DILexicalBlock(scope: !1922, file: !962, line: 642, column: 18)
!1927 = !DILocalVariable(name: "envp", scope: !1905, file: !962, line: 643, type: !1928)
!1928 = !DICompositeType(tag: DW_TAG_structure_type, name: "[:null]?[*:0]c_char", scope: !4, size: 128, align: 64, elements: !1929)
!1929 = !{!1930, !1931}
!1930 = !DIDerivedType(tag: DW_TAG_member, name: "ptr", scope: !1928, baseType: !1911, size: 64, align: 64)
!1931 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !1928, baseType: !73, size: 64, align: 64, offset: 64)
!1932 = !DILocation(line: 643, column: 24, scope: !1905)
!1933 = !DILocalVariable(name: "argc", arg: 1, scope: !1934, file: !962, line: 662, type: !73)
!1934 = !DILexicalBlock(scope: !1935, file: !962, line: 662, column: 28)
!1935 = distinct !DISubprogram(name: "callMainWithArgs", linkageName: "start.callMainWithArgs", scope: !962, file: !962, line: 629, type: !1101, scopeLine: 629, flags: DIFlagStaticMember, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!1936 = !DILocation(line: 662, column: 28, scope: !1934, inlinedAt: !1937)
!1937 = !DILocation(line: 662, column: 28, scope: !1905)
!1938 = !DILocalVariable(name: "argv", arg: 2, scope: !1934, file: !962, line: 662, type: !1939)
!1939 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "[*][*:0]u8", scope: !4, baseType: !1940, size: 64, align: 64)
!1940 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "[*:0]u8", scope: !4, baseType: !116, size: 64, align: 64)
!1941 = !DILocalVariable(name: "envp", arg: 3, scope: !1934, file: !962, line: 662, type: !1942)
!1942 = !DICompositeType(tag: DW_TAG_structure_type, name: "[:null]?[*:0]u8", scope: !4, size: 128, align: 64, elements: !1943)
!1943 = !{!1944, !1947}
!1944 = !DIDerivedType(tag: DW_TAG_member, name: "ptr", scope: !1942, baseType: !1945, size: 64, align: 64)
!1945 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "[*:null]?[*:0]u8", scope: !4, baseType: !1946, size: 64, align: 64)
!1946 = !DIDerivedType(tag: DW_TAG_typedef, name: "?[*:0]u8", scope: !4, baseType: !1940, size: 64, align: 64)
!1947 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !1942, baseType: !73, size: 64, align: 64, offset: 64)
!1948 = !DILocalVariable(name: "env_block", scope: !1934, file: !962, line: 630, type: !1693)
!1949 = !DILocation(line: 0, scope: !1934, inlinedAt: !1937)
!1950 = !DILocalVariable(name: "t", scope: !1951, file: !962, line: 631, type: !1023)
!1951 = !DILexicalBlock(scope: !1934, file: !962, line: 631, column: 9)
!1952 = !DILocation(line: 631, column: 20, scope: !1951, inlinedAt: !1937)
!1953 = !DILocation(line: 633, column: 10, scope: !1951, inlinedAt: !1937)
!1954 = !DILocation(line: 1737, column: 22, scope: !1955, inlinedAt: !1958)
!1955 = distinct !DISubprogram(name: "maybeAttachSignalStack", linkageName: "Thread.maybeAttachSignalStack", scope: !2, file: !2, line: 1724, type: !1956, scopeLine: 1724, flags: DIFlagStaticMember, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!1956 = !DISubroutineType(types: !1957)
!1957 = !{!99}
!1958 = distinct !DILocation(line: 635, column: 38, scope: !1934, inlinedAt: !1937)
!1959 = !DILocalVariable(name: "size", scope: !1955, file: !2, line: 1725, type: !227)
!1960 = !DILocation(line: 1725, column: 29, scope: !1955, inlinedAt: !1958)
!1961 = !DILocalVariable(name: "ss", arg: 1, scope: !1962, file: !996, line: 875, type: !1970)
!1962 = distinct !DISubprogram(name: "sigaltstack", linkageName: "posix.sigaltstack", scope: !996, file: !996, line: 875, type: !1963, scopeLine: 875, flags: DIFlagStaticMember, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!1963 = !DISubroutineType(types: !1964)
!1964 = !{!1965, !1970, !1978}
!1965 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{PermissionDenied,SizeTooSmall,Unexpected}!void", scope: !4, size: 16, align: 16, elements: !1966)
!1966 = !{!1967, !1969}
!1967 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !1965, baseType: !1968, size: 16, align: 16)
!1968 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{PermissionDenied,SizeTooSmall,Unexpected}", scope: !4, baseType: !845, size: 16, align: 16)
!1969 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !1965, baseType: !99, align: 8, offset: 16)
!1970 = !DIDerivedType(tag: DW_TAG_typedef, name: "?*const c.stack_t__struct_2430", scope: !4, baseType: !1971, size: 64, align: 64)
!1971 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const c.stack_t__struct_2430", scope: !4, baseType: !1972, size: 64, align: 64)
!1972 = !DICompositeType(tag: DW_TAG_structure_type, name: "c.stack_t__struct_2430", scope: !39, file: !39, line: 6993, size: 192, align: 64, elements: !1973)
!1973 = !{!1974, !1975, !1977}
!1974 = !DIDerivedType(tag: DW_TAG_member, name: "sp", scope: !1972, baseType: !777, size: 64, align: 64)
!1975 = !DIDerivedType(tag: DW_TAG_member, name: "size", scope: !1972, baseType: !1976, size: 64, align: 64, offset: 64)
!1976 = !DIBasicType(name: "isize", size: 64, encoding: DW_ATE_signed)
!1977 = !DIDerivedType(tag: DW_TAG_member, name: "flags", scope: !1972, baseType: !785, size: 32, align: 32, offset: 128)
!1978 = !DIDerivedType(tag: DW_TAG_typedef, name: "?*c.stack_t__struct_2430", scope: !4, baseType: !1979, size: 64, align: 64)
!1979 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*c.stack_t__struct_2430", scope: !4, baseType: !1972, size: 64, align: 64)
!1980 = !DILocation(line: 875, column: 82, scope: !1962, inlinedAt: !1981)
!1981 = distinct !DILocation(line: 1736, column: 26, scope: !1955, inlinedAt: !1958)
!1982 = !DILocalVariable(name: "old_ss", arg: 2, scope: !1962, file: !996, line: 875, type: !1978)
!1983 = !DILocation(line: 876, column: 37, scope: !1962, inlinedAt: !1981)
!1984 = !DILocalVariable(name: "rc", arg: 1, scope: !1985, file: !39, line: 76, type: !1856)
!1985 = distinct !DISubprogram(name: "errno__anon_2649", linkageName: "c.errno__anon_2649", scope: !39, file: !39, line: 76, type: !1986, scopeLine: 76, flags: DIFlagStaticMember, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!1986 = !DISubroutineType(types: !1987)
!1987 = !{!650, !1856}
!1988 = !DILocation(line: 76, column: 29, scope: !1985, inlinedAt: !1989)
!1989 = distinct !DILocation(line: 876, column: 18, scope: !1990, inlinedAt: !1981)
!1990 = !DILexicalBlockFile(scope: !1962, file: !996, discriminator: 2)
!1991 = !DILocation(line: 77, column: 16, scope: !1992, inlinedAt: !1989)
!1992 = !DILexicalBlock(scope: !1985, file: !39, line: 77, column: 16)
!1993 = !DILocation(line: 77, column: 45, scope: !1994, inlinedAt: !1989)
!1994 = !DILexicalBlockFile(scope: !1995, file: !39, discriminator: 4)
!1995 = !DILexicalBlock(scope: !1992, file: !39, line: 77, column: 16)
!1996 = !DILocation(line: 876, column: 13, scope: !1962, inlinedAt: !1981)
!1997 = !DILocation(line: 1743, column: 29, scope: !1998, inlinedAt: !1958)
!1998 = !DILexicalBlock(scope: !1999, file: !2, line: 1742, column: 35)
!1999 = !DILexicalBlock(scope: !2000, file: !2, line: 1736, column: 5)
!2000 = !DILexicalBlock(scope: !1955, file: !2, line: 1736, column: 5)
!2001 = !DILocation(line: 662, column: 5, scope: !2002)
!2002 = !DILexicalBlockFile(scope: !1905, file: !962, discriminator: 2)
!2003 = distinct !DISubprogram(name: "drain", linkageName: "Io.File.Writer.drain", scope: !1028, file: !1028, line: 89, type: !1605, scopeLine: 89, flags: DIFlagStaticMember, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!2004 = !DILocalVariable(name: "io_w", arg: 1, scope: !2003, file: !1028, line: 89, type: !1613)
!2005 = !DILocation(line: 89, column: 94, scope: !2003)
!2006 = !DILocalVariable(name: "data", arg: 2, scope: !2003, file: !1028, line: 89, type: !796)
!2007 = !DILocalVariable(name: "splat", arg: 3, scope: !2003, file: !1028, line: 89, type: !73)
!2008 = !DILocation(line: 90, column: 24, scope: !2003)
!2009 = !DILocalVariable(name: "w", scope: !2003, file: !1028, line: 90, type: !2010)
!2010 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*Io.File.Writer", scope: !4, baseType: !1027, size: 64, align: 64)
!2011 = !DILocation(line: 91, column: 14, scope: !2003)
!2012 = !DILocation(line: 91, column: 13, scope: !2003)
!2013 = !DILocation(line: 0, scope: !2003)
!2014 = !DILocation(line: 94, column: 21, scope: !2015)
!2015 = !DILexicalBlock(scope: !2003, file: !1028, line: 91, column: 13)
!2016 = !{!2017}
!2017 = distinct !{!2017, !2018, !"Io.File.Writer.drainPositional: argument 0"}
!2018 = distinct !{!2018, !"Io.File.Writer.drainPositional"}
!2019 = !DILocation(line: 92, column: 66, scope: !2020)
!2020 = !DILexicalBlock(scope: !2003, file: !1028, line: 94, column: 21)
!2021 = !DILocation(line: 99, column: 17, scope: !2022, inlinedAt: !2025)
!2022 = distinct !DISubprogram(name: "drainPositional", linkageName: "Io.File.Writer.drainPositional", scope: !1028, file: !1028, line: 98, type: !2023, scopeLine: 98, flags: DIFlagStaticMember, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!2023 = !DISubroutineType(types: !2024)
!2024 = !{!99, !1607, !2010, !796, !73}
!2025 = distinct !DILocation(line: 92, column: 66, scope: !2020)
!2026 = !DILocalVariable(name: "w", arg: 1, scope: !2022, file: !1028, line: 98, type: !2010)
!2027 = !DILocation(line: 98, column: 94, scope: !2022, inlinedAt: !2025)
!2028 = !DILocalVariable(name: "data", arg: 2, scope: !2022, file: !1028, line: 98, type: !796)
!2029 = !DILocalVariable(name: "splat", arg: 3, scope: !2022, file: !1028, line: 98, type: !73)
!2030 = !DILocalVariable(name: "io", scope: !2022, file: !1028, line: 99, type: !1031)
!2031 = !DILocation(line: 0, scope: !2022, inlinedAt: !2025)
!2032 = !DILocation(line: 100, column: 40, scope: !2022, inlinedAt: !2025)
!2033 = !DILocalVariable(name: "header", scope: !2022, file: !1028, line: 100, type: !774)
!2034 = !DILocation(line: 101, column: 44, scope: !2022, inlinedAt: !2025)
!2035 = !DILocation(line: 101, column: 59, scope: !2022, inlinedAt: !2025)
!2036 = !DILocation(line: 101, column: 88, scope: !2022, inlinedAt: !2025)
!2037 = !DILocation(line: 101, column: 15, scope: !2022, inlinedAt: !2025)
!2038 = !DILocation(line: 101, column: 15, scope: !2039, inlinedAt: !2025)
!2039 = !DILexicalBlock(scope: !2022, file: !1028, line: 101, column: 15)
!2040 = !{!"branch_weights", i32 1, i32 4000, i32 1}
!2041 = !DILocation(line: 101, column: 15, scope: !2042, inlinedAt: !2025)
!2042 = !DILexicalBlockFile(scope: !2043, file: !1028, discriminator: 2)
!2043 = !DILexicalBlock(scope: !2039, file: !1028, line: 101, column: 15)
!2044 = !DILocalVariable(name: "n", scope: !2022, file: !1028, line: 116, type: !73)
!2045 = !DILocation(line: 116, column: 13, scope: !2046, inlinedAt: !2025)
!2046 = !DILexicalBlock(scope: !2043, file: !1028, line: 112, column: 13)
!2047 = !DILocation(line: 119, column: 6, scope: !2022, inlinedAt: !2025)
!2048 = !DILocation(line: 119, column: 11, scope: !2022, inlinedAt: !2025)
!2049 = !DILocalVariable(name: "w", arg: 1, scope: !2050, file: !1597, line: 2265, type: !1613)
!2050 = distinct !DISubprogram(name: "consume", linkageName: "Io.Writer.consume", scope: !1597, file: !1597, line: 2265, type: !2051, scopeLine: 2265, flags: DIFlagStaticMember, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!2051 = !DISubroutineType(types: !2052)
!2052 = !{!73, !1613, !73}
!2053 = !DILocation(line: 2265, column: 44, scope: !2050, inlinedAt: !2054)
!2054 = distinct !DILocation(line: 120, column: 31, scope: !2022, inlinedAt: !2025)
!2055 = !DILocalVariable(name: "n", arg: 2, scope: !2050, file: !1597, line: 2265, type: !73)
!2056 = !DILocation(line: 2266, column: 14, scope: !2057, inlinedAt: !2054)
!2057 = !DILexicalBlock(scope: !2050, file: !1597, line: 2266, column: 9)
!2058 = !DILocation(line: 2267, column: 35, scope: !2059, inlinedAt: !2054)
!2059 = !DILexicalBlock(scope: !2057, file: !1597, line: 2266, column: 14)
!2060 = !DILocalVariable(name: "remaining", scope: !2059, file: !1597, line: 2267, type: !774)
!2061 = !DILocation(line: 2268, column: 26, scope: !2059, inlinedAt: !2054)
!2062 = !DILocation(line: 2270, column: 9, scope: !2059, inlinedAt: !2054)
!2063 = !DILocation(line: 2273, column: 14, scope: !2050, inlinedAt: !2054)
!2064 = !DILocation(line: 2273, column: 5, scope: !2050, inlinedAt: !2054)
!2065 = !DILocation(line: 0, scope: !2050, inlinedAt: !2054)
!2066 = !DILocation(line: 120, column: 5, scope: !2022, inlinedAt: !2025)
!2067 = !DILocation(line: 103, column: 40, scope: !2068, inlinedAt: !2025)
!2068 = !DILexicalBlock(scope: !2043, file: !1028, line: 101, column: 15)
!2069 = !DILocalVariable(name: "m", arg: 1, scope: !2070, file: !83, line: 54, type: !82)
!2070 = distinct !DISubprogram(name: "toStreaming", linkageName: "Io.File.Reader.Mode.toStreaming", scope: !83, file: !83, line: 54, type: !2071, scopeLine: 54, flags: DIFlagStaticMember, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!2071 = !DISubroutineType(types: !2072)
!2072 = !{!82, !82}
!2073 = !DILocation(line: 54, column: 44, scope: !2070, inlinedAt: !2074)
!2074 = distinct !DILocation(line: 103, column: 40, scope: !2068, inlinedAt: !2025)
!2075 = !DILocation(line: 55, column: 24, scope: !2076, inlinedAt: !2074)
!2076 = !DILexicalBlock(scope: !2070, file: !83, line: 55, column: 24)
!2077 = !DILocation(line: 104, column: 26, scope: !2068, inlinedAt: !2025)
!2078 = !DILocalVariable(name: "pos", scope: !2068, file: !1028, line: 104, type: !227)
!2079 = !DILocation(line: 105, column: 17, scope: !2080, inlinedAt: !2025)
!2080 = !DILexicalBlock(scope: !2068, file: !1028, line: 105, column: 17)
!2081 = !DILocalVariable(name: "e", scope: !2046, file: !1028, line: 112, type: !1641)
!2082 = !DILocation(line: 112, column: 13, scope: !2046, inlinedAt: !2025)
!2083 = !DILocation(line: 115, column: 14, scope: !2046, inlinedAt: !2025)
!2084 = !DILocation(line: 116, column: 13, scope: !2085, inlinedAt: !2025)
!2085 = !DILexicalBlockFile(scope: !2046, file: !1028, discriminator: 2)
!2086 = !DILocation(line: 112, column: 13, scope: !2068, inlinedAt: !2025)
!2087 = !DILocation(line: 106, column: 18, scope: !2088, inlinedAt: !2025)
!2088 = !DILexicalBlock(scope: !2080, file: !1028, line: 105, column: 17)
!2089 = !DILocation(line: 107, column: 25, scope: !2090, inlinedAt: !2025)
!2090 = !DILexicalBlock(scope: !2088, file: !1028, line: 107, column: 17)
!2091 = !DILocation(line: 108, column: 22, scope: !2092, inlinedAt: !2025)
!2092 = !DILexicalBlock(scope: !2090, file: !1028, line: 107, column: 25)
!2093 = !DILocation(line: 109, column: 21, scope: !2094, inlinedAt: !2025)
!2094 = !DILexicalBlockFile(scope: !2092, file: !1028, discriminator: 4)
!2095 = !DILocation(line: 92, column: 44, scope: !2020)
!2096 = !DILocalVariable(name: "w", arg: 1, scope: !2097, file: !1028, line: 123, type: !2010)
!2097 = distinct !DISubprogram(name: "drainStreaming", linkageName: "Io.File.Writer.drainStreaming", scope: !1028, file: !1028, line: 123, type: !2023, scopeLine: 123, flags: DIFlagStaticMember, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!2098 = !DILocation(line: 123, column: 93, scope: !2097, inlinedAt: !2099)
!2099 = distinct !DILocation(line: 93, column: 63, scope: !2100)
!2100 = !DILexicalBlock(scope: !2003, file: !1028, line: 92, column: 44)
!2101 = !DILocalVariable(name: "data", arg: 2, scope: !2097, file: !1028, line: 123, type: !796)
!2102 = !DILocalVariable(name: "splat", arg: 3, scope: !2097, file: !1028, line: 123, type: !73)
!2103 = !DILocation(line: 124, column: 17, scope: !2097, inlinedAt: !2099)
!2104 = !{!2105}
!2105 = distinct !{!2105, !2106, !"Io.File.Writer.drainStreaming: argument 0"}
!2106 = distinct !{!2106, !"Io.File.Writer.drainStreaming"}
!2107 = !DILocalVariable(name: "io", scope: !2097, file: !1028, line: 124, type: !1031)
!2108 = !DILocation(line: 0, scope: !2097, inlinedAt: !2099)
!2109 = !DILocalVariable(name: "io", arg: 2, scope: !2110, file: !782, line: 613, type: !1031)
!2110 = distinct !DISubprogram(name: "writeStreaming", linkageName: "Io.File.writeStreaming", scope: !782, file: !782, line: 613, type: !2111, scopeLine: 613, flags: DIFlagStaticMember, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!2111 = !DISubroutineType(types: !2112)
!2112 = !{!99, !2113, !1250, !2118, !112, !796, !73}
!2113 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*error{AccessDenied,BrokenPipe,Canceled,DeviceBusy,DiskQuota,FileBusy,FileTooBig,InputOutput,LockViolation,NoDevice,NoSpaceLeft,NotOpenForWriting,PermissionDenied,SystemResources,Unexpected,WouldBlock}!usize", scope: !4, baseType: !2114, size: 64, align: 64)
!2114 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{AccessDenied,BrokenPipe,Canceled,DeviceBusy,DiskQuota,FileBusy,FileTooBig,InputOutput,LockViolation,NoDevice,NoSpaceLeft,NotOpenForWriting,PermissionDenied,SystemResources,Unexpected,WouldBlock}!usize", scope: !4, size: 128, align: 64, elements: !2115)
!2115 = !{!2116, !2117}
!2116 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !2114, baseType: !1641, size: 16, align: 16, offset: 64)
!2117 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !2114, baseType: !73, size: 64, align: 64)
!2118 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const Io", scope: !4, baseType: !1031, size: 64, align: 64)
!2119 = !DILocation(line: 0, scope: !2110, inlinedAt: !2120)
!2120 = distinct !DILocation(line: 126, column: 36, scope: !2121, inlinedAt: !2099)
!2121 = !DILexicalBlock(scope: !2097, file: !1028, line: 126, column: 5)
!2122 = !DILocation(line: 125, column: 40, scope: !2097, inlinedAt: !2099)
!2123 = !DILocalVariable(name: "header", scope: !2097, file: !1028, line: 125, type: !774)
!2124 = !DILocation(line: 126, column: 16, scope: !2121, inlinedAt: !2099)
!2125 = !DILocation(line: 126, column: 36, scope: !2121, inlinedAt: !2099)
!2126 = !DILocation(line: 613, column: 122, scope: !2110, inlinedAt: !2120)
!2127 = !DILocalVariable(name: "file", arg: 1, scope: !2110, file: !782, line: 613, type: !781)
!2128 = !DILocalVariable(name: "header", arg: 3, scope: !2110, file: !782, line: 613, type: !112)
!2129 = !DILocalVariable(name: "data", arg: 4, scope: !2110, file: !782, line: 613, type: !796)
!2130 = !DILocalVariable(name: "splat", arg: 5, scope: !2110, file: !782, line: 613, type: !73)
!2131 = !DILocation(line: 614, column: 27, scope: !2110, inlinedAt: !2120)
!2132 = !{!2133, !2105}
!2133 = distinct !{!2133, !2134, !"Io.File.writeStreaming: argument 0"}
!2134 = distinct !{!2134, !"Io.File.writeStreaming"}
!2135 = !DILocation(line: 453, column: 29, scope: !2136, inlinedAt: !2139)
!2136 = distinct !DISubprogram(name: "operate", linkageName: "Io.operate", scope: !25, file: !25, line: 452, type: !2137, scopeLine: 452, flags: DIFlagStaticMember, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!2137 = !DISubroutineType(types: !2138)
!2138 = !{!99, !1118, !2118, !1149}
!2139 = distinct !DILocation(line: 614, column: 27, scope: !2110, inlinedAt: !2120)
!2140 = !DILocalVariable(name: "io", arg: 1, scope: !2136, file: !25, line: 452, type: !1031)
!2141 = !DILocation(line: 452, column: 74, scope: !2136, inlinedAt: !2139)
!2142 = !DILocalVariable(name: "operation", arg: 2, scope: !2136, file: !25, line: 452, type: !761)
!2143 = !{!2144, !2133, !2105}
!2144 = distinct !{!2144, !2145, !"Io.operate: argument 0"}
!2145 = distinct !{!2145, !"Io.operate"}
!2146 = !DILocation(line: 453, column: 5, scope: !2136, inlinedAt: !2139)
!2147 = !DILocation(line: 614, scope: !2110, inlinedAt: !2120)
!2148 = !{!"branch_weights", i32 2000, i32 1}
!2149 = !DILocalVariable(name: "n", scope: !2097, file: !1028, line: 128, type: !73)
!2150 = !DILocation(line: 128, column: 9, scope: !2151, inlinedAt: !2099)
!2151 = !DILexicalBlock(scope: !2121, file: !1028, line: 126, column: 36)
!2152 = !DILocation(line: 130, column: 6, scope: !2097, inlinedAt: !2099)
!2153 = !DILocation(line: 130, column: 11, scope: !2097, inlinedAt: !2099)
!2154 = !DILocation(line: 2265, column: 44, scope: !2050, inlinedAt: !2155)
!2155 = distinct !DILocation(line: 131, column: 31, scope: !2097, inlinedAt: !2099)
!2156 = !DILocation(line: 2266, column: 14, scope: !2057, inlinedAt: !2155)
!2157 = !DILocation(line: 2267, column: 35, scope: !2059, inlinedAt: !2155)
!2158 = !DILocation(line: 2268, column: 26, scope: !2059, inlinedAt: !2155)
!2159 = !DILocation(line: 2270, column: 9, scope: !2059, inlinedAt: !2155)
!2160 = !DILocation(line: 2273, column: 14, scope: !2050, inlinedAt: !2155)
!2161 = !DILocation(line: 2273, column: 5, scope: !2050, inlinedAt: !2155)
!2162 = !DILocation(line: 0, scope: !2050, inlinedAt: !2155)
!2163 = !DILocation(line: 131, column: 5, scope: !2097, inlinedAt: !2099)
!2164 = !DILocation(line: 127, column: 10, scope: !2151, inlinedAt: !2099)
!2165 = !DILocation(line: 128, column: 9, scope: !2166, inlinedAt: !2099)
!2166 = !DILexicalBlockFile(scope: !2151, file: !1028, discriminator: 2)
!2167 = !DILocation(line: 93, column: 42, scope: !2100)
!2168 = !DILocation(line: 93, column: 42, scope: !2169)
!2169 = !DILexicalBlockFile(scope: !2100, file: !1028, discriminator: 2)
!2170 = distinct !DISubprogram(name: "defaultRebase", linkageName: "Io.Writer.defaultRebase", scope: !1597, file: !1597, line: 344, type: !1634, scopeLine: 344, flags: DIFlagStaticMember, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!2171 = !DILocalVariable(name: "w", arg: 1, scope: !2170, file: !1597, line: 344, type: !1613)
!2172 = !DILocation(line: 344, column: 82, scope: !2170)
!2173 = !DILocalVariable(name: "preserve", arg: 2, scope: !2170, file: !1597, line: 344, type: !73)
!2174 = !DILocalVariable(name: "minimum_len", arg: 3, scope: !2170, file: !1597, line: 344, type: !73)
!2175 = !DILocation(line: 345, column: 20, scope: !2176)
!2176 = !DILexicalBlock(scope: !2177, file: !1597)
!2177 = !DILexicalBlock(scope: !2178, file: !1597)
!2178 = !DILexicalBlock(scope: !2170, file: !1597)
!2179 = !DILocation(line: 345, column: 28, scope: !2176)
!2180 = !DILocation(line: 345, column: 25, scope: !2176)
!2181 = !DILocation(line: 0, scope: !2176)
!2182 = !DILocation(line: 349, column: 37, scope: !2183)
!2183 = !DILexicalBlock(scope: !2184, file: !1597, line: 346, column: 9)
!2184 = !DILexicalBlock(scope: !2176, file: !1597, line: 345, column: 25)
!2185 = !DILocalVariable(name: "preserved_head", scope: !2183, file: !1597, line: 349, type: !73)
!2186 = !DILocalVariable(name: "preserved_tail", scope: !2183, file: !1597, line: 350, type: !73)
!2187 = !DILocation(line: 350, column: 37, scope: !2183)
!2188 = !DILocation(line: 351, column: 50, scope: !2183)
!2189 = !DILocalVariable(name: "preserved_len", scope: !2183, file: !1597, line: 351, type: !73)
!2190 = !DILocation(line: 352, column: 14, scope: !2183)
!2191 = !DILocation(line: 354, column: 43, scope: !2183)
!2192 = !DILocation(line: 353, column: 20, scope: !2193)
!2193 = !DILexicalBlock(scope: !2183, file: !1597, line: 354, column: 43)
!2194 = !DILocation(line: 353, column: 25, scope: !2193)
!2195 = !DILocation(line: 354, column: 25, scope: !2196)
!2196 = !DILexicalBlockFile(scope: !2193, file: !1597, discriminator: 2)
!2197 = !DILocalVariable(name: "ok", arg: 1, scope: !2198, file: !1810, line: 419, type: !790)
!2198 = distinct !DISubprogram(name: "assert", linkageName: "debug.assert", scope: !1810, file: !1810, line: 419, type: !2199, scopeLine: 419, flags: DIFlagStaticMember, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!2199 = !DISubroutineType(types: !2200)
!2200 = !{!99, !790}
!2201 = !DILocation(line: 419, column: 30, scope: !2198, inlinedAt: !2202)
!2202 = distinct !DILocation(line: 354, column: 19, scope: !2203)
!2203 = !DILexicalBlockFile(scope: !2183, file: !1597, discriminator: 4)
!2204 = !DILocation(line: 355, column: 21, scope: !2183)
!2205 = !DILocation(line: 419, column: 30, scope: !2198, inlinedAt: !2206)
!2206 = distinct !DILocation(line: 355, column: 19, scope: !2183)
!2207 = !DILocation(line: 356, column: 39, scope: !2183)
!2208 = !DILocation(line: 356, column: 67, scope: !2183)
!2209 = !DILocation(line: 353, column: 20, scope: !2210)
!2210 = !DILexicalBlockFile(scope: !2183, file: !1597, discriminator: 2)
!2211 = !DILocation(line: 353, column: 25, scope: !2210)
!2212 = !DILocation(line: 362, column: 24, scope: !2184)
!2213 = !DILocation(line: 419, column: 30, scope: !2198, inlinedAt: !2214)
!2214 = distinct !DILocation(line: 362, column: 15, scope: !2184)
!2215 = distinct !DISubprogram(name: "defaultFlush", linkageName: "Io.Writer.defaultFlush", scope: !1597, file: !1597, line: 317, type: !1626, scopeLine: 317, flags: DIFlagStaticMember, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!2216 = !DILocalVariable(name: "w", arg: 1, scope: !2215, file: !1597, line: 317, type: !1613)
!2217 = !DILocation(line: 317, column: 44, scope: !2215)
!2218 = !DILocation(line: 318, column: 29, scope: !2215)
!2219 = !DILocalVariable(name: "drainFn", scope: !2215, file: !1597, line: 318, type: !1604)
!2220 = !DILocation(line: 318, column: 29, scope: !2221)
!2221 = !DILexicalBlock(scope: !2215, file: !1597, line: 318, column: 29)
!2222 = !DILocation(line: 319, scope: !2223)
!2223 = !DILexicalBlock(scope: !2224, file: !1597, line: 318, column: 29)
!2224 = !DILexicalBlock(scope: !2221, file: !1597, line: 318, column: 29)
!2225 = !DILocation(line: 319, column: 13, scope: !2226)
!2226 = !DILexicalBlockFile(scope: !2223, file: !1597, discriminator: 2)
!2227 = !DILocation(line: 319, column: 39, scope: !2228)
!2228 = !DILexicalBlockFile(scope: !2229, file: !1597, discriminator: 6)
!2229 = !DILexicalBlock(scope: !2223, file: !1597, line: 319, column: 13)
!2230 = distinct !DISubprogram(name: "seekTo", linkageName: "Io.File.Writer.seekTo", scope: !1028, file: !1028, line: 197, type: !2231, scopeLine: 197, flags: DIFlagStaticMember, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!2231 = !DISubroutineType(types: !2232)
!2232 = !{!2233, !2010, !227}
!2233 = !DICompositeType(tag: DW_TAG_structure_type, name: "error{AccessDenied,Canceled,Unexpected,Unseekable,WriteFailed}!void", scope: !4, size: 16, align: 16, elements: !2234)
!2234 = !{!2235, !2237}
!2235 = !DIDerivedType(tag: DW_TAG_member, name: "error", scope: !2233, baseType: !2236, size: 16, align: 16)
!2236 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{AccessDenied,Canceled,Unexpected,Unseekable,WriteFailed}", scope: !4, baseType: !845, size: 16, align: 16)
!2237 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !2233, baseType: !99, align: 8, offset: 16)
!2238 = !DILocalVariable(name: "w", arg: 1, scope: !2230, file: !1028, line: 197, type: !2010)
!2239 = !DILocation(line: 197, column: 76, scope: !2230)
!2240 = !DILocalVariable(name: "offset", arg: 2, scope: !2230, file: !1028, line: 197, type: !227)
!2241 = !DILocation(line: 198, column: 10, scope: !2230)
!2242 = !DILocalVariable(name: "w", arg: 1, scope: !2243, file: !1597, line: 312, type: !1613)
!2243 = distinct !DISubprogram(name: "flush", linkageName: "Io.Writer.flush", scope: !1597, file: !1597, line: 312, type: !1626, scopeLine: 312, flags: DIFlagStaticMember, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!2244 = !DILocation(line: 312, column: 37, scope: !2243, inlinedAt: !2245)
!2245 = distinct !DILocation(line: 198, column: 26, scope: !2230)
!2246 = !DILocation(line: 313, column: 26, scope: !2243, inlinedAt: !2245)
!2247 = !DILocation(line: 198, column: 26, scope: !2230)
!2248 = !DILocation(line: 0, scope: !2230)
!2249 = !DILocation(line: 208, column: 32, scope: !2250, inlinedAt: !2253)
!2250 = distinct !DISubprogram(name: "seekToUnbuffered", linkageName: "Io.File.Writer.seekToUnbuffered", scope: !1028, file: !1028, line: 207, type: !2251, scopeLine: 207, flags: DIFlagStaticMember, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!2251 = !DISubroutineType(types: !2252)
!2252 = !{!1306, !2010, !227}
!2253 = distinct !DILocation(line: 199, column: 25, scope: !2230)
!2254 = !DILocalVariable(name: "w", arg: 1, scope: !2250, file: !1028, line: 207, type: !2010)
!2255 = !DILocation(line: 207, column: 65, scope: !2250, inlinedAt: !2253)
!2256 = !DILocalVariable(name: "offset", arg: 2, scope: !2250, file: !1028, line: 207, type: !227)
!2257 = !DILocation(line: 419, column: 30, scope: !2198, inlinedAt: !2258)
!2258 = distinct !DILocation(line: 208, column: 11, scope: !2259, inlinedAt: !2253)
!2259 = !DILexicalBlockFile(scope: !2250, file: !1028, discriminator: 2)
!2260 = !DILocation(line: 209, column: 17, scope: !2250, inlinedAt: !2253)
!2261 = !DILocalVariable(name: "io", scope: !2250, file: !1028, line: 209, type: !1031)
!2262 = !DILocation(line: 0, scope: !2250, inlinedAt: !2253)
!2263 = !DILocation(line: 210, column: 14, scope: !2250, inlinedAt: !2253)
!2264 = !DILocation(line: 210, column: 13, scope: !2265, inlinedAt: !2253)
!2265 = !DILexicalBlock(scope: !2250, file: !1028, line: 210, column: 13)
!2266 = !DILocation(line: 222, column: 29, scope: !2267, inlinedAt: !2253)
!2267 = !DILexicalBlock(scope: !2265, file: !1028, line: 210, column: 13)
!2268 = !DILocation(line: 222, column: 21, scope: !2267, inlinedAt: !2253)
!2269 = !DILocation(line: 212, column: 14, scope: !2270, inlinedAt: !2253)
!2270 = !DILexicalBlock(scope: !2265, file: !1028, line: 222, column: 21)
!2271 = !DILocation(line: 215, column: 18, scope: !2272, inlinedAt: !2253)
!2272 = !DILexicalBlock(scope: !2273, file: !1028, line: 215, column: 17)
!2273 = !DILexicalBlock(scope: !2265, file: !1028, line: 212, column: 14)
!2274 = !DILocation(line: 220, column: 14, scope: !2275, inlinedAt: !2253)
!2275 = !DILexicalBlockFile(scope: !2273, file: !1028, discriminator: 2)
!2276 = !DILocation(line: 216, column: 33, scope: !2277, inlinedAt: !2253)
!2277 = !DILexicalBlock(scope: !2273, file: !1028, line: 216, column: 13)
!2278 = !DILocation(line: 216, column: 48, scope: !2277, inlinedAt: !2253)
!2279 = !DILocation(line: 220, column: 14, scope: !2280, inlinedAt: !2253)
!2280 = !DILexicalBlockFile(scope: !2273, file: !1028, discriminator: 4)
!2281 = !DILocation(line: 217, column: 18, scope: !2282, inlinedAt: !2253)
!2282 = !DILexicalBlock(scope: !2277, file: !1028, line: 216, column: 33)
!2283 = !DILocation(line: 218, column: 17, scope: !2282, inlinedAt: !2253)
!2284 = !DILocation(line: 0, scope: !2265, inlinedAt: !2253)
!2285 = !DILocation(line: 199, column: 5, scope: !2286)
!2286 = !DILexicalBlock(scope: !2230, file: !1028, line: 199, column: 25)
!2287 = distinct !DISubprogram(name: "sendFile", linkageName: "Io.File.Writer.sendFile", scope: !1028, file: !1028, line: 134, type: !1616, scopeLine: 134, flags: DIFlagStaticMember, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!2288 = !DILocalVariable(name: "io_w", arg: 1, scope: !2287, file: !1028, line: 134, type: !1613)
!2289 = !DILocation(line: 134, column: 108, scope: !2287)
!2290 = !DILocalVariable(name: "file_reader", arg: 2, scope: !2287, file: !1028, line: 134, type: !1280)
!2291 = !DILocalVariable(name: "limit", arg: 3, scope: !2287, file: !1028, line: 134, type: !72)
!2292 = !DILocation(line: 135, column: 24, scope: !2287)
!2293 = !DILocalVariable(name: "w", scope: !2287, file: !1028, line: 135, type: !2010)
!2294 = !DILocation(line: 136, column: 14, scope: !2287)
!2295 = !DILocation(line: 136, column: 13, scope: !2287)
!2296 = !DILocation(line: 0, scope: !2287)
!2297 = !{!2298}
!2298 = distinct !{!2298, !2299, !"Io.File.Writer.sendFilePositional: argument 0"}
!2299 = distinct !{!2299, !"Io.File.Writer.sendFilePositional"}
!2300 = !DILocation(line: 137, column: 49, scope: !2301)
!2301 = !DILexicalBlock(scope: !2287, file: !1028, line: 136, column: 13)
!2302 = !DILocation(line: 146, column: 17, scope: !2303, inlinedAt: !2306)
!2303 = distinct !DISubprogram(name: "sendFilePositional", linkageName: "Io.File.Writer.sendFilePositional", scope: !1028, file: !1028, line: 145, type: !2304, scopeLine: 145, flags: DIFlagStaticMember, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!2304 = !DISubroutineType(types: !2305)
!2305 = !{!99, !1618, !2010, !1280, !72}
!2306 = distinct !DILocation(line: 137, column: 49, scope: !2301)
!2307 = !DILocalVariable(name: "w", arg: 1, scope: !2303, file: !1028, line: 145, type: !2010)
!2308 = !DILocation(line: 145, column: 108, scope: !2303, inlinedAt: !2306)
!2309 = !DILocalVariable(name: "file_reader", arg: 2, scope: !2303, file: !1028, line: 145, type: !1280)
!2310 = !DILocalVariable(name: "limit", arg: 3, scope: !2303, file: !1028, line: 145, type: !72)
!2311 = !DILocalVariable(name: "io", scope: !2303, file: !1028, line: 146, type: !1031)
!2312 = !DILocation(line: 0, scope: !2303, inlinedAt: !2306)
!2313 = !DILocation(line: 147, column: 40, scope: !2303, inlinedAt: !2306)
!2314 = !DILocalVariable(name: "header", scope: !2303, file: !1028, line: 147, type: !774)
!2315 = !DILocation(line: 148, column: 48, scope: !2303, inlinedAt: !2306)
!2316 = !DILocation(line: 148, column: 63, scope: !2303, inlinedAt: !2306)
!2317 = !DILocation(line: 148, column: 99, scope: !2303, inlinedAt: !2306)
!2318 = !DILocation(line: 148, column: 15, scope: !2303, inlinedAt: !2306)
!2319 = !DILocation(line: 148, column: 15, scope: !2320, inlinedAt: !2306)
!2320 = !DILexicalBlock(scope: !2303, file: !1028, line: 148, column: 15)
!2321 = !{!"branch_weights", i32 1, i32 12000, i32 1, i32 1, i32 1, i32 1, i32 1}
!2322 = !DILocation(line: 148, column: 15, scope: !2323, inlinedAt: !2306)
!2323 = !DILexicalBlockFile(scope: !2324, file: !1028, discriminator: 2)
!2324 = !DILexicalBlock(scope: !2320, file: !1028, line: 148, column: 15)
!2325 = !DILocalVariable(name: "n", scope: !2303, file: !1028, line: 170, type: !73)
!2326 = !DILocation(line: 170, column: 13, scope: !2327, inlinedAt: !2306)
!2327 = !DILexicalBlock(scope: !2324, file: !1028, line: 167, column: 29)
!2328 = !DILocation(line: 173, column: 6, scope: !2303, inlinedAt: !2306)
!2329 = !DILocation(line: 173, column: 11, scope: !2303, inlinedAt: !2306)
!2330 = !DILocation(line: 2265, column: 44, scope: !2050, inlinedAt: !2331)
!2331 = distinct !DILocation(line: 174, column: 31, scope: !2303, inlinedAt: !2306)
!2332 = !DILocation(line: 2266, column: 14, scope: !2057, inlinedAt: !2331)
!2333 = !DILocation(line: 2267, column: 35, scope: !2059, inlinedAt: !2331)
!2334 = !DILocation(line: 2268, column: 26, scope: !2059, inlinedAt: !2331)
!2335 = !DILocation(line: 2270, column: 9, scope: !2059, inlinedAt: !2331)
!2336 = !DILocation(line: 2273, column: 14, scope: !2050, inlinedAt: !2331)
!2337 = !DILocation(line: 2273, column: 5, scope: !2050, inlinedAt: !2331)
!2338 = !DILocation(line: 0, scope: !2050, inlinedAt: !2331)
!2339 = !DILocation(line: 174, column: 5, scope: !2303, inlinedAt: !2306)
!2340 = !DILocation(line: 150, column: 40, scope: !2341, inlinedAt: !2306)
!2341 = !DILexicalBlock(scope: !2324, file: !1028, line: 148, column: 15)
!2342 = !DILocation(line: 54, column: 44, scope: !2070, inlinedAt: !2343)
!2343 = distinct !DILocation(line: 150, column: 40, scope: !2341, inlinedAt: !2306)
!2344 = !DILocation(line: 55, column: 24, scope: !2076, inlinedAt: !2343)
!2345 = !DILocation(line: 151, column: 26, scope: !2341, inlinedAt: !2306)
!2346 = !DILocalVariable(name: "pos", scope: !2341, file: !1028, line: 151, type: !227)
!2347 = !DILocation(line: 152, column: 17, scope: !2348, inlinedAt: !2306)
!2348 = !DILexicalBlock(scope: !2341, file: !1028, line: 152, column: 17)
!2349 = !DILocation(line: 162, column: 14, scope: !2350, inlinedAt: !2306)
!2350 = !DILexicalBlock(scope: !2324, file: !1028, line: 159, column: 13)
!2351 = !DILocation(line: 163, column: 13, scope: !2350, inlinedAt: !2306)
!2352 = !DILocation(line: 165, column: 30, scope: !2353, inlinedAt: !2306)
!2353 = !DILexicalBlock(scope: !2324, file: !1028, line: 163, column: 13)
!2354 = !DILocation(line: 166, column: 32, scope: !2355, inlinedAt: !2306)
!2355 = !DILexicalBlock(scope: !2324, file: !1028, line: 165, column: 30)
!2356 = !DILocation(line: 167, column: 29, scope: !2357, inlinedAt: !2306)
!2357 = !DILexicalBlock(scope: !2324, file: !1028, line: 166, column: 32)
!2358 = !DILocalVariable(name: "e", scope: !2327, file: !1028, line: 167, type: !2359)
!2359 = !DIDerivedType(tag: DW_TAG_typedef, name: "error{AccessDenied,BrokenPipe,CorruptedData,DeviceBusy,DiskQuota,FileBusy,FileTooBig,InputOutput,LockViolation,NoDevice,NoSpaceLeft,NotOpenForWriting,PermissionDenied,SystemResources,Unexpected,WouldBlock}", scope: !4, baseType: !845, size: 16, align: 16)
!2360 = !DILocation(line: 167, column: 29, scope: !2327, inlinedAt: !2306)
!2361 = !DILocation(line: 169, column: 14, scope: !2327, inlinedAt: !2306)
!2362 = !DILocation(line: 170, column: 13, scope: !2363, inlinedAt: !2306)
!2363 = !DILexicalBlockFile(scope: !2327, file: !1028, discriminator: 2)
!2364 = !DILocation(line: 159, column: 13, scope: !2341, inlinedAt: !2306)
!2365 = !DILocation(line: 153, column: 18, scope: !2366, inlinedAt: !2306)
!2366 = !DILexicalBlock(scope: !2348, file: !1028, line: 152, column: 17)
!2367 = !DILocation(line: 154, column: 25, scope: !2368, inlinedAt: !2306)
!2368 = !DILexicalBlock(scope: !2366, file: !1028, line: 154, column: 17)
!2369 = !DILocation(line: 155, column: 22, scope: !2370, inlinedAt: !2306)
!2370 = !DILexicalBlock(scope: !2368, file: !1028, line: 154, column: 25)
!2371 = !DILocation(line: 156, column: 21, scope: !2372, inlinedAt: !2306)
!2372 = !DILexicalBlockFile(scope: !2370, file: !1028, discriminator: 4)
!2373 = !DILocation(line: 137, column: 24, scope: !2301)
!2374 = !DILocation(line: 138, column: 31, scope: !2375)
!2375 = !DILexicalBlock(scope: !2287, file: !1028, line: 137, column: 24)
!2376 = !DILocation(line: 178, column: 17, scope: !2377, inlinedAt: !2378)
!2377 = distinct !DISubprogram(name: "sendFileStreaming", linkageName: "Io.File.Writer.sendFileStreaming", scope: !1028, file: !1028, line: 177, type: !2304, scopeLine: 177, flags: DIFlagStaticMember, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!2378 = distinct !DILocation(line: 139, column: 47, scope: !2379)
!2379 = !DILexicalBlock(scope: !2287, file: !1028, line: 138, column: 31)
!2380 = !DILocalVariable(name: "w", arg: 1, scope: !2377, file: !1028, line: 177, type: !2010)
!2381 = !DILocation(line: 177, column: 107, scope: !2377, inlinedAt: !2378)
!2382 = !DILocalVariable(name: "file_reader", arg: 2, scope: !2377, file: !1028, line: 177, type: !1280)
!2383 = !DILocalVariable(name: "limit", arg: 3, scope: !2377, file: !1028, line: 177, type: !72)
!2384 = !{!2385}
!2385 = distinct !{!2385, !2386, !"Io.File.Writer.sendFileStreaming: argument 0"}
!2386 = distinct !{!2386, !"Io.File.Writer.sendFileStreaming"}
!2387 = !DILocalVariable(name: "io", scope: !2377, file: !1028, line: 178, type: !1031)
!2388 = !DILocation(line: 0, scope: !2377, inlinedAt: !2378)
!2389 = !DILocation(line: 179, column: 40, scope: !2377, inlinedAt: !2378)
!2390 = !DILocalVariable(name: "header", scope: !2377, file: !1028, line: 179, type: !774)
!2391 = !DILocation(line: 180, column: 47, scope: !2377, inlinedAt: !2378)
!2392 = !DILocation(line: 180, column: 62, scope: !2377, inlinedAt: !2378)
!2393 = !DILocation(line: 180, column: 15, scope: !2377, inlinedAt: !2378)
!2394 = !DILocation(line: 180, column: 15, scope: !2395, inlinedAt: !2378)
!2395 = !DILexicalBlock(scope: !2377, file: !1028, line: 180, column: 15)
!2396 = !{!"branch_weights", i32 1, i32 10000, i32 1, i32 1, i32 1, i32 1}
!2397 = !DILocation(line: 180, column: 15, scope: !2398, inlinedAt: !2378)
!2398 = !DILexicalBlockFile(scope: !2399, file: !1028, discriminator: 2)
!2399 = !DILexicalBlock(scope: !2395, file: !1028, line: 180, column: 15)
!2400 = !DILocalVariable(name: "n", scope: !2377, file: !1028, line: 190, type: !73)
!2401 = !DILocation(line: 190, column: 13, scope: !2402, inlinedAt: !2378)
!2402 = !DILexicalBlock(scope: !2399, file: !1028, line: 187, column: 29)
!2403 = !DILocation(line: 193, column: 6, scope: !2377, inlinedAt: !2378)
!2404 = !DILocation(line: 193, column: 11, scope: !2377, inlinedAt: !2378)
!2405 = !DILocation(line: 2265, column: 44, scope: !2050, inlinedAt: !2406)
!2406 = distinct !DILocation(line: 194, column: 31, scope: !2377, inlinedAt: !2378)
!2407 = !DILocation(line: 2266, column: 14, scope: !2057, inlinedAt: !2406)
!2408 = !DILocation(line: 2267, column: 35, scope: !2059, inlinedAt: !2406)
!2409 = !DILocation(line: 2268, column: 26, scope: !2059, inlinedAt: !2406)
!2410 = !DILocation(line: 2270, column: 9, scope: !2059, inlinedAt: !2406)
!2411 = !DILocation(line: 2273, column: 14, scope: !2050, inlinedAt: !2406)
!2412 = !DILocation(line: 2273, column: 5, scope: !2050, inlinedAt: !2406)
!2413 = !DILocation(line: 0, scope: !2050, inlinedAt: !2406)
!2414 = !DILocation(line: 194, column: 5, scope: !2377, inlinedAt: !2378)
!2415 = !DILocation(line: 182, column: 14, scope: !2416, inlinedAt: !2378)
!2416 = !DILexicalBlock(scope: !2399, file: !1028, line: 180, column: 15)
!2417 = !DILocation(line: 183, column: 13, scope: !2416, inlinedAt: !2378)
!2418 = !DILocation(line: 185, column: 30, scope: !2419, inlinedAt: !2378)
!2419 = !DILexicalBlock(scope: !2399, file: !1028, line: 183, column: 13)
!2420 = !DILocation(line: 186, column: 32, scope: !2421, inlinedAt: !2378)
!2421 = !DILexicalBlock(scope: !2399, file: !1028, line: 185, column: 30)
!2422 = !DILocation(line: 187, column: 29, scope: !2423, inlinedAt: !2378)
!2423 = !DILexicalBlock(scope: !2399, file: !1028, line: 186, column: 32)
!2424 = !DILocalVariable(name: "e", scope: !2402, file: !1028, line: 187, type: !2359)
!2425 = !DILocation(line: 187, column: 29, scope: !2402, inlinedAt: !2378)
!2426 = !DILocation(line: 189, column: 14, scope: !2402, inlinedAt: !2378)
!2427 = !DILocation(line: 190, column: 13, scope: !2428, inlinedAt: !2378)
!2428 = !DILexicalBlockFile(scope: !2402, file: !1028, discriminator: 2)
!2429 = !DILocation(line: 139, column: 23, scope: !2379)
!2430 = !DILocation(line: 140, column: 30, scope: !2431)
!2431 = !DILexicalBlock(scope: !2287, file: !1028, line: 139, column: 23)
!2432 = !DILocation(line: 141, column: 21, scope: !2433)
!2433 = !DILexicalBlock(scope: !2287, file: !1028, line: 140, column: 30)
!2434 = !DILocation(line: 141, column: 21, scope: !2435)
!2435 = !DILexicalBlockFile(scope: !2433, file: !1028, discriminator: 2)
!2436 = distinct !DISubprogram(name: "noAlloc", linkageName: "mem.Allocator.noAlloc", scope: !1744, file: !1744, line: 84, type: !1753, scopeLine: 89, flags: DIFlagStaticMember, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!2437 = !DILocalVariable(name: "self", arg: 1, scope: !2436, file: !1744, line: 89, type: !808)
!2438 = !DILocation(line: 89, column: 10, scope: !2436)
!2439 = !DILocalVariable(name: "len", arg: 2, scope: !2436, file: !1744, line: 89, type: !73)
!2440 = !DILocalVariable(name: "alignment", arg: 3, scope: !2436, file: !1744, line: 89, type: !835)
!2441 = !DILocalVariable(name: "ret_addr", arg: 4, scope: !2436, file: !1744, line: 89, type: !73)
!2442 = !DILocation(line: 94, column: 5, scope: !2436)
!2443 = distinct !DISubprogram(name: "unreachableFree", linkageName: "mem.Allocator.unreachableFree", scope: !1744, file: !1744, line: 519, type: !1766, scopeLine: 524, flags: DIFlagStaticMember, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!2444 = !DILocation(line: 529, column: 5, scope: !2443)
!2445 = distinct !DISubprogram(name: "unreachableRemap", linkageName: "mem.Allocator.unreachableRemap", scope: !1744, file: !1744, line: 504, type: !1762, scopeLine: 510, flags: DIFlagStaticMember, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!2446 = !DILocation(line: 516, column: 5, scope: !2445)
!2447 = distinct !DISubprogram(name: "unreachableResize", linkageName: "mem.Allocator.unreachableResize", scope: !1744, file: !1744, line: 489, type: !1758, scopeLine: 495, flags: DIFlagStaticMember, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !4)
!2448 = !DILocation(line: 501, column: 5, scope: !2447)
