FROM cmssw/el9:x86_64
USER root

RUN yum -y update && \
    yum -y upgrade && \
    yum -y autoremove

RUN yum -y install python3 python3-devel
RUN yum -y install python3-pip
RUN yum -y install cryptopp cryptopp-progs cryptopp-devel
RUN yum -y install gfal2-all

RUN yum -y install boost-python3 boost-python3-devel

RUN pip install pip
RUN pip install wheel
RUN pip install setuptools
RUN pip install libclang
RUN pip install overrides
RUN pip install build
RUN pip install installer
RUN pip install pyproject-hooks
RUN pip install Flask
RUN pip install ordereddict
RUN pip install flake8
RUN pip install luigi==2.8.13
RUN pip install tabulate
RUN pip install git+https://gitlab.cern.ch/cms-phys-ciemat/analysis_tools.git
RUN pip install git+https://gitlab.cern.ch/cms-phys-ciemat/plotting_tools.git
RUN pip install --no-deps git+https://github.com/riga/law
RUN pip install --no-deps git+https://github.com/riga/plotlib
RUN pip install --no-deps git+https://github.com/riga/LBN
RUN pip install --no-deps gast==0.2.2  # https://github.com/tensorflow/autograph/issues/1
RUN pip install sphinx==5.2.2
RUN pip install sphinx_rtd_theme
RUN pip install sphinx_design
RUN pip install urllib3==1.26.6
RUN pip install envyaml

RUN git clone --depth 1 --branch v1.12.2 https://github.com/cern-fts/gfal2-python.git
WORKDIR /gfal2-python/
RUN ./ci/fedora-packages.sh
WORKDIR /gfal2-python/packaging/
RUN RPMBUILD_SRC_EXTRA_FLAGS="--without docs --without python2" make srpm
RUN dnf builddep -y gfal2-python-1.12.2-1.el9.src.rpm
RUN pip install gfal2-python
