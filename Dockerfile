FROM continuumio/miniconda3:latest

WORKDIR /app

# Install myapp requirements
COPY environment.yml /app/environment.yml
RUN conda config --add channels conda-forge \
    && conda env create -n myapp -f environment.yml \
    && rm -rf /opt/conda/pkgs/*

# Copy all files after to avoid rebuild the conda env each time
COPY . /app/

# activate the myapp environment
ENV PATH /opt/conda/envs/myapp/bin:$PATH

# Launch the API
CMD ["bash", "-c", "source activate flask_env"]

RUN pip install -r requirements.txt

RUN conda install nomkl

EXPOSE 5000

CMD ["bash", "-c", "python web.py"]

