#!/bin/bash


mage start GengsuDEZoomcamp

sleep 5
echo "WAIT ...."

mage run GengsuDEZoomcamp rawg_extract_postgres
echo "Running rawg_extract_postgres"

