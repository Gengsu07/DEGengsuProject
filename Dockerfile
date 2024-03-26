FROM mageai/mageai:alpha

ARG USER_CODE_PATH=/home/src/${PROJECT_NAME}

# Note: this overwrites the requirements.txt file in your new project on first run. 
# You can delete this line for the second run :) 

# RUN pip install playwright==1.42.0 && \
#     playwright install --with-deps

COPY rawg.py ${USER_CODE_PATH}/data_loaders/rawg.py
COPY .dlt ${USER_CODE_PATH}/data_loaders
COPY requirements.txt ${USER_CODE_PATH}requirements.txt 

RUN pip3 install -r ${USER_CODE_PATH}requirements.txt
