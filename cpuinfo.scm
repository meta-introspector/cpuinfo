;;; GNU Guix --- Functional package management for GNU
;;; Copyright © 2013, 2014, 2020 Eric Bavier <bavier@posteo.net>
;;; Copyright © 2015 Mark H Weaver <mhw@netris.org>
;;; Copyright © 2015-2018, 2020-2023 Efraim Flashner <efraim@flashner.co.il>
;;; Copyright © 2016 Pjotr Prins <pjotr.guix@thebird.nl>
;;; Copyright © 2016 Andreas Enge <andreas@enge.fr>
;;; Copyright © 2016, 2020, 2021, 2022, 2023 Ricardo Wurmus <rekado@elephly.net>
;;; Copyright © 2016 Ben Woodcroft <donttrustben@gmail.com>
;;; Copyright © 2017, 2018 Rutger Helling <rhelling@mykolab.com>
;;; Copyright © 2018–2022 Tobias Geerinckx-Rice <me@tobias.gr>
;;; Copyright © 2018 Clément Lassieur <clement@lassieur.org>
;;; Copyright © 2019-2023 Ludovic Courtès <ludo@gnu.org>
;;; Copyright © 2020 Roel Janssen <roel@gnu.org>
;;; Copyright © 2021 Stefan Reichör <stefan@xsteve.at>
;;; Copyright © 2024 Zheng Junjie <873216071@qq.com>
;;;
;;; This file is part of GNU Guix.
;;;
;;; GNU Guix is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; GNU Guix is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Guix.  If not, see <http://www.gnu.org/licenses/>.

(define-module (gnu packages parallel)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system python)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module ((guix utils) #:select (target-64bit?))
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix gexp)
  #:use-module (gnu packages)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages check)
  #:use-module (gnu packages documentation)
  #:use-module (gnu packages flex)
  #:use-module (gnu packages freeipmi)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages mpi)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-science)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages readline)
  #:use-module (gnu packages tcl)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages web))


(define-public cpuinfo
  ;; There's currently no tag on this repo.
  (let ((version "0.0")
        (revision "3")
        (commit "471d8494b91353d3649d1da6672101fa891655c7"))
    (package
      (name "cpuinfo")
      (version (git-version version revision commit))
					;      (home-page "https://github.com/pytorch/cpuinfo")
            (home-page "https://github.com/meta-introspector/cpuinfo")
      (source (origin
                (method git-fetch)
                (uri (git-reference (url home-page) (commit commit)))
                (file-name (git-file-name name version))
		(sha256
                 (base32
		  ;; guix hash -x --serializer=nar .
                  "0c69qismgn7khq6j47g708cfr8fcbr1pmwam1hi61h27nck6994x"
		  ;; "0yv3glj0lgkb8lf80f2m3x0slb7yfy44qvkavn7i36jhv15nr84z"
		  ;; 0i4ag87qgmww6nhxm8hkaf3qdvgahlflhd0m5bdn929j8c0scamm
		  ))
		))
      (build-system cmake-build-system)
      (arguments
       (list
        #:configure-flags '(
     list
     "-DBUILD_SHARED_LIBS=ON"
     "-DUSE_SYSTEM_LIBS=ON"
     "-DUSE_SYSTEM_GOOGLETEST=ON"
     "-DUSE_SYSTEM_GOOGLEBENCHMARK=ON"
     )
;;        #:phases
;;         '(modify-phases %standard-phases
;;            (add-after 'unpack 'skip-bad-test
;;              (lambda _
;;                (substitute* "test/init.cc"
;;                  (("TEST\\(CORE, known_uarch\\) \\{" m)
;;                   (string-append m "\
;; GTEST_SKIP() << \"See https://github.com/pytorch/cpuinfo/issues/132\";"))))))

	))
      (inputs
       (list python python-wrapper googletest googlebenchmark))
      (synopsis "C/C++ library to obtain information about the CPU")
      (description
       "The cpuinfo library provides a C/C++ and a command-line interface to
obtain information about the CPU being used: supported instruction set,
processor name, cache information, and topology information.")
      (license license:bsd-2))))

cpuinfo
