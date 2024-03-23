FROM jupyter/datascience-notebook:x86_64-ubuntu-22.04

USER root

# 必要なライブラリのインストール
## slycotの依存ライブラリ
RUN apt-get -y update
RUN apt-get -yV upgrade
RUN apt-get -y install build-essential gcc g++ make libtool texinfo dpkg-dev pkg-config
RUN apt-get -y update
RUN apt-get -y install gfortran
RUN apt-get install -y cmake
RUN apt-get install -y libopenblas-base
RUN apt-get install -y libopenblas-dev

## 可視化
RUN apt-get install -y graphviz

RUN pip install --upgrade ipython beautifulsoup4 lxml html5lib seaborn jupytext
RUN pip install numpy jax jaxlib numpyro blackjax matplotlib pandas pyro-ppl japanize-matplotlib seaborn optax orbax-checkpoint flax scikit-build
RUN pip install --upgrade sympy slycot control
RUN pip install graphviz pydotplus

RUN julia -e 'using Pkg; Pkg.add("PackageCompiler")'
RUN julia -e 'using Pkg; Pkg.add(["Plots", "DataFrames", "CSV"])'
RUN julia -e 'using Pkg; Pkg.add(["Test", "StatsPlots", "Statistics"])'
RUN julia -e 'using Pkg; Pkg.add(["LaTeXStrings"])'
RUN julia -e 'using Pkg; Pkg.add(["FreqTables", "NamedArrays", "Distributions"])'
RUN julia -e 'using Pkg; Pkg.add(["Flux", "Convex", "SCS"])'

# 背景設定を追加
RUN mkdir -p /home/jovyan/.jupyter/lab/user-settings/@jupyterlab/apputils-extension
RUN echo '{"theme":"JupyterLab Dark"}' > \
  /home/jovyan/.jupyter/lab/user-settings/@jupyterlab/apputils-extension/themes.jupyterlab-settings

USER jovyan
WORKDIR /home/jovyan
