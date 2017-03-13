class Antlr4RuntimeCpp < Formula
  desc "ANother Tool for Language Recognition - C++ runtime"
  homepage "https://github.com/dsogari/polymul"
  url "https://github.com/antlr/antlr4/archive/4.6.tar.gz"
  sha256 "eba012cc10fd0908c30476ea4f519490f539270ab68945109d150c5b091d6c86"
  head "https://github.com/antlr/antlr4.git"

  depends_on "cmake" => :build

  patch :DATA

  def install
    cd "./runtime/Cpp"
    system "cmake", ".", *std_cmake_args
    system "make"
    system "make", "install"
  end

  test do
    system "make", "check"

    (testpath/"test.cpp").write <<-EOS.undent
      #include <antlr4-runtime.h>
      int main() {
        return 0;
      }
    EOS
    system ENV.cc, "test.cpp", "-L#{lib}", "-lantlr4-runtime", "-o", "test"
    system "./test"
  end
end

__END__
diff -r -c antlr4-4.6.orig/runtime/Cpp/CMakeLists.txt antlr4-4.6/runtime/Cpp/CMakeLists.txt
*** antlr4-4.6.orig/runtime/Cpp/CMakeLists.txt	2016-12-15 20:25:36.000000000 -0200
--- antlr4-4.6/runtime/Cpp/CMakeLists.txt	2017-02-03 04:14:13.447920200 -0200
***************
*** 107,111 ****
   add_subdirectory(demo)
  endif(WITH_DEMO)
  
! install(FILES License.txt README.md VERSION 
          DESTINATION "share/doc/libantlr4")
--- 107,119 ----
   add_subdirectory(demo)
  endif(WITH_DEMO)
  
! if( EXISTS LICENSE.txt)
! install(FILES LICENSE.txt
          DESTINATION "share/doc/libantlr4")
+ elseif(EXISTS ../../LICENSE.txt) 
+ install(FILES ../../LICENSE.txt
+     DESTINATION "share/doc/libantlr4")
+ endif()
+ 
+ install(FILES README.md VERSION 
+     DESTINATION "share/doc/libantlr4")