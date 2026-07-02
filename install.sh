#!/bin/bash

if [ $# -eq 0 ]; then
  languages="c c++ python java javascript ruby go dart php lua csharp perl rust"
else
  languages="$@"
fi

sudo apt update
sudo apt install build-essential -y
sudo apt install libaprutil1-dev -y
sudo apt install libminimap2-dev -y
sudo apt install libpcre2-dev -y
sudo apt install libboost-thread-dev -y
sudo apt install libgmp-dev -y
sudo apt install libgmp3-dev -y
sudo apt install apt-transport-https -y
sudo apt autoremove -y

for lang in $languages; do
  case $lang in
    c)
      sudo apt install gcc -y

      cd c

      cd binarytrees
      echo -e '\e[32m[1/10] compiling binarytrees.gcc-2.c\e[0m'
      gcc -pipe -Wall -O3 -fomit-frame-pointer -march=ivybridge -fopenmp -I/usr/include/apr-1.0 binarytrees.gcc-2.c -o binarytrees.gcc-2.gcc_run -lapr-1
      cd ..

      cd fannkuchredux
      echo  -e '\e[32m[2/10] compiling fannkuchredux.gcc-5.c\e[0m'
      gcc -pipe -Wall -O3 -fomit-frame-pointer -march=ivybridge -fopenmp fannkuchredux.gcc-5.c -o fannkuchredux.gcc-5.gcc_run
      cd ..

      cd fasta
      echo  -e '\e[32m[3/10] compiling fasta.gcc-9.c\e[0m'
      gcc -pipe -Wall -O3 -fomit-frame-pointer -march=ivybridge -fopenmp fasta.gcc-9.c -w -o fasta.gcc-9.gcc_run
      cd ..

      cd knucleotide
      echo  -e '\e[32m[4/10] compiling knucleotide.gcc.c\e[0m'
      gcc -pthread -pipe -O3 -fomit-frame-pointer -march=native -std=c99 knucleotide.gcc.c -o knucleotide.gcc_run
      cd ..

      cd mandelbrot
      echo  -e '\e[32m[5/10] compiling mandelbrot.gcc-8.c\e[0m'
      gcc -pipe -Wall -O3 -fomit-frame-pointer -march=ivybridge -fopenmp mandelbrot.gcc-8.c -o mandelbrot.gcc-8.gcc_run
      cd ..

      cd nbody
      echo  -e '\e[32m[6/10]compiling nbody.gcc-6.c\e[0m'
      gcc -pipe -Wall -O3 -fomit-frame-pointer -march=ivybridge  nbody.gcc-6.c -o nbody.gcc-6.gcc_run -lm
      cd ..

      cd pidigits
      echo  -e '\e[32m[7/10] compiling pidigits.gcc-2.c\e[0m'
      gcc -pipe -Wall -O3 -fomit-frame-pointer -march=ivybridge  pidigits.gcc-2.c -o pidigits.gcc-2.gcc_run -lgmp
      cd ..

      cd regexredux
      echo  -e '\e[32m[8/10] compiling regexredux.gcc-5.c\e[0m'
      gcc -pipe -Wall -O3 -fomit-frame-pointer -march=ivybridge -fopenmp regexredux.gcc-5.c -o regexredux.gcc-5.gcc_run -lpcre2-8
      cd ..

      cd reversecomplement
      echo  -e '\e[32m[9/10] compiling revcomp.gcc-8.c\e[0m'
      gcc -pipe -Wall -O3 -fomit-frame-pointer -march=ivybridge -pthread revcomp.gcc-8.c -o revcomp.gcc-8.gcc_run
      cd ..

      cd spectralnorm
      echo  -e '\e[32m[10/10] compiling spectralnorm.gcc-3.c\e[0m'
      gcc -pipe -Wall -O3 -fomit-frame-pointer -march=ivybridge -fopenmp spectralnorm.gcc-3.c -o spectralnorm.gcc-3.gcc_run -lm
      cd ..

      cd ..
      ;;
    c++)
      sudo apt install g++ -y

      cd c++

      cd binarytrees
      echo -e '\e[32m[1/10] compiling binarytrees.gpp-7.c++\e[0m'
      g++ -c -pipe -O3 -fomit-frame-pointer -march=ivybridge  -std=gnu++17 binarytrees.gpp-7.c++ -o binarytrees.gpp-7.c++.o
      g++ binarytrees.gpp-7.c++.o -o binarytrees.gpp-7.gpp_run
      cd ..

      cd fannkuchredux
      echo -e '\e[32m[2/10] compiling fannkuchredux.gpp-5.c++\e[0m'
      g++ -c -pipe -O3 -fomit-frame-pointer -march=ivybridge  -std=c++11 -fopenmp fannkuchredux.gpp-5.c++ -o fannkuchredux.gpp-5.c++.o
      g++ fannkuchredux.gpp-5.c++.o -o fannkuchredux.gpp-5.gpp_run -fopenmp
      cd ..

      cd fasta
      echo -e '\e[32m[3/10] compiling fasta.gpp-6.c++\e[0m'
      g++ -c -pipe -O3 -fomit-frame-pointer -march=ivybridge  -std=c++11 -O2 fasta.gpp-6.c++ -o fasta.gpp-6.c++.o
      g++ fasta.gpp-6.c++.o -o fasta.gpp-6.gpp_run -lpthread
      cd ..

      cd knucleotide
      echo -e '\e[32m[4/10] compiling knucleotide.gpp-2.c++\e[0m'
      g++ -c -pipe -O3 -fomit-frame-pointer -march=ivybridge  -std=c++17 knucleotide.gpp-2.c++ -o knucleotide.gpp-2.c++.o
      g++ knucleotide.gpp-2.c++.o -o knucleotide.gpp-2.gpp_run -lpthread
      cd ..

      cd mandelbrot
      echo -e '\e[32m[5/10] compiling mandelbrot.gpp-0.c++\e[0m'
      g++ -c -pipe -O3 -fomit-frame-pointer -march=ivybridge  --std=c++17 -I ./Include/gpp/vcl mandelbrot.gpp-0.c++ -o mandelbrot.gpp-0.c++.o
      g++ mandelbrot.gpp-0.c++.o -o mandelbrot.gpp-0.gpp_run -pthread
      cd ..

      cd nbody
      echo -e '\e[32m[6/10] compiling nbody.gpp-9.c++\e[0m'
      g++ -c -pipe -O3 -fomit-frame-pointer -march=ivybridge  -std=c++17 nbody.gpp-9.c++ -o nbody.gpp-9.c++.o && g++ nbody.gpp-9.c++.o -o nbody.gpp-9.gpp_run
      cd ..

      cd pidigits
      echo -e '\e[32m[7/10] compiling pidigits.gpp-4.c++\e[0m'
      g++ -c -pipe -O3 -fomit-frame-pointer -march=ivybridge  -std=c++14 -g pidigits.gpp-4.c++ -o pidigits.gpp-4.c++.o
      g++ pidigits.gpp-4.c++.o -o pidigits.gpp-4.gpp_run -lgmp -lgmpxx
      cd ..

      cd regexredux
      echo -e '\e[32m[8/10] compiling regexredux.gpp-6.c++\e[0m'
      g++ -c -pipe -O3 -fomit-frame-pointer -march=ivybridge  -std=c++17 regexredux.gpp-6.c++ -o regexredux.gpp-6.c++.o
      g++ regexredux.gpp-6.c++.o -o regexredux.gpp-6.gpp_run -lpcre2-8 -lpthread
      rm regexredux.gpp-6.c++.o
      cd ..

      cd reversecomplement
      echo -e '\e[32m[9/10] compiling revcomp.gpp-6.c++\e[0m'
      g++ -c -pipe -O3 -fomit-frame-pointer -march=ivybridge  -std=c++11 revcomp.gpp-6.c++ -o revcomp.gpp-6.c++.o
      g++ revcomp.gpp-6.c++.o -o revcomp.gpp-6.gpp_run -pthread
      cd ..

      cd spectralnorm
      echo -e '\e[32m[10/10] compiling spectralnorm.gpp-8.c++\e[0m'
      g++ -c -pipe -O3 -fomit-frame-pointer -march=ivybridge  -w -fopenmp -O0 spectralnorm.gpp-8.c++ -o spectralnorm.gpp-8.c++.o
      g++ spectralnorm.gpp-8.c++.o -o spectralnorm.gpp-8.gpp_run -fopenmp
      cd ..

      cd ..
      ;;
    python)
      sudo apt install python3-pip -y
      pip install pandas
      pip install gmpy
      pip install gmpy2
      ;;
    java)
      sudo apt install openjdk-19-jdk -y

      cd java

      cd binarytrees
       echo -e '\e[32m[1/10]compiling binarytrees.java\e[0m'
      javac -d . -cp . binarytrees.java
      cd ..

      cd fannkuchredux
      echo -e '\e[32m[2/10] compiling fannkuchredux.java\e[0m'
      javac -d . -cp . fannkuchredux.java
      cd ..

      cd fasta
      echo -e '\e[32m[3/10] compiling fasta.java\e[0m'
      javac -d . -cp . fasta.java
      cd ..

      cd knucleotide
      echo -e '\e[32m[4/10] compiling knucleotide.java\e[0m'
      javac -d . -cp .:/opt/src/java-libs/fastutil-8.3.1.jar knucleotide.java
      cd ..

      cd mandelbrot
      echo -e '\e[32m[5/10] compiling mandelbrot.java\e[0m'
      javac -d . -cp . mandelbrot.java
      cd ..

      cd nbody
      echo -e '\e[32m[6/10] compiling nbody.java\e[0m'
      javac -d . -cp . nbody.java
      cd ..

      cd pidigits
      echo -e '\e[32m[7/10] compiling pidigits.java\e[0m'
      javac -d . -cp . pidigits.java
      cd ..

      cd regexredux
      echo -e '\e[32m[8/10] compiling regexredux.java\e[0m'
      javac -d . -cp . regexredux.java
      cd ..

      cd reversecomplement
      echo -e '\e[32m[9/10] compiling revcomp.java\e[0m'
      javac -d . -cp . revcomp.java
      cd ..

      cd spectralnorm
      echo -e '\e[32m[10/10] compiling spectralnorm.java\e[0m'
      javac -d . -cp . spectralnorm.java
      cd ..

      cd ..
      ;;
    javascript)
      sudo apt-get update
      sudo apt-get install -y ca-certificates curl gnupg
      sudo mkdir -p /etc/apt/keyrings
      curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

      NODE_MAJOR=18
      echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

      sudo apt update
      sudo apt install nodejs -y

      cd javascript/pidigits
      npm install mpzjs
      cd ../..
      ;;
    ruby)
      sudo apt install ruby -y
      sudo apt install ruby-dev -y
      sudo gem install gmp
      ;;
    go)
      sudo apt install golang-go -y
      go env -w GO111MODULE=auto
      go get github.com/ncw/gmp

      cd go

      cd binarytrees
      echo  -e '\e[32m[1/10] compiling binarytrees.go-2.go\e[0m'
      go build -o binarytrees.go-2.go_run binarytrees.go-2.go
      cd ..

      cd fannkuchredux
      echo -e '\e[32m[2/10] compiling fannkuchredux.go-3.go\e[0m'
      go build -o fannkuchredux.go-3.go_run fannkuchredux.go-3.go
      cd ..

      cd fasta
      echo -e '\e[32m[3/10] compiling fasta.go-2.go\e[0m'
      go build -o fasta.go-2.go_run fasta.go-2.go
      cd ..

      cd knucleotide
      echo -e '\e[32m[4/10] compiling knucleotide.go-7.go\e[0m'
      go build -o knucleotide.go-7.go_run knucleotide.go-7.go
      cd ..

      cd mandelbrot
      echo -e '\e[32m[5/10] compiling mandelbrot.go-4.go\e[0m'
      go build -o mandelbrot.go-4.go_run mandelbrot.go-4.go
      cd ..

      cd nbody
      echo -e '\e[32m[6/10] compiling nbody.go-3.go\e[0m'
      go build -o nbody.go-3.go_run nbody.go-3.go
      cd ..

      cd pidigits
      echo -e '\e[32m[7/10] compiling pidigits.go\e[0m'
      go build -o pidigits.go_run pidigits.go
      cd ..

      cd regexredux
      echo -e '\e[32m[8/10] compiling regexredux.go-5.go\e[0m'
      go build -o regexredux.go-5.go_run regexredux.go-5.go
      cd ..

      cd reversecomplement
      echo -e '\e[32m[9/10] compiling revcomp.go-6.go\e[0m'
      go build -o revcomp.go-6.go_run revcomp.go-6.go
      cd ..

      cd spectralnorm
      echo -e '\e[32m[10/10] compiling spectralnorm.go-4.go\e[0m'
      go build -o spectralnorm.go-4.go_run spectralnorm.go-4.go
      cd ..

      cd ..
      ;;
    dart)
      wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo gpg --yes --dearmor -o /usr/share/keyrings/dart.gpg
      echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' | sudo tee /etc/apt/sources.list.d/dart_stable.list
      sudo apt update
      sudo apt install dart -y

      cd dart

      cd binarytrees
      echo -e '\e[32m[1/10] compiling binarytrees.dart\e[0m'
      dart compile exe binarytrees.dart -o binarytrees_run > /dev/null
      cd ..

      cd fannkuchredux
      echo -e '\e[32m[2/10] compiling fannkuchredux.dart\e[0m'
      dart compile exe fannkuchredux.dart -o fannkuchredux_run > /dev/null
      cd ..

      cd fasta
      echo -e '\e[32m[3/10] compiling fasta.dart\e[0m'
      dart compile exe fasta.dart -o fasta_run > /dev/null
      cd ..

      cd knucleotide
      echo -e '\e[32m[4/10] compiling knucleotide.dart\e[0m'
      dart compile exe knucleotide.dart -o knucleotide_run > /dev/null
      cd ..

      cd mandelbrot
      echo -e '\e[32m[5/10] compiling mandelbrot.dart\e[0m'
      dart compile exe mandelbrot.dart -o mandelbrot_run > /dev/null
      cd ..

      cd nbody
      echo -e '\e[32m[6/10] compiling nbody.dart\e[0m'
      dart compile exe nbody.dart -o nbody_run > /dev/null
      cd ..

      cd pidigits
      echo -e '\e[32m[7/10] compiling pidigits.dart\e[0m'
      dart compile exe pidigits.dart -o pidigits_run > /dev/null
      cd ..

      cd regexredux
      echo -e '\e[32m[8/10] compiling regexredux.dart\e[0m'
      dart compile exe regexredux.dart -o regexredux_run > /dev/null
      cd ..

      cd reversecomplement
      echo -e '\e[32m[9/10] compiling reversecomplement.dart\e[0m'
      dart compile exe reversecomplement.dart -o reversecomplement_run > /dev/null
      cd ..

      cd spectralnorm
      echo -e '\e[32m[10/10] compiling spectralnorm.dart\e[0m'
      dart compile exe spectralnorm.dart -o spectralnorm_run > /dev/null
      cd ..

      cd ..
      ;;
    php)
      sudo sudo add-apt-repository ppa:ondrej/php -y
      sudo apt update
      sudo apt install php8.2 -y
      sudo apt install php8.2-gmp -y
      ;;
    lua)
      sudo apt install lua5.3 -y
      sudo apt install luarocks -y
      sudo apt-get install liblua5.3-dev -y
      sudo luarocks-5.3 install lgmp GMP_DIR=$(pwd)/lua/pidigits
      sudo luarocks-5.3 install lrexlib-pcre2
      ;;
    c#)
      sudo apt install dotnet-sdk-7.0 -y

      cd c#

      cd binarytrees
      echo -e '\e[32m[1/10] compiling binarytrees.cs\e[0m'
      dotnet new console --force -o program > /dev/null
      cp binarytrees.cs program/Program.cs
      dotnet build program/ > /dev/null
      cd ..

      cd fannkuchredux
      echo -e '\e[32m[2/10] compiling fannkuchredux.cs\e[0m'
      dotnet new console --force -o program > /dev/null
      cp fannkuchredux.cs program/Program.cs
      dotnet build program/ > /dev/null
      cd ..

      cd fasta
      echo -e '\e[32m[3/10] compiling fasta.cs\e[0m'
      dotnet new console --force -o program > /dev/null
      cp fasta.cs program/Program.cs
      dotnet build program/ > /dev/null
      cd ..

      cd knucleotide
      echo -e '\e[32m[4/10] compiling knucleotide.cs\e[0m'
      dotnet new console --force -o program > /dev/null
      cp knucleotide.cs program/Program.cs
      cd program/
      dotnet add package Microsoft.Experimental.Collections --version 1.0.6-e190117-3 > /dev/null
      cd ..
      dotnet build program/ > /dev/null
      cd ..

      cd mandelbrot
      echo -e '\e[32m[5/10] compiling mandelbrot.cs\e[0m'
      dotnet new console --force -o program > /dev/null
      cp mandelbrot.cs program/Program.cs
      dotnet build program/ > /dev/null
      cd ..

      cd nbody
      echo -e '\e[32m[6/10] compiling nbody.cs\e[0m'
      dotnet new console --force -o program > /dev/null
      cp nbody.cs program/Program.cs
      dotnet build program/ > /dev/null
      cd ..

      cd pidigits
      echo -e '\e[32m[7/10] compiling pidigts.cs\e[0m'
      dotnet new console --force -o program > /dev/null
      cp pidigts.cs program/Program.cs
      dotnet build program/ > /dev/null
      cd ..

      cd regexredux
      echo -e '\e[32m[8/10] compiling regexredux.cs\e[0m'
      dotnet new console --force -o program > /dev/null
      cp regexredux.cs program/Program.cs
      dotnet build program/ > /dev/null
      cd ..

      cd reversecomplement
      echo -e '\e[32m[9/10] compiling reversecomplement.cs\e[0m'
      dotnet new console --force -o program > /dev/null
      cp reversecomplement.cs program/Program.cs
      dotnet build program/ > /dev/null
      cd ..

      cd spectralnorm
      echo -e '\e[32m[10/10] compiling spectralnorm.cs\e[0m'
      dotnet new console --force -o program > /dev/null
      cp spectralnorm.cs program/Program.cs
      dotnet build program/ > /dev/null
      cd ..

      cd ..
      ;;
    f#)
      sudo apt install dotnet-sdk-7.0 -y

      cd f#

      cd binarytrees
      echo -e '\e[32m[1/10] compiling binarytrees.fs\e[0m'
      dotnet new console --force -lang f# -o program > /dev/null
      cp binarytrees.fs program/Program.fs
      dotnet build program/ > /dev/null
      cd ..

      cd fannkuchredux
      echo -e '\e[32m[2/10] compiling fannkuchredux.fs\e[0m'
      dotnet new console --force -lang f# -o program > /dev/null
      cp fannkuchredux.fs program/Program.fs
      dotnet build program/ > /dev/null
      cd ..

      cd fasta
      echo -e '\e[32m[3/10] compiling fasta.fs\e[0m'
      dotnet new console --force -lang f# -o program > /dev/null
      cp fasta.fs program/Program.fs
      dotnet build program/ > /dev/null
      cd ..

      cd knucleotide
      echo -e '\e[32m[4/10] compiling knucleotide.fs\e[0m'
      dotnet new console --force -lang f# -o program > /dev/null
      cp knucleotide.fs program/Program.fs
      cd program/
      dotnet add package Microsoft.Experimental.Collections --version 1.0.6-e190117-3 > /dev/null
      cd ..
      dotnet build program/ > /dev/null
      cd ..

      cd mandelbrot
      echo -e '\e[32m[5/10] compiling mandelbrot.fs\e[0m'
      dotnet new console --force -lang f# -o program > /dev/null
      cp mandelbrot.fs program/Program.fs
      dotnet build program/ > /dev/null
      cd ..

      cd nbody
      echo -e '\e[32m[6/10] compiling nbody.fs\e[0m'
      dotnet new console --force -lang f# -o program > /dev/null
      cp nbody.fs program/Program.fs
      dotnet build program/ > /dev/null
      cd ..

      cd pidigits
      echo -e '\e[32m[7/10] compiling pidigts.fs\e[0m'
      dotnet new console --force -lang f# -o program > /dev/null
      cp pidigts.fs program/Program.fs
      dotnet build program/ > /dev/null
      cd ..

      cd regexredux
      echo -e '\e[32m[8/10] compiling regexredux.fs\e[0m'
      dotnet new console --force -lang f# -o program > /dev/null
      cp regexredux.fs program/Program.fs
      dotnet build program/ > /dev/null
      cd ..

      cd reversecomplement
      echo -e '\e[32m[9/10] compiling reversecomplement.fs\e[0m'
      dotnet new console --force -lang f# -o program > /dev/null
      cp reversecomplement.fs program/Program.fs
      dotnet build program/ > /dev/null
      cd ..

      cd spectralnorm
      echo -e '\e[32m[10/10] compiling spectralnorm.fs\e[0m'
      dotnet new console --force -lang f# -o program > /dev/null
      cp spectralnorm.fs program/Program.fs
      dotnet build program/ > /dev/null
      cd ..

      cd ..
      ;;
    perl)
      sudo apt install perl
      sudo apt install -y libmath-bigint-gmp-perl
      ;;
    fortran)
      sudo apt install cpp -y
      sudo apt install gfortran -y

      cd fortran

      cd binarytrees
      echo -e '\e[32m[1/10] compiling binarytrees.f90\e[0m'
      gfortran -O3 -march=ivybridge -fopenmp binarytrees.f90 -o binarytrees_gfortran_run -lapr-1
      cd ..

      cd fannkuchredux
      echo -e '\e[32m[2/10] compiling fannkuchredux.f90\e[0m'
      gfortran -O3 -march=ivybridge -fopenmp fannkuchredux.f90 -o fannkuchredux.gfortran_run
      cd ..

      cd fasta
      echo -e '\e[32m[3/10] compiling fasta.f90\e[0m'
      gfortran -O3 -march=ivybridge -static -ffast-math -fopenmp fasta.f90 -o fasta.gfortran_run
      cd ..

      cd knucleotide
      echo -e '\e[32m[5/10] compiling knucleotide.f90\e[0m'
      gfortran -O3 -fomit-frame-pointer knucleotide.f90 -o knucleotide_gfortran_run
      cd ..

      cd mandelbrot
      echo -e '\e[32m[5/10] compiling mandelbrot.f90\e[0m'
      gfortran -O3 -march=ivybridge -fopenmp mandelbrot.f90 -o mandelbrot.gfortran_run
      cd ..

      cd nbody
      echo -e '\e[32m[6/10] compiling nbody.f90\e[0m'
      gfortran -O3 -march=ivybridge -static nbody.f90 -o nbody.gfortran_run
      cd ..

      cd pidigits
      echo -e '\e[32m[7/10] compiling pidigits.f90\e[0m'
      gfortran -O3 -march=ivybridge pidigits.f90 -o pidigits.gfortran_run -lgmp
      cd ..

      cd regexredux
      echo -e '\e[32m[8/10] compiling regexredux.f90\e[0m'
      gfortran -O3 -march=native -fopenmp -o regexredux.gfortran_run regexredux.f90 -lpcre2-8
      cd ..

      cd reversecomplement
      echo -e '\e[32m[9/10] compiling revcomp.f90\e[0m'
      gfortran -pipe -O3 -fomit-frame-pointer -march=ivybridge revcomp.f90 -o revcomp.gfortran_run
      cd ..

      cd spectralnorm
      echo -e '\e[32m[10/10] compiling spectralnorm.f90\e[0m'
      gfortran -O3 -march=ivybridge -fopenmp spectralnorm.f90 -o spectralnorm.gfortran_run
      cd ..

      cd ..
    ;;
    rust)
      sudo apt install rustc -y
      sudo apt install cargo -y

      cd rust

      cd binarytrees
      echo -e '\e[32m[1/10] compiling binarytrees.rs\e[0m'
      RUSTFLAGS="-C opt-level=3 -C target-cpu=ivybridge -C codegen-units=1" cargo build --release > /dev/null
      mv ./target/release/binarytrees .
      rm -r target
      cd ..

      cd fannkuchredux
      echo -e '\e[32m[1/10] compiling fannkuchredux.rs\e[0m'
      RUSTFLAGS="-C opt-level=3 -C target-cpu=ivybridge -C codegen-units=1" cargo build --release > /dev/null
      mv ./target/release/fannkuchredux .
      rm -r target
      cd ..

      cd fasta
      echo -e '\e[32m[3/10] compiling fasta.rs\e[0m'
      RUSTFLAGS="-C opt-level=3 -C target-cpu=ivybridge -C codegen-units=1" cargo build --release > /dev/null
      mv ./target/release/fasta .
      rm -r target
      cd ..

      cd knucleotide
      echo -e '\e[32m[5/10] compiling knucleotide.rs\e[0m'
      RUSTFLAGS="-C opt-level=3 -C target-cpu=ivybridge -C codegen-units=1" cargo build --release > /dev/null
      mv ./target/release/knucleotide .
      rm -r target
      cd ..

      cd mandelbrot
      echo -e '\e[32m[5/10] compiling mandelbrot.rs\e[0m'
      RUSTFLAGS="-C opt-level=3 -C target-cpu=ivybridge -C codegen-units=1" cargo build --release > /dev/null
      mv ./target/release/mandelbrot .
      rm -r target
      cd ..

      cd nbody
      echo -e '\e[32m[6/10] compiling nbody.rs\e[0m'
      RUSTFLAGS="-C opt-level=3 -C target-cpu=ivybridge -C codegen-units=1" cargo build --release > /dev/null
      mv ./target/release/nbody .
      rm -r target
      cd ..

      cd pidigits
      echo -e '\e[32m[7/10] compiling pidigits.rs\e[0m'
      RUSTFLAGS="-C opt-level=3 -C target-cpu=ivybridge -C codegen-units=1" cargo build --release > /dev/null
      mv ./target/release/pidigits .
      rm -r target
      cd ..

      cd regexredux
      echo -e '\e[32m[8/10] compiling regexredux.rs\e[0m'
      RUSTFLAGS="-C opt-level=3 -C target-cpu=ivybridge -C codegen-units=1" cargo build --release > /dev/null
      mv ./target/release/regexredux .
      rm -r target
      cd ..

      cd reversecomplement
      echo -e '\e[32m[9/10] compiling revcomp.rs\e[0m'
      RUSTFLAGS="-C opt-level=3 -C target-cpu=ivybridge -C codegen-units=1" cargo build --release > /dev/null
      mv ./target/release/reversecomplement .
      rm -r target
      cd ..

      cd spectralnorm
      echo -e '\e[32m[10/10] compiling spectralnorm.rs\e[0m'
      RUSTFLAGS="-C opt-level=3 -C target-cpu=ivybridge -C codegen-units=1" cargo build --release > /dev/null
      mv ./target/release/spectralnorm .
      rm -r target
      cd ..

      cd ..
    ;;
    julia)
      curl -sSL https://julialang-s3.julialang.org/bin/linux/x64/1.9/julia-1.9.3-linux-x86_64.tar.gz -o julia.tar.gz
      tar -xvzf julia.tar.gz
      sudo cp -r julia-1.9.3 /opt/
      sudo ln -f -s /opt/julia-1.9.3/bin/julia /usr/local/bin/julia
      sudo rm -r julia-1.9.3
      sudo rm julia.tar.gz
    ;;
    chapel)
      sudo apt install gcc g++ m4 perl python3 python3-dev make mawk pkg-config cmake -y
      sudo apt install llvm-dev llvm clang libclang-dev libclang-cpp-dev libedit-dev libhwloc-dev -y
      curl -sSL https://github.com/chapel-lang/chapel/releases/download/1.29.0/chapel-1.29.0.tar.gz -o chapel-1.29.0.tar.gz
      sudo tar -xvzf chapel-1.29.0.tar.gz -C /opt/
      sudo rm chapel-1.29.0.tar.gz
      sudo make -C /opt/chapel-1.29.0/


      cd chapel

      cd binarytrees
      echo -e '\e[32m[1/10] compiling binarytrees.chpl\e[0m'
      /opt/chapel-1.29.0/bin/linux64-x86_64/chpl --fast binarytrees.chpl -o binarytrees
      cd ..

      cd fannkuchredux
      echo  -e '\e[32m[2/10] compiling fannkuchredux.chpl\e[0m'
      /opt/chapel-1.29.0/bin/linux64-x86_64/chpl --fast fannkuchredux.chpl -o fannkuchredux
      cd ..

      cd fasta
      echo  -e '\e[32m[3/10] compiling fasta.chpl\e[0m'
      /opt/chapel-1.29.0/bin/linux64-x86_64/chpl --fast fasta.chpl -o fasta
      cd ..

      cd knucleotide
      echo  -e '\e[32m[4/10] compiling knucleotide.chpl\e[0m'
      /opt/chapel-1.29.0/bin/linux64-x86_64/chpl --fast knucleotide.chpl -o knucleotide
      cd ..

      cd mandelbrot
      echo  -e '\e[32m[5/10] compiling mandelbrot.chpl\e[0m'
      /opt/chapel-1.29.0/bin/linux64-x86_64/chpl --fast mandelbrot.chpl -o mandelbrot

      cd ..

      cd nbody
      echo  -e '\e[32m[6/10]compiling nbody.chpl\e[0m'
      /opt/chapel-1.29.0/bin/linux64-x86_64/chpl --fast nbody.chpl -o nbody
      cd ..

      cd pidigits
      echo  -e '\e[32m[7/10] compiling pidigits.chpl\e[0m'
      /opt/chapel-1.29.0/bin/linux64-x86_64/chpl --fast pidigits.chpl -o pidigits
      cd ..

      cd regexredux
      echo  -e '\e[32m[8/10] compiling regexredux.chpl\e[0m'
      /opt/chapel-1.29.0/bin/linux64-x86_64/chpl --fast regexredux.chpl -o regexredux
      cd ..

      cd reversecomplement
      echo  -e '\e[32m[9/10] compiling revcomp.chpl\e[0m'
      /opt/chapel-1.29.0/bin/linux64-x86_64/chpl --fast revcomp.chpl -o revcomp
      cd ..

      cd spectralnorm
      echo  -e '\e[32m[10/10] compiling spectralnorm.chpl\e[0m'
      /opt/chapel-1.29.0/bin/linux64-x86_64/chpl --fast spectralnorm.chpl -o spectralnorm
      cd ..

      cd ..
    ;;
      ocaml)
      sudo apt install ocaml -y
      sudo apt install libzarith-ocaml-dev -y
      sudo apt install opam -y
      opam init --shell-setup
      opam update
      opam switch create ocaml -y
      eval $(opam env --switch=ocaml)
      #opam switch ocaml
      opam install zarith -y
      eval $(opam env)
      opam install re -y
      eval $(opam env)

      cd ocaml

      cd binarytrees
      echo -e '\e[32m[1/10] compiling binarytrees.ml\e[0m'
      ocamlopt -noassert -unsafe -fPIC -nodynlink -inline 100 -O3 -I +unix unix.cmxa -ccopt -march=ivybridge binarytrees.ml -o binarytrees
      cd ..

      cd fannkuchredux
      echo  -e '\e[32m[2/10] compiling fannkuchredux.ml\e[0m'
      ocamlopt -noassert -unsafe -fPIC -nodynlink -inline 100 -O3 -I +unix unix.cmxa -ccopt -march=ivybridge fannkuchredux.ml -o fannkuchredux
      cd ..

      cd fasta
      echo  -e '\e[32m[3/10] compiling fasta.chpl\e[0m'
      ocamlopt -noassert -unsafe -fPIC -nodynlink -inline 100 -O3 -I +unix unix.cmxa -ccopt -march=ivybridge fasta.ml -o fasta
      cd ..

      cd knucleotide
      echo  -e '\e[32m[4/10] compiling knucleotide.chpl\e[0m'
      ocamlopt -noassert -unsafe -fPIC -nodynlink -inline 100 -O3 -I +unix unix.cmxa -ccopt -march=ivybridge knucleotide.ml -o knucleotide
      cd ..

      cd mandelbrot
      echo  -e '\e[32m[5/10] compiling mandelbrot.chpl\e[0m'
      ocamlopt -noassert -unsafe -fPIC -nodynlink -inline 100 -O3 -I +unix unix.cmxa -ccopt -march=ivybridge mandelbrot.ml -o mandelbrot

      cd ..

      cd nbody
      echo  -e '\e[32m[6/10]compiling nbody.chpl\e[0m'
      ocamlopt -noassert -unsafe -fPIC -nodynlink -inline 100 -O3  -ccopt -march=ivybridge nbody.ml -o nbody
      cd ..

      cd pidigits
      echo  -e '\e[32m[7/10] compiling pidigits.chpl\e[0m'
      ocamlopt -noassert -unsafe -fPIC -nodynlink -inline 100 -O3 -o pidigits -I +zarith zarith.cmxa pidigits.ml
      cd ..

      cd regexredux
      echo  -e '\e[32m[8/10] compiling regexredux.chpl\e[0m'
      ocamlopt -noassert -unsafe -fPIC -nodynlink -inline 100 -O3 -I +unix -I +str unix.cmxa str.cmxa -ccopt -march=ivybridge regexredux.ml -o regexredux
      cd ..

      cd reversecomplement
      echo  -e '\e[32m[9/10] compiling revcomp.chpl\e[0m'
      ocamlopt -noassert -unsafe -fPIC -nodynlink -inline 100 -O3 -I +unix unix.cmxa -ccopt -march=ivybridge revcomp.ml -o revcomp
      cd ..

      cd spectralnorm
      echo  -e '\e[32m[10/10] compiling spectralnorm.chpl\e[0m'

      cd ..

      cd ..
    ;;
    haskell)
      sudo apt install haskell-platform -y
      sudo apt install llvm -y
      cabal update
      cabal install hashtables --lib
      cabal install vector --lib

      cd haskell

      cd binarytrees
      echo -e '\e[32m[1/10] compiling binarytrees\e[0m'
      ghc --make -fllvm -O2 -XBangPatterns -threaded -rtsopts -fno-cse -package ghc-compact binarytrees.hs -o binarytrees
      cd ..

      cd fannkuchredux
      echo  -e '\e[32m[2/10] compiling fannkuchredux.ml\e[0m'
      ghc --make -fllvm -O2 -XBangPatterns -threaded -rtsopts -XScopedTypeVariables fannkuchredux.hs -o fannkuchredux
      cd ..

      cd fasta
      echo  -e '\e[32m[3/10] compiling fasta.chpl\e[0m'
      ghc --make -fllvm -O2 -XBangPatterns -threaded -rtsopts -XOverloadedStrings fasta.hs -o fasta
      cd ..

      cd knucleotide
      echo  -e '\e[32m[4/10] compiling knucleotide.chpl\e[0m'
      ghc --make -fllvm -O2 -XBangPatterns -threaded -rtsopts -funbox-strict-fields -XBinaryLiterals -XDerivingStrategies -XGeneralizedNewtypeDeriving -XOverloadedStrings -XScopedTypeVariables -XTypeApplications knucleotide.hs -o knucleotide
      cd ..

      cd mandelbrot
      echo  -e '\e[32m[5/10] compiling mandelbrot.chpl\e[0m'
      ghc --make -fllvm -O2 -XBangPatterns -threaded -rtsopts  mandelbrot.hs -o mandelbrot
      cd ..

      cd nbody
      echo  -e '\e[32m[6/10]compiling nbody.chpl\e[0m'
      ghc --make -fllvm -O2 -XBangPatterns -threaded -rtsopts  nbody.hs -o nbody
      cd ..

      cd pidigits
      echo  -e '\e[32m[7/10] compiling pidigits.chpl\e[0m'
      ghc --make -fllvm -O2 -XBangPatterns -threaded -rtsopts -XUnboxedTuples -XUnliftedFFITypes pidigits.hs -o pidigits
      cd ..

      cd regexredux
      echo  -e '\e[32m[8/10] compiling regexredux.chpl\e[0m'
      ghc --make -fllvm -O2 -XBangPatterns -threaded -rtsopts -XForeignFunctionInterface -XCApiFFI -lpcre2-8 -optc "-DPCRE2_CODE_UNIT_WIDTH=8" regexredux.hs -o regexredux
      cd ..

      cd reversecomplement
      echo  -e '\e[32m[9/10] compiling revcomp.chpl\e[0m'
      ghc --make -fllvm -O2 -XBangPatterns -threaded -rtsopts -funfolding-use-threshold=32 -XMagicHash -XUnboxedTuples reversecomplement.hs -o revcomp
      cd ..

      cd spectralnorm
      echo  -e '\e[32m[10/10] compiling spectralnorm.chpl\e[0m'
      ghc --make -fllvm -O2 -XBangPatterns -threaded -rtsopts -XMagicHash spectralnorm.hs -o spectralnorm
      cd ..

      cd ..
    ;;
    erlang)
      sudo apt install erlang -y

      cd erlang

      cd binarytrees
      echo -e '\e[32m[1/10] compiling binarytrees\e[0m'
      erlc binarytrees.erl
      cd ..

      cd fannkuchredux
      echo  -e '\e[32m[2/10] compiling fannkuchredux.ml\e[0m'
      erlc fannkuchredux.erl
      cd ..

      cd fasta
      echo  -e '\e[32m[3/10] compiling fasta.chpl\e[0m'
      erlc fasta.erl
      cd ..

      cd knucleotide
      echo  -e '\e[32m[4/10] compiling knucleotide.chpl\e[0m'
      erlc knucleotide.erl
      cd ..

      cd mandelbrot
      echo  -e '\e[32m[5/10] compiling mandelbrot.chpl\e[0m'
      erlc mandelbrot.erl

      cd ..

      cd nbody
      echo  -e '\e[32m[6/10]compiling nbody.chpl\e[0m'
      erlc nbody.erl
      cd ..

      cd pidigits
      echo  -e '\e[32m[7/10] compiling pidigits.chpl\e[0m'
      erlc pidigits.erl
      cd ..

      cd regexredux
      echo  -e '\e[32m[8/10] compiling regexredux.chpl\e[0m'
      erlc regexredux.erl
      cd ..

      cd reversecomplement
      echo  -e '\e[32m[9/10] compiling revcomp.chpl\e[0m'
      erlc revcomp.erl
      cd ..

      cd spectralnorm
      echo  -e '\e[32m[10/10] compiling spectralnorm.chpl\e[0m'
      erlc spectralnorm.erl
      cd ..

      cd ..
    ;;
    swift)
      curl -s https://archive.swiftlang.xyz/install.sh | sudo bash

      cd swift

      cd binarytrees
      echo -e '\e[32m[1/10] compiling binarytrees\e[0m'
      swiftc binarytrees.swift -Ounchecked  -o binarytrees
      cd ..

      cd fannkuchredux
      echo  -e '\e[32m[2/10] compiling fannkuchredux.ml\e[0m'
      swiftc fannkuchredux.swift -Ounchecked  -o fannkuchredux
      cd ..

      cd fasta
      echo  -e '\e[32m[3/10] compiling fasta.chpl\e[0m'
      swiftc fasta.swift -Ounchecked  -o fasta
      cd ..

      cd knucleotide
      echo  -e '\e[32m[4/10] compiling knucleotide.chpl\e[0m'
      swiftc knucleotide.swift -Ounchecked  -o knucleotide
      cd ..

      cd mandelbrot
      echo  -e '\e[32m[5/10] compiling mandelbrot.chpl\e[0m'
      swiftc mandelbrot.swift -Ounchecked  -o mandelbrot

      cd ..

      cd nbody
      echo  -e '\e[32m[6/10]compiling nbody.chpl\e[0m'
      swiftc nbody.swift -Ounchecked -wmo -o nbody
      cd ..

      cd pidigits
      echo  -e '\e[32m[7/10] compiling pidigits.chpl\e[0m'
      swiftc pidigits.swift -Ounchecked -I Include/swift/gmp -o pidigits  < FALTA COMPILAR
      cd ..

      cd regexredux
      echo  -e '\e[32m[8/10] compiling regexredux.chpl\e[0m'
      swiftc regexredux.swift -Ounchecked  -o regexredux
      cd ..

      cd reversecomplement
      echo  -e '\e[32m[9/10] compiling revcomp.chpl\e[0m'
      swiftc revcomp.swift -Ounchecked  -o revcomp
      cd ..

      cd spectralnorm
      echo  -e '\e[32m[10/10] compiling spectralnorm.chpl\e[0m'
      swiftc spectralnorm.swift -Ounchecked  -o spectralnorm
      cd ..

      cd ..
    ;;
    racket)
      sudo apt install racket -y
    ;;
    ada)
      sudo apt install gnat -y

      cd ada

      cd binarytrees
      echo -e '\e[32m[1/10] compiling binarytrees\e[0m'
      gnatchop -r -w binarytrees.gnat
      gnatmake -O3 -fomit-frame-pointer -march=native -gnatNp -f binarytrees.adb -o binarytrees -largs -lapr-1
      cd ..

      cd fannkuchredux
      echo  -e '\e[32m[2/10] compiling fannkuchredux.ml\e[0m'
      gnatchop -r -w fannkuchredux.gnat
      gnatmake -O3 -fomit-frame-pointer -march=native -gnatNp -f fannkuchredux.adb -o fannkuchredux
      cd ..

      cd fasta
      echo  -e '\e[32m[3/10] compiling fasta.chpl\e[0m'
      gnatchop -r -w fasta.gnat
      gnatmake -O3 -fomit-frame-pointer -march=native -gnatNp -f fasta.adb -o fasta
      cd ..

      cd knucleotide
      echo  -e '\e[32m[4/10] compiling knucleotide.chpl\e[0m'
      gnatchop -r -w knucleotide.gnat
      gnatmake -O3 -fomit-frame-pointer -march=native -gnatNp -f knucleotide.adb -o knucleotide
      cd ..

      cd mandelbrot
      echo  -e '\e[32m[5/10] compiling mandelbrot.chpl\e[0m'
      gnatchop -r -w mandelbrot.gnat
      gnatmake -O3 -fomit-frame-pointer -march=native -gnatNp -f mandelbrot.adb -o mandelbrot

      cd ..

      cd nbody
      echo  -e '\e[32m[6/10]compiling nbody.chpl\e[0m'
      gnatchop -r -w nbody.gnat
      gnatmake -O3 -fomit-frame-pointer -march=native -gnatNp -f nbody.adb -o nbody
      cd ..

      cd pidigits
      echo  -e '\e[32m[7/10] compiling pidigits.chpl\e[0m'
      gnatchop -r -w pidigits.gnat
      gnatmake -O3 -fomit-frame-pointer -march=native -gnatNp -f pidigits.adb -o pidigits
      cd ..

      cd regexredux
      echo  -e '\e[32m[8/10] compiling regexredux.chpl\e[0m'
      gnatchop -r -w regexredux.gnat
      gnatmake -O3 -fomit-frame-pointer -march=native -gnatNp -f regexredux.adb -o regexredux
      cd ..

      cd reversecomplement
      echo  -e '\e[32m[9/10] compiling revcomp.chpl\e[0m'
      gnatchop -r -w revcomp.gnat
      gnatmake -O3 -fomit-frame-pointer -march=native -gnatNp -f revcomp.adb -o revcomp
      cd ..

      cd spectralnorm
      echo  -e '\e[32m[10/10] compiling spectralnorm.chpl\e[0m'
      gnatchop -r -w spectralnorm.gnat
      gnatmake -O3 -fomit-frame-pointer -march=native -gnatNp -f spectralnorm.adb -o spectralnorm
      cd ..

      cd ..
    ;;
    *)
      echo "Linguagem não reconhecida: $lang"
      ;;
  esac
done
