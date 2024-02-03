FROM jupyter/datascience-notebook:x86_64-ubuntu-22.04

USER root

# 必要なライブラリのインストール
RUN pip install --upgrade ipython beautifulsoup4 lxml html5lib seaborn jupytext
RUN pip install numpy jax jaxlib numpyro blackjax matplotlib pandas pyro-ppl japanize-matplotlib seaborn optax orbax-checkpoint flax

RUN julia -e 'using Pkg; Pkg.add("PackageCompiler")'
RUN julia -e 'using Pkg; Pkg.add(["Plots", "DataFrames", "CSV"])'
RUN julia -e 'using Pkg; Pkg.add(["Test", "StatsPlots", "Statistics"])'
RUN julia -e 'using Pkg; Pkg.add(["LaTeXStrings"])'
RUN julia -e 'using Pkg; Pkg.add(["FreqTables", "NamedArrays", "Distributions"])'
RUN julia -e 'using Pkg; Pkg.add("Flux")'

# 背景設定を追加
RUN mkdir -p /home/jovyan/.jupyter/lab/user-settings/@jupyterlab/apputils-extension
RUN echo '{"theme":"JupyterLab Dark"}' > \
  /home/jovyan/.jupyter/lab/user-settings/@jupyterlab/apputils-extension/themes.jupyterlab-settings

USER jovyan
WORKDIR /home/jovyan
