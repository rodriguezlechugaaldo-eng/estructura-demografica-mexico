# ============================================================
# PROYECTO: ESTRUCTURA DEMOGRÁFICA DE MÉXICO
# ============================================================
#
# MÓDULO 01: IMPORTACIÓN, EXPLORACIÓN Y VALIDACIÓN DE DATOS
#
# Fuente:
# Instituto Nacional de Estadística y Geografía (INEGI).
# Censo de Población y Vivienda 2020.
#
# Archivo original: Poblacion_01.xlsx
# Software: R
#
# Objetivo:
# Importar y examinar la estructura de la información
# demográfica de México correspondiente al año 2020.
#
# ============================================================


# ------------------------------------------------------------
# 1. CARGAR PAQUETES
# ------------------------------------------------------------

library(readxl)


# ------------------------------------------------------------
# 2. DEFINIR LA RUTA DEL ARCHIVO
# ------------------------------------------------------------

ruta_datos <- "datos/originales/Poblacion_01.xlsx"


# ------------------------------------------------------------
# 3. VERIFICAR LA EXISTENCIA DEL ARCHIVO
# ------------------------------------------------------------

file.exists(ruta_datos)


# ------------------------------------------------------------
# 4. IDENTIFICAR LAS HOJAS DEL ARCHIVO EXCEL
# ------------------------------------------------------------

excel_sheets(ruta_datos)


# ------------------------------------------------------------
# 5. IMPORTAR LA INFORMACIÓN DEMOGRÁFICA
# ------------------------------------------------------------

# El archivo original contiene encabezados y notas.
# Los datos se encuentran en el intervalo A8:E766.
#
# Se asignan nombres descriptivos a las cinco variables.

poblacion <- read_excel(
  path = ruta_datos,
  sheet = "Tabulado",
  range = "A8:E766",
  col_names = c(
    "entidad",
    "grupo_edad",
    "poblacion_total",
    "hombres",
    "mujeres"
  ),
  col_types = c(
    "text",
    "text",
    "numeric",
    "numeric",
    "numeric"
  )
)


# ------------------------------------------------------------
# 6. EXAMINAR LA ESTRUCTURA DE LA BASE
# ------------------------------------------------------------

# Dimensiones: observaciones y variables

dim(poblacion)


# Nombres de las variables

names(poblacion)


# Estructura de los datos

str(poblacion)


# ------------------------------------------------------------
# 7. EXPLORAR LOS REGISTROS
# ------------------------------------------------------------

# Primeras seis observaciones

head(poblacion)


# Últimas seis observaciones

tail(poblacion)


# ------------------------------------------------------------
# 8. CONTAR OBSERVACIONES Y VARIABLES
# ------------------------------------------------------------

# Número de observaciones agregadas

nrow(poblacion)


# Número de variables

ncol(poblacion)


# ------------------------------------------------------------
# FIN DE LA PRIMERA ETAPA
# ------------------------------------------------------------
# ============================================================
# 9. VALIDACIÓN DE LA ESTRUCTURA DE LA BASE
# ============================================================

# ------------------------------------------------------------
# 9.1. IDENTIFICAR LAS UNIDADES GEOGRÁFICAS
# ------------------------------------------------------------

# Consultar los nombres de las unidades geográficas

unique(poblacion$entidad)


# Contar las unidades geográficas distintas

length(unique(poblacion$entidad))


# ------------------------------------------------------------
# 9.2. IDENTIFICAR LAS CATEGORÍAS DE EDAD
# ------------------------------------------------------------

# Consultar las categorías de edad

unique(poblacion$grupo_edad)


# Contar las categorías distintas

length(unique(poblacion$grupo_edad))


# ------------------------------------------------------------
# 9.3. VERIFICAR LOS REGISTROS POR TERRITORIO
# ------------------------------------------------------------

# Contar las observaciones correspondientes a cada territorio

table(poblacion$entidad)


# Comprobar que todos los territorios tengan 23 registros

all(table(poblacion$entidad) == 23)


# ------------------------------------------------------------
# 9.4. VERIFICAR LOS REGISTROS POR CATEGORÍA DE EDAD
# ------------------------------------------------------------

# Contar los registros de cada categoría de edad

table(poblacion$grupo_edad)


# Comprobar que cada categoría aparezca en 33 territorios

all(table(poblacion$grupo_edad) == 33)


# ------------------------------------------------------------
# 9.5. COMPROBAR LAS DIMENSIONES ESPERADAS
# ------------------------------------------------------------

# Número esperado de registros

33 * 23


# Comparar con el número observado

nrow(poblacion) == (33 * 23)


# ------------------------------------------------------------
# FIN DE LA VALIDACIÓN ESTRUCTURAL INICIAL
# ------------------------------------------------------------
# ============================================================
# 10. IDENTIFICACIÓN DE VALORES FALTANTES Y DUPLICADOS
# ============================================================


# ------------------------------------------------------------
# 10.1. IDENTIFICAR VALORES FALTANTES
# ------------------------------------------------------------

# Contar los valores faltantes de cada variable

colSums(is.na(poblacion))


# Contar el número total de valores faltantes

sum(is.na(poblacion))


# Comprobar que no existen valores faltantes

all(!is.na(poblacion))


# ------------------------------------------------------------
# 10.2. IDENTIFICAR REGISTROS DUPLICADOS
# ------------------------------------------------------------

# Identificar duplicados según entidad y grupo de edad

duplicados <- duplicated(
  poblacion[c("entidad", "grupo_edad")]
)


# Contar registros duplicados

sum(duplicados)


# Comprobar que no existen combinaciones duplicadas

!any(duplicados)


# ------------------------------------------------------------
# 10.3. VERIFICACIÓN GENERAL
# ------------------------------------------------------------

# Comprobar simultáneamente ambas condiciones

validacion_inicial <- all(!is.na(poblacion)) &&
  !any(duplicados)

# Mostrar el resultado

validacion_inicial


# ------------------------------------------------------------
# FIN DE LA VERIFICACIÓN DE FALTANTES Y DUPLICADOS
# ------------------------------------------------------------
# ============================================================
# 11. VALIDACIÓN DE CONSISTENCIA ARITMÉTICA
# ============================================================


# ------------------------------------------------------------
# 11.1. VERIFICAR VALORES NEGATIVOS
# ------------------------------------------------------------

# Seleccionar las variables poblacionales

variables_poblacion <- poblacion[
  c("poblacion_total", "hombres", "mujeres")
]


# Contar valores negativos por variable

colSums(variables_poblacion < 0)


# Comprobar que no existen valores negativos

all(variables_poblacion >= 0)


# ------------------------------------------------------------
# 11.2. COMPROBAR LA CONSISTENCIA POR SEXO
# ------------------------------------------------------------

# Calcular la diferencia entre la población total
# y la suma de hombres y mujeres

diferencia_sexo <- poblacion$poblacion_total -
  (poblacion$hombres + poblacion$mujeres)


# Consultar las primeras diferencias

head(diferencia_sexo)


# ------------------------------------------------------------
# 11.3. IDENTIFICAR INCONSISTENCIAS
# ------------------------------------------------------------

# Contar los registros con diferencias distintas de cero

sum(diferencia_sexo != 0)


# Comprobar que todas las diferencias son iguales a cero

all(diferencia_sexo == 0)


# ------------------------------------------------------------
# 11.4. VERIFICACIÓN GENERAL
# ------------------------------------------------------------

# Comprobar simultáneamente las dos condiciones

validacion_aritmetica <- all(variables_poblacion >= 0) &&
  all(diferencia_sexo == 0)


# Mostrar el resultado

validacion_aritmetica


# ------------------------------------------------------------
# FIN DE LA VALIDACIÓN ARITMÉTICA
# ------------------------------------------------------------
# ============================================================
# 12. VALIDACIÓN DE TOTALES POR GRUPOS DE EDAD
# ============================================================


# ------------------------------------------------------------
# 12.1. IDENTIFICAR LOS REGISTROS DE POBLACIÓN TOTAL
# ------------------------------------------------------------

# Seleccionar los registros correspondientes a "Total"

totales_oficiales <- subset(
  poblacion,
  grupo_edad == "Total",
  select = c(
    "entidad",
    "poblacion_total",
    "hombres",
    "mujeres"
  )
)


# Comprobar el número de territorios

nrow(totales_oficiales)


# ------------------------------------------------------------
# 12.2. SELECCIONAR LOS GRUPOS DE EDAD
# ------------------------------------------------------------

# Excluir las filas correspondientes a "Total"
# Se conserva la categoría "No especificado"

grupos_edad <- subset(
  poblacion,
  grupo_edad != "Total"
)


# Comprobar el número de registros

nrow(grupos_edad)


# ------------------------------------------------------------
# 12.3. SUMAR LA POBLACIÓN POR TERRITORIO
# ------------------------------------------------------------

# Calcular las sumas de las categorías de edad
# para población total, hombres y mujeres

sumas_edad <- aggregate(
  cbind(poblacion_total, hombres, mujeres) ~ entidad,
  data = grupos_edad,
  FUN = sum
)


# Examinar los resultados

head(sumas_edad)


# ------------------------------------------------------------
# 12.4. COMPARAR CON LOS TOTALES OFICIALES
# ------------------------------------------------------------

# Integrar las sumas calculadas y los totales publicados

comparacion_totales <- merge(
  sumas_edad,
  totales_oficiales,
  by = "entidad",
  suffixes = c("_calculado", "_oficial")
)


# Comprobar las dimensiones

dim(comparacion_totales)


# ------------------------------------------------------------
# 12.5. CALCULAR LAS DIFERENCIAS
# ------------------------------------------------------------

# Diferencia en la población total

comparacion_totales$diferencia_total <-
  comparacion_totales$poblacion_total_calculado -
  comparacion_totales$poblacion_total_oficial


# Diferencia en la población masculina

comparacion_totales$diferencia_hombres <-
  comparacion_totales$hombres_calculado -
  comparacion_totales$hombres_oficial


# Diferencia en la población femenina

comparacion_totales$diferencia_mujeres <-
  comparacion_totales$mujeres_calculado -
  comparacion_totales$mujeres_oficial


# ------------------------------------------------------------
# 12.6. IDENTIFICAR INCONSISTENCIAS
# ------------------------------------------------------------

# Contar territorios con diferencias en población total

sum(comparacion_totales$diferencia_total != 0)


# Contar territorios con diferencias en hombres

sum(comparacion_totales$diferencia_hombres != 0)


# Contar territorios con diferencias en mujeres

sum(comparacion_totales$diferencia_mujeres != 0)


# ------------------------------------------------------------
# 12.7. VALIDACIÓN GENERAL
# ------------------------------------------------------------

# Comprobar que existen los 33 territorios esperados
# y que todas las diferencias son iguales a cero

validacion_totales <- (
  nrow(comparacion_totales) == 33 &&
    all(comparacion_totales$diferencia_total == 0) &&
    all(comparacion_totales$diferencia_hombres == 0) &&
    all(comparacion_totales$diferencia_mujeres == 0)
)


# Mostrar el resultado

validacion_totales


# ------------------------------------------------------------
# FIN DE LA VALIDACIÓN DE TOTALES POR EDAD
# ------------------------------------------------------------
# ============================================================
# 13. VALIDACIÓN DE LA POBLACIÓN NACIONAL
# ============================================================


# ------------------------------------------------------------
# 13.1. IDENTIFICAR EL AGREGADO NACIONAL
# ------------------------------------------------------------

# Seleccionar el registro de Estados Unidos Mexicanos

registro_nacional <- subset(
  totales_oficiales,
  entidad == "Estados Unidos Mexicanos"
)


# Comprobar que existe un único registro nacional

nrow(registro_nacional)


# ------------------------------------------------------------
# 13.2. IDENTIFICAR LAS ENTIDADES FEDERATIVAS
# ------------------------------------------------------------

# Excluir el agregado nacional

registros_entidades <- subset(
  totales_oficiales,
  entidad != "Estados Unidos Mexicanos"
)


# Comprobar el número de entidades federativas

nrow(registros_entidades)


# ------------------------------------------------------------
# 13.3. COMPROBAR LA COBERTURA TERRITORIAL
# ------------------------------------------------------------

# Verificar que existe un registro nacional
# y exactamente 32 registros de entidades federativas

if (
  nrow(registro_nacional) != 1 ||
  nrow(registros_entidades) != 32
) {
  stop("Error: la cobertura territorial no es la esperada.")
}


# ------------------------------------------------------------
# 13.4. SUMAR LA POBLACIÓN DE LAS 32 ENTIDADES
# ------------------------------------------------------------

# Seleccionar las variables poblacionales

variables_nacionales <- c(
  "poblacion_total",
  "hombres",
  "mujeres"
)


# Sumar los valores de las entidades federativas

suma_entidades <- colSums(
  registros_entidades[variables_nacionales]
)


# Mostrar los resultados

suma_entidades


# ------------------------------------------------------------
# 13.5. OBTENER LOS TOTALES NACIONALES PUBLICADOS
# ------------------------------------------------------------

# Extraer los valores del agregado nacional

total_nacional <- unlist(
  registro_nacional[1, variables_nacionales],
  use.names = FALSE
)


# Asignar nombres a los resultados

names(total_nacional) <- variables_nacionales


# Mostrar los totales publicados

total_nacional


# ------------------------------------------------------------
# 13.6. CALCULAR LAS DIFERENCIAS
# ------------------------------------------------------------

# Comparar la suma de las entidades
# con los valores nacionales publicados

diferencias_nacionales <- suma_entidades -
  total_nacional


# Mostrar las diferencias

diferencias_nacionales


# ------------------------------------------------------------
# 13.7. IDENTIFICAR INCONSISTENCIAS
# ------------------------------------------------------------

# Contar las variables con diferencias distintas de cero

sum(diferencias_nacionales != 0)


# Comprobar que todas las diferencias sean cero

all(diferencias_nacionales == 0)


# ------------------------------------------------------------
# 13.8. VALIDACIÓN GENERAL
# ------------------------------------------------------------

# Verificar que la cobertura territorial sea correcta
# y que las diferencias sean iguales a cero

validacion_nacional <- (
  nrow(registro_nacional) == 1 &&
    nrow(registros_entidades) == 32 &&
    all(diferencias_nacionales == 0)
)


# Mostrar el resultado general

validacion_nacional


# ------------------------------------------------------------
# FIN DE LA VALIDACIÓN DE LA POBLACIÓN NACIONAL
# ------------------------------------------------------------
# ============================================================
# 14. VALIDACIÓN NACIONAL POR GRUPOS DE EDAD
# ============================================================


# ------------------------------------------------------------
# 14.1. SELECCIONAR LOS REGISTROS ESTATALES
# ------------------------------------------------------------

# Excluir el agregado nacional y la categoría Total

edades_estatales <- subset(
  poblacion,
  entidad != "Estados Unidos Mexicanos" &
    grupo_edad != "Total"
)

# Consultar el número de registros

nrow(edades_estatales)


# ------------------------------------------------------------
# 14.2. SELECCIONAR LOS REGISTROS NACIONALES
# ------------------------------------------------------------

# Conservar las categorías de edad del agregado nacional

edades_nacionales <- subset(
  poblacion,
  entidad == "Estados Unidos Mexicanos" &
    grupo_edad != "Total"
)

# Consultar el número de categorías

nrow(edades_nacionales)


# ------------------------------------------------------------
# 14.3. SUMAR LA POBLACIÓN ESTATAL POR GRUPO DE EDAD
# ------------------------------------------------------------

sumas_edades_estatales <- aggregate(
  cbind(poblacion_total, hombres, mujeres) ~ grupo_edad,
  data = edades_estatales,
  FUN = sum
)

# Examinar los resultados

head(sumas_edades_estatales)


# ------------------------------------------------------------
# 14.4. COMPARAR CON LOS RESULTADOS NACIONALES
# ------------------------------------------------------------

comparacion_edades <- merge(
  sumas_edades_estatales,
  edades_nacionales[
    c("grupo_edad", "poblacion_total", "hombres", "mujeres")
  ],
  by = "grupo_edad",
  all = TRUE,
  suffixes = c("_calculado", "_oficial")
)

# Consultar las dimensiones

dim(comparacion_edades)


# ------------------------------------------------------------
# 14.5. VERIFICAR LA INTEGRIDAD DE LA COMPARACIÓN
# ------------------------------------------------------------

# Comprobar que existen 22 categorías comparables
# y que ninguna presenta datos faltantes

integridad_comparacion <- (
  nrow(comparacion_edades) == 22 &&
    !anyNA(comparacion_edades) &&
    all(table(edades_estatales$grupo_edad) == 32)
)

integridad_comparacion

# Detener la ejecución si falta alguna categoría

if (!integridad_comparacion) {
  stop("Error: existen problemas en la comparación por edad.")
}


# ------------------------------------------------------------
# 14.6. CALCULAR LAS DIFERENCIAS
# ------------------------------------------------------------

# Diferencias en población total

comparacion_edades$diferencia_total <-
  comparacion_edades$poblacion_total_calculado -
  comparacion_edades$poblacion_total_oficial


# Diferencias en hombres

comparacion_edades$diferencia_hombres <-
  comparacion_edades$hombres_calculado -
  comparacion_edades$hombres_oficial


# Diferencias en mujeres

comparacion_edades$diferencia_mujeres <-
  comparacion_edades$mujeres_calculado -
  comparacion_edades$mujeres_oficial


# ------------------------------------------------------------
# 14.7. CONTAR LAS INCONSISTENCIAS
# ------------------------------------------------------------

# Número de categorías con diferencias en población total

sum(comparacion_edades$diferencia_total != 0)


# Número de categorías con diferencias en hombres

sum(comparacion_edades$diferencia_hombres != 0)


# Número de categorías con diferencias en mujeres

sum(comparacion_edades$diferencia_mujeres != 0)


# ------------------------------------------------------------
# 14.8. VALIDACIÓN GENERAL
# ------------------------------------------------------------

validacion_edades_nacionales <- (
  integridad_comparacion &&
    all(comparacion_edades$diferencia_total == 0) &&
    all(comparacion_edades$diferencia_hombres == 0) &&
    all(comparacion_edades$diferencia_mujeres == 0)
)

# Mostrar el resultado

validacion_edades_nacionales


# ------------------------------------------------------------
# FIN DE LA VALIDACIÓN NACIONAL POR GRUPOS DE EDAD
# ------------------------------------------------------------
# ============================================================
# 15. VALIDACIÓN FINAL Y EXPORTACIÓN DE DATOS
# ============================================================


# ------------------------------------------------------------
# 15.1. COMPROBAR LA ESTRUCTURA GENERAL
# ------------------------------------------------------------

# Verificar dimensiones, territorios y categorías de edad

validacion_estructura <- (
  nrow(poblacion) == 759 &&
    ncol(poblacion) == 5 &&
    length(unique(poblacion$entidad)) == 33 &&
    length(unique(poblacion$grupo_edad)) == 23 &&
    all(table(poblacion$entidad) == 23) &&
    all(table(poblacion$grupo_edad) == 33)
)

# Mostrar resultado

validacion_estructura


# ------------------------------------------------------------
# 15.2. INTEGRAR LAS VALIDACIONES
# ------------------------------------------------------------

# Reunir las comprobaciones realizadas anteriormente

comprobaciones_finales <- c(
  estructura = validacion_estructura,
  integridad = validacion_inicial,
  aritmetica = validacion_aritmetica,
  totales_edad = validacion_totales,
  totales_nacionales = validacion_nacional,
  edades_nacionales = validacion_edades_nacionales
)

# Mostrar el resultado de cada comprobación

print(comprobaciones_finales)


# ------------------------------------------------------------
# 15.3. COMPROBAR LA VALIDACIÓN GENERAL
# ------------------------------------------------------------

# Todas las condiciones deben ser verdaderas

validacion_final <- all(comprobaciones_finales)

# Mostrar resultado

validacion_final


# ------------------------------------------------------------
# 15.4. DETENER LA EJECUCIÓN SI EXISTEN ERRORES
# ------------------------------------------------------------

if (!validacion_final) {
  
  stop(
    "Error: la base no cumple todas las validaciones."
  )
  
}


# ------------------------------------------------------------
# 15.5. PREPARAR LA CARPETA DE DATOS PROCESADOS
# ------------------------------------------------------------

# Crear la carpeta si todavía no existe

dir.create(
  "datos/procesados",
  recursive = TRUE,
  showWarnings = FALSE
)


# ------------------------------------------------------------
# 15.6. EXPORTAR LA BASE EN FORMATO RDS
# ------------------------------------------------------------

# Conservar la estructura original de los objetos de R

saveRDS(
  poblacion,
  file = "datos/procesados/poblacion_mexico_2020_validada.rds"
)


# ------------------------------------------------------------
# 15.7. EXPORTAR LA BASE EN FORMATO CSV
# ------------------------------------------------------------

# Generar un archivo interoperable con otros programas

write.csv(
  poblacion,
  file = "datos/procesados/poblacion_mexico_2020_validada.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)


# ------------------------------------------------------------
# 15.8. VERIFICAR LOS ARCHIVOS EXPORTADOS
# ------------------------------------------------------------

# Consultar los archivos generados

list.files("datos/procesados")


# Comprobar la existencia del archivo RDS

file.exists(
  "datos/procesados/poblacion_mexico_2020_validada.rds"
)


# Comprobar la existencia del archivo CSV

file.exists(
  "datos/procesados/poblacion_mexico_2020_validada.csv"
)


# ------------------------------------------------------------
# 15.9. VERIFICAR LA INTEGRIDAD DEL ARCHIVO RDS
# ------------------------------------------------------------

# Importar nuevamente el archivo RDS

poblacion_verificada <- readRDS(
  "datos/procesados/poblacion_mexico_2020_validada.rds"
)

# Comparar la base exportada con la base original en memoria

identical(
  poblacion,
  poblacion_verificada
)


# ------------------------------------------------------------
# FIN DE LA VALIDACIÓN FINAL Y EXPORTACIÓN
# ------------------------------------------------------------
# ============================================================
# 16. COMPROBACIÓN FINAL DE REPRODUCIBILIDAD
# ============================================================

# ------------------------------------------------------------
# 16.1. VERIFICAR LOS RESULTADOS DEL MÓDULO 01
# ------------------------------------------------------------

# Comprobar la validación general y los archivos exportados

resultados_reproduccion <- c(
  
  validacion_final = isTRUE(validacion_final),
  
  archivo_csv = file.exists(
    "datos/procesados/poblacion_mexico_2020_validada.csv"
  ),
  
  archivo_rds = file.exists(
    "datos/procesados/poblacion_mexico_2020_validada.rds"
  ),
  
  integridad_rds = identical(
    poblacion,
    readRDS(
      "datos/procesados/poblacion_mexico_2020_validada.rds"
    )
  )
  
)

# ------------------------------------------------------------
# 16.2. MOSTRAR LOS RESULTADOS
# ------------------------------------------------------------

print(resultados_reproduccion)


# ------------------------------------------------------------
# 16.3. COMPROBAR LA REPRODUCIBILIDAD GENERAL
# ------------------------------------------------------------

reproduccion_correcta <- all(resultados_reproduccion)

print(reproduccion_correcta)


# ------------------------------------------------------------
# 16.4. DETENER LA EJECUCIÓN ANTE INCONSISTENCIAS
# ------------------------------------------------------------

if (!reproduccion_correcta) {
  stop("Error: no se superó la comprobación de reproducibilidad.")
}


# ------------------------------------------------------------
# FIN DEL MÓDULO 01
# ------------------------------------------------------------