# ============================================================
# PROYECTO: ESTRUCTURA DEMOGRÁFICA DE MÉXICO
# MÓDULO 02: DISTRIBUCIONES DE FRECUENCIAS
# Fuente: INEGI, Censo de Población y Vivienda 2020
# ============================================================


# ------------------------------------------------------------
# 1. IMPORTAR LA BASE VALIDADA
# ------------------------------------------------------------

ruta_datos <- "datos/procesados/poblacion_mexico_2020_validada.rds"

stopifnot(file.exists(ruta_datos))

poblacion <- readRDS(ruta_datos)


# ------------------------------------------------------------
# 2. VERIFICAR LA ESTRUCTURA DE LOS DATOS
# ------------------------------------------------------------

print(dim(poblacion))

stopifnot(
  nrow(poblacion) == 759,
  ncol(poblacion) == 5
)


# ------------------------------------------------------------
# 3. IDENTIFICAR LA POBLACIÓN NACIONAL
# ------------------------------------------------------------

poblacion_nacional <- subset(
  poblacion,
  entidad == "Estados Unidos Mexicanos" &
    grupo_edad == "Total"
)

stopifnot(nrow(poblacion_nacional) == 1)

print(poblacion_nacional)
# ============================================================
# 4. DISTRIBUCIÓN DE FRECUENCIAS POR SEXO
# ============================================================


# ------------------------------------------------------------
# 4.1. IDENTIFICAR LOS RECUENTOS POBLACIONALES
# ------------------------------------------------------------

# Población total

N <- poblacion_nacional$poblacion_total


# Frecuencias absolutas por sexo

frecuencias_absolutas <- c(
  poblacion_nacional$hombres,
  poblacion_nacional$mujeres
)


# Verificar los recuentos poblacionales

stopifnot(
  N > 0,
  all(frecuencias_absolutas >= 0),
  sum(frecuencias_absolutas) == N
)


# ------------------------------------------------------------
# 4.2. CALCULAR LAS FRECUENCIAS RELATIVAS
# ------------------------------------------------------------

frecuencias_relativas <- frecuencias_absolutas / N

print(frecuencias_relativas)


# ------------------------------------------------------------
# 4.3. CALCULAR LAS FRECUENCIAS PORCENTUALES
# ------------------------------------------------------------

frecuencias_porcentuales <- frecuencias_relativas * 100

print(frecuencias_porcentuales)


# ------------------------------------------------------------
# 4.4. CONSTRUIR LA TABLA DE FRECUENCIAS
# ------------------------------------------------------------

tabla_sexo <- data.frame(
  sexo = c("Hombres", "Mujeres"),
  frecuencia_absoluta = frecuencias_absolutas,
  frecuencia_relativa = frecuencias_relativas,
  frecuencia_porcentual = frecuencias_porcentuales
)

print(tabla_sexo)


# ------------------------------------------------------------
# 4.5. VALIDAR LA DISTRIBUCIÓN DE FRECUENCIAS
# ------------------------------------------------------------

validacion_frecuencias_sexo <- c(
  absoluta = sum(frecuencias_absolutas) == N,
  relativa = abs(sum(frecuencias_relativas) - 1) < 1e-10,
  porcentual = abs(sum(frecuencias_porcentuales) - 100) < 1e-10
)

print(validacion_frecuencias_sexo)

stopifnot(all(validacion_frecuencias_sexo))


# ------------------------------------------------------------
# 4.6. INCORPORAR LA FILA DE TOTALES
# ------------------------------------------------------------

tabla_sexo <- rbind(
  tabla_sexo,
  data.frame(
    sexo = "Total",
    frecuencia_absoluta = sum(frecuencias_absolutas),
    frecuencia_relativa = sum(frecuencias_relativas),
    frecuencia_porcentual = sum(frecuencias_porcentuales)
  )
)


# ------------------------------------------------------------
# 4.7. PRESENTAR LOS RESULTADOS CON CUATRO DECIMALES
# ------------------------------------------------------------

tabla_sexo_presentacion <- tabla_sexo

tabla_sexo_presentacion$frecuencia_relativa <- sprintf(
  "%.4f",
  tabla_sexo$frecuencia_relativa
)

tabla_sexo_presentacion$frecuencia_porcentual <- sprintf(
  "%.4f",
  tabla_sexo$frecuencia_porcentual
)

print(tabla_sexo_presentacion, row.names = FALSE)


# ------------------------------------------------------------
# FIN DE LA DISTRIBUCIÓN DE FRECUENCIAS POR SEXO
# ------------------------------------------------------------
# ============================================================
# 5. DISTRIBUCIÓN DE FRECUENCIAS POR GRUPOS DE EDAD
# ============================================================


# ------------------------------------------------------------
# 5.1. SELECCIONAR LA POBLACIÓN NACIONAL POR EDAD
# ------------------------------------------------------------

poblacion_edad <- subset(
  poblacion,
  entidad == "Estados Unidos Mexicanos" &
    grupo_edad != "Total"
)

print(nrow(poblacion_edad))


# ------------------------------------------------------------
# 5.2. IDENTIFICAR LA EDAD NO ESPECIFICADA
# ------------------------------------------------------------

edad_no_especificada <- subset(
  poblacion_edad,
  grupo_edad == "No especificado"
)

print(edad_no_especificada)

stopifnot(nrow(edad_no_especificada) == 1)

N_no_especificada <- edad_no_especificada$poblacion_total


# Calcular su porcentaje respecto de la población nacional

porcentaje_no_especificado <- (
  N_no_especificada / N
) * 100

print(porcentaje_no_especificado)


# ------------------------------------------------------------
# 5.3. SELECCIONAR LA POBLACIÓN CON EDAD ESPECIFICADA
# ------------------------------------------------------------

edad_especificada <- subset(
  poblacion_edad,
  grupo_edad != "No especificado"
)

N_edad <- sum(edad_especificada$poblacion_total)

print(N_edad)


# Verificar la consistencia de los denominadores

stopifnot(
  nrow(edad_especificada) == 21,
  N_edad > 0,
  N_edad + N_no_especificada == N
)


# ------------------------------------------------------------
# 5.4. ORDENAR LOS GRUPOS DE EDAD
# ------------------------------------------------------------

# Establecer los intervalos en orden ascendente

orden_edades <- c(
  sprintf(
    "%d a %d años",
    seq(0, 95, by = 5),
    seq(4, 99, by = 5)
  ),
  "100 años y más"
)


# Verificar que las categorías sean las esperadas

stopifnot(
  setequal(edad_especificada$grupo_edad, orden_edades),
  !anyDuplicated(edad_especificada$grupo_edad)
)


# Ordenar los registros

edad_especificada <- edad_especificada[
  match(orden_edades, edad_especificada$grupo_edad),
]

print(edad_especificada)


# ------------------------------------------------------------
# 5.5. CONSTRUIR LA TABLA DE FRECUENCIAS
# ------------------------------------------------------------

tabla_edad <- data.frame(
  grupo_edad = edad_especificada$grupo_edad,
  frecuencia_absoluta = edad_especificada$poblacion_total
)


# Frecuencia relativa

tabla_edad$frecuencia_relativa <-
  tabla_edad$frecuencia_absoluta / N_edad


# Frecuencia porcentual

tabla_edad$frecuencia_porcentual <-
  tabla_edad$frecuencia_relativa * 100


# ------------------------------------------------------------
# 5.6. CALCULAR LAS FRECUENCIAS ACUMULADAS
# ------------------------------------------------------------

# Frecuencia absoluta acumulada

tabla_edad$frecuencia_absoluta_acumulada <-
  cumsum(tabla_edad$frecuencia_absoluta)


# Frecuencia relativa acumulada

tabla_edad$frecuencia_relativa_acumulada <-
  tabla_edad$frecuencia_absoluta_acumulada / N_edad


# Frecuencia porcentual acumulada

tabla_edad$frecuencia_porcentual_acumulada <-
  tabla_edad$frecuencia_relativa_acumulada * 100


# ------------------------------------------------------------
# 5.7. VALIDAR LAS FRECUENCIAS
# ------------------------------------------------------------

validacion_frecuencias_edad <- c(

  absoluta = sum(
    tabla_edad$frecuencia_absoluta
  ) == N_edad,

  relativa = abs(
    sum(tabla_edad$frecuencia_relativa) - 1
  ) < 1e-10,

  porcentual = abs(
    sum(tabla_edad$frecuencia_porcentual) - 100
  ) < 1e-10,

  absoluta_acumulada = tail(
    tabla_edad$frecuencia_absoluta_acumulada, 1
  ) == N_edad,

  relativa_acumulada = abs(
    tail(tabla_edad$frecuencia_relativa_acumulada, 1) - 1
  ) < 1e-10,

  porcentual_acumulada = abs(
    tail(tabla_edad$frecuencia_porcentual_acumulada, 1) - 100
  ) < 1e-10

)

print(validacion_frecuencias_edad)

stopifnot(all(validacion_frecuencias_edad))


# ------------------------------------------------------------
# 5.8. PRESENTAR LOS RESULTADOS CON CUATRO DECIMALES
# ------------------------------------------------------------

tabla_edad_presentacion <- tabla_edad

columnas_decimales <- c(
  "frecuencia_relativa",
  "frecuencia_porcentual",
  "frecuencia_relativa_acumulada",
  "frecuencia_porcentual_acumulada"
)

tabla_edad_presentacion[columnas_decimales] <- lapply(
  tabla_edad[columnas_decimales],
  function(x) sprintf("%.4f", x)
)


# Mostrar la tabla completa

print(tabla_edad_presentacion, row.names = FALSE)


# ------------------------------------------------------------
# FIN DE LA DISTRIBUCIÓN DE FRECUENCIAS POR EDAD
# ------------------------------------------------------------
# ============================================================
# 6. DISTRIBUCIÓN CONJUNTA DE FRECUENCIAS POR EDAD Y SEXO
# ============================================================


# ------------------------------------------------------------
# 6.1. SELECCIONAR LOS REGISTROS NACIONALES
# ------------------------------------------------------------

# Excluir la categoría Total y conservar No especificado

edad_sexo <- subset(
  poblacion,
  entidad == "Estados Unidos Mexicanos" &
    grupo_edad != "Total"
)


# Establecer el orden de las categorías

orden_edad_sexo <- c(
  orden_edades,
  "No especificado"
)


# Verificar las categorías

stopifnot(
  nrow(edad_sexo) == 22,
  !anyDuplicated(edad_sexo$grupo_edad),
  setequal(
    edad_sexo$grupo_edad,
    orden_edad_sexo
  )
)


# Ordenar los registros

edad_sexo <- edad_sexo[
  match(
    orden_edad_sexo,
    edad_sexo$grupo_edad
  ),
]


# ------------------------------------------------------------
# 6.2. FRECUENCIAS ABSOLUTAS CONJUNTAS
# ------------------------------------------------------------

# Construir una matriz de frecuencias observadas

frecuencias_absolutas_edad_sexo <- as.matrix(
  edad_sexo[c("hombres", "mujeres")]
)


# Asignar nombres a las filas

rownames(frecuencias_absolutas_edad_sexo) <-
  edad_sexo$grupo_edad


# Asignar nombres a las columnas

colnames(frecuencias_absolutas_edad_sexo) <-
  c("Hombres", "Mujeres")


# Mostrar las frecuencias absolutas

print(frecuencias_absolutas_edad_sexo)


# ------------------------------------------------------------
# 6.3. DISTRIBUCIONES MARGINALES
# ------------------------------------------------------------

# Incorporar los totales por filas y columnas

tabla_absoluta_edad_sexo <- addmargins(
  frecuencias_absolutas_edad_sexo
)


# Cambiar el nombre de los totales

rownames(tabla_absoluta_edad_sexo)[23] <- "Total"

colnames(tabla_absoluta_edad_sexo)[3] <- "Total"


# Mostrar la tabla de frecuencias absolutas

print(tabla_absoluta_edad_sexo)


# ------------------------------------------------------------
# 6.4. FRECUENCIAS RELATIVAS CONJUNTAS
# ------------------------------------------------------------

# Calcular las proporciones respecto a la población nacional

frecuencias_relativas_edad_sexo <- prop.table(
  frecuencias_absolutas_edad_sexo
)


# Incorporar las frecuencias marginales

tabla_relativa_edad_sexo <- addmargins(
  frecuencias_relativas_edad_sexo
)


# Asignar nombres a los totales

rownames(tabla_relativa_edad_sexo)[23] <- "Total"

colnames(tabla_relativa_edad_sexo)[3] <- "Total"


# Mostrar resultados

print(round(tabla_relativa_edad_sexo, 4))


# ------------------------------------------------------------
# 6.5. FRECUENCIAS PORCENTUALES CONJUNTAS
# ------------------------------------------------------------

# Convertir las proporciones en porcentajes

tabla_porcentual_edad_sexo <-
  tabla_relativa_edad_sexo * 100


# Mostrar resultados con cuatro decimales

print(round(tabla_porcentual_edad_sexo, 4))


# ------------------------------------------------------------
# 6.6. VALIDACIÓN ESTADÍSTICA
# ------------------------------------------------------------

validacion_edad_sexo <- c(

  dimensiones = all(
    dim(frecuencias_absolutas_edad_sexo) == c(22, 2)
  ),

  integridad = (
    !anyNA(frecuencias_absolutas_edad_sexo) &&
      all(frecuencias_absolutas_edad_sexo >= 0)
  ),

  total_nacional = (
    sum(frecuencias_absolutas_edad_sexo) ==
      poblacion_nacional$poblacion_total
  ),

  total_hombres = (
    sum(frecuencias_absolutas_edad_sexo[, "Hombres"]) ==
      poblacion_nacional$hombres
  ),

  total_mujeres = (
    sum(frecuencias_absolutas_edad_sexo[, "Mujeres"]) ==
      poblacion_nacional$mujeres
  ),

  totales_edad = all(
    rowSums(frecuencias_absolutas_edad_sexo) ==
      edad_sexo$poblacion_total
  ),

  frecuencia_relativa = isTRUE(
    all.equal(
      sum(frecuencias_relativas_edad_sexo),
      1
    )
  ),

  frecuencia_porcentual = isTRUE(
    all.equal(
      sum(frecuencias_relativas_edad_sexo * 100),
      100
    )
  )

)


# Mostrar las validaciones

print(validacion_edad_sexo)


# Detener la ejecución si existe alguna inconsistencia

stopifnot(all(validacion_edad_sexo))


# ------------------------------------------------------------
# 6.7. PRESENTACIÓN DE LA TABLA PORCENTUAL
# ------------------------------------------------------------

tabla_porcentual_presentacion <- matrix(
  sprintf("%.4f", tabla_porcentual_edad_sexo),
  nrow = nrow(tabla_porcentual_edad_sexo),
  dimnames = dimnames(tabla_porcentual_edad_sexo)
)


print(
  tabla_porcentual_presentacion,
  quote = FALSE
)


# ------------------------------------------------------------
# FIN DE LA DISTRIBUCIÓN CONJUNTA POR EDAD Y SEXO
# ------------------------------------------------------------
# ============================================================
# 7. DISTRIBUCIONES DE FRECUENCIAS CONDICIONALES
# ============================================================


# ------------------------------------------------------------
# 7.1. VERIFICAR LOS DENOMINADORES
# ------------------------------------------------------------

# Comprobar que las frecuencias marginales
# sean estrictamente positivas

stopifnot(
  all(rowSums(frecuencias_absolutas_edad_sexo) > 0),
  all(colSums(frecuencias_absolutas_edad_sexo) > 0)
)


# ------------------------------------------------------------
# 7.2. FRECUENCIAS RELATIVAS CONDICIONALES POR FILAS
# ------------------------------------------------------------

# Distribución del sexo dentro de cada grupo de edad

frecuencias_condicionales_filas <- prop.table(
  frecuencias_absolutas_edad_sexo,
  margin = 1
)


# Mostrar los resultados

print(
  round(frecuencias_condicionales_filas, 4)
)


# ------------------------------------------------------------
# 7.3. FRECUENCIAS PORCENTUALES POR FILAS
# ------------------------------------------------------------

porcentajes_condicionales_filas <-
  frecuencias_condicionales_filas * 100


# Incorporar los totales por fila

tabla_condicional_filas <- cbind(
  porcentajes_condicionales_filas,
  Total = rowSums(porcentajes_condicionales_filas)
)


# Mostrar los resultados

print(
  round(tabla_condicional_filas, 4)
)


# ------------------------------------------------------------
# 7.4. FRECUENCIAS RELATIVAS CONDICIONALES POR COLUMNAS
# ------------------------------------------------------------

# Distribución de los grupos de edad dentro de cada sexo

frecuencias_condicionales_columnas <- prop.table(
  frecuencias_absolutas_edad_sexo,
  margin = 2
)


# Mostrar los resultados

print(
  round(frecuencias_condicionales_columnas, 4)
)


# ------------------------------------------------------------
# 7.5. FRECUENCIAS PORCENTUALES POR COLUMNAS
# ------------------------------------------------------------

porcentajes_condicionales_columnas <-
  frecuencias_condicionales_columnas * 100


# Incorporar los totales por columna

tabla_condicional_columnas <- rbind(
  porcentajes_condicionales_columnas,
  Total = colSums(porcentajes_condicionales_columnas)
)


# Mostrar los resultados

print(
  round(tabla_condicional_columnas, 4)
)


# ------------------------------------------------------------
# 7.6. VALIDACIÓN DE LAS DISTRIBUCIONES CONDICIONALES
# ------------------------------------------------------------

# Establecer una tolerancia numérica

tolerancia_condicional <- 1e-10


# Integrar las comprobaciones

validacion_condicionales <- c(

  dimensiones_filas = all(
    dim(frecuencias_condicionales_filas) == c(22, 2)
  ),

  dimensiones_columnas = all(
    dim(frecuencias_condicionales_columnas) == c(22, 2)
  ),

  integridad = (
    all(is.finite(frecuencias_condicionales_filas)) &&
      all(is.finite(frecuencias_condicionales_columnas))
  ),

  rango_filas = all(
    frecuencias_condicionales_filas >= 0 &
      frecuencias_condicionales_filas <= 1
  ),

  rango_columnas = all(
    frecuencias_condicionales_columnas >= 0 &
      frecuencias_condicionales_columnas <= 1
  ),

  relativas_filas = all(
    abs(
      rowSums(frecuencias_condicionales_filas) - 1
    ) < tolerancia_condicional
  ),

  relativas_columnas = all(
    abs(
      colSums(frecuencias_condicionales_columnas) - 1
    ) < tolerancia_condicional
  ),

  porcentuales_filas = all(
    abs(
      rowSums(porcentajes_condicionales_filas) - 100
    ) < tolerancia_condicional
  ),

  porcentuales_columnas = all(
    abs(
      colSums(porcentajes_condicionales_columnas) - 100
    ) < tolerancia_condicional
  )

)


# Mostrar las validaciones

print(validacion_condicionales)


# Detener la ejecución si existe alguna inconsistencia

stopifnot(all(validacion_condicionales))


# ------------------------------------------------------------
# 7.7. PRESENTACIÓN DE LOS PORCENTAJES POR FILAS
# ------------------------------------------------------------

tabla_condicional_filas_presentacion <- matrix(
  sprintf("%.4f", tabla_condicional_filas),
  nrow = nrow(tabla_condicional_filas),
  dimnames = dimnames(tabla_condicional_filas)
)


print(
  tabla_condicional_filas_presentacion,
  quote = FALSE
)


# ------------------------------------------------------------
# 7.8. PRESENTACIÓN DE LOS PORCENTAJES POR COLUMNAS
# ------------------------------------------------------------

tabla_condicional_columnas_presentacion <- matrix(
  sprintf("%.4f", tabla_condicional_columnas),
  nrow = nrow(tabla_condicional_columnas),
  dimnames = dimnames(tabla_condicional_columnas)
)


print(
  tabla_condicional_columnas_presentacion,
  quote = FALSE
)


# ------------------------------------------------------------
# FIN DE LAS DISTRIBUCIONES CONDICIONALES
# ------------------------------------------------------------
# ============================================================
# 8. DISTRIBUCIÓN DE FRECUENCIAS POR ENTIDAD FEDERATIVA
# ============================================================


# ------------------------------------------------------------
# 8.1. SELECCIONAR LAS ENTIDADES FEDERATIVAS
# ------------------------------------------------------------

# Seleccionar exclusivamente los totales estatales
# Excluir el agregado nacional

poblacion_entidades <- subset(
  poblacion,
  entidad != "Estados Unidos Mexicanos" &
    grupo_edad == "Total"
)


# Consultar el número de entidades

print(nrow(poblacion_entidades))


# Verificar la cobertura territorial

stopifnot(
  nrow(poblacion_entidades) == 32,
  !anyDuplicated(poblacion_entidades$entidad)
)


# ------------------------------------------------------------
# 8.2. CALCULAR LAS FRECUENCIAS ABSOLUTAS
# ------------------------------------------------------------

frecuencias_absolutas_entidades <-
  poblacion_entidades$poblacion_total


# Mostrar los resultados

print(frecuencias_absolutas_entidades)


# Calcular la población total de las entidades

N_entidades <- sum(
  frecuencias_absolutas_entidades
)


# Mostrar el resultado

print(N_entidades)


# Verificar la coincidencia con la población nacional

stopifnot(
  N_entidades == poblacion_nacional$poblacion_total
)


# ------------------------------------------------------------
# 8.3. CALCULAR LAS FRECUENCIAS RELATIVAS
# ------------------------------------------------------------

frecuencias_relativas_entidades <-
  frecuencias_absolutas_entidades / N_entidades


# Mostrar las frecuencias relativas

print(frecuencias_relativas_entidades)


# ------------------------------------------------------------
# 8.4. CALCULAR LAS FRECUENCIAS PORCENTUALES
# ------------------------------------------------------------

frecuencias_porcentuales_entidades <-
  frecuencias_relativas_entidades * 100


# Mostrar las frecuencias porcentuales

print(frecuencias_porcentuales_entidades)


# ------------------------------------------------------------
# 8.5. CONSTRUIR LA TABLA DE FRECUENCIAS
# ------------------------------------------------------------

tabla_entidades <- data.frame(

  entidad = poblacion_entidades$entidad,

  frecuencia_absoluta =
    frecuencias_absolutas_entidades,

  frecuencia_relativa =
    frecuencias_relativas_entidades,

  frecuencia_porcentual =
    frecuencias_porcentuales_entidades

)


# Mostrar la tabla

print(tabla_entidades)


# ------------------------------------------------------------
# 8.6. ORDENAR LAS ENTIDADES POR POBLACIÓN
# ------------------------------------------------------------

# Ordenar de mayor a menor tamaño poblacional

tabla_entidades <- tabla_entidades[
  order(
    -tabla_entidades$frecuencia_absoluta,
    tabla_entidades$entidad
  ),
]


# Restablecer los números de fila

rownames(tabla_entidades) <- NULL


# Incorporar la posición de cada entidad

tabla_entidades$posicion <- seq_len(
  nrow(tabla_entidades)
)


# Reorganizar las columnas

tabla_entidades <- tabla_entidades[
  c(
    "posicion",
    "entidad",
    "frecuencia_absoluta",
    "frecuencia_relativa",
    "frecuencia_porcentual"
  )
]


# Mostrar la tabla ordenada

print(tabla_entidades)


# ------------------------------------------------------------
# 8.7. VALIDACIÓN ESTADÍSTICA
# ------------------------------------------------------------

validacion_entidades <- c(

  cobertura = (
    nrow(tabla_entidades) == 32
  ),

  duplicados = (
    !anyDuplicated(tabla_entidades$entidad)
  ),

  integridad = (
    !anyNA(tabla_entidades)
  ),

  valores_positivos = all(
    tabla_entidades$frecuencia_absoluta > 0
  ),

  absoluta = (
    sum(tabla_entidades$frecuencia_absoluta) ==
      poblacion_nacional$poblacion_total
  ),

  relativa = isTRUE(
    all.equal(
      sum(tabla_entidades$frecuencia_relativa),
      1
    )
  ),

  porcentual = isTRUE(
    all.equal(
      sum(tabla_entidades$frecuencia_porcentual),
      100
    )
  ),

  orden = all(
    diff(tabla_entidades$frecuencia_absoluta) <= 0
  )

)


# Mostrar los resultados de la validación

print(validacion_entidades)


# Detener la ejecución si existe alguna inconsistencia

stopifnot(
  all(validacion_entidades)
)


# ------------------------------------------------------------
# 8.8. INCORPORAR EL TOTAL NACIONAL
# ------------------------------------------------------------

total_entidades <- data.frame(

  posicion = NA_integer_,

  entidad = "Total nacional",

  frecuencia_absoluta =
    sum(tabla_entidades$frecuencia_absoluta),

  frecuencia_relativa =
    sum(tabla_entidades$frecuencia_relativa),

  frecuencia_porcentual =
    sum(tabla_entidades$frecuencia_porcentual)

)


# Incorporar el total a una tabla de presentación

tabla_entidades_presentacion <- rbind(
  tabla_entidades,
  total_entidades
)


# ------------------------------------------------------------
# 8.9. FORMATEAR LOS RESULTADOS
# ------------------------------------------------------------

# Conservar cuatro decimales en la presentación

tabla_entidades_presentacion$frecuencia_relativa <-
  sprintf(
    "%.4f",
    tabla_entidades_presentacion$frecuencia_relativa
  )


tabla_entidades_presentacion$frecuencia_porcentual <-
  sprintf(
    "%.4f",
    tabla_entidades_presentacion$frecuencia_porcentual
  )


# Mostrar la tabla final

print(
  tabla_entidades_presentacion,
  row.names = FALSE
)


# ------------------------------------------------------------
# FIN DE LA DISTRIBUCIÓN POR ENTIDAD FEDERATIVA
# ------------------------------------------------------------
# ============================================================
# 9. DISTRIBUCIÓN CONJUNTA Y CONDICIONAL POR ENTIDAD Y SEXO
# ============================================================


# ------------------------------------------------------------
# 9.1. PREPARAR LOS REGISTROS ESTATALES
# ------------------------------------------------------------

# Conservar el orden poblacional establecido anteriormente

entidad_sexo <- poblacion_entidades[
  match(
    tabla_entidades$entidad,
    poblacion_entidades$entidad
  ),
]


# Verificar los registros

stopifnot(
  nrow(entidad_sexo) == 32,
  !anyNA(entidad_sexo),
  !anyDuplicated(entidad_sexo$entidad)
)


# ------------------------------------------------------------
# 9.2. FRECUENCIAS ABSOLUTAS CONJUNTAS
# ------------------------------------------------------------

frecuencias_absolutas_entidad_sexo <- as.matrix(
  entidad_sexo[c("hombres", "mujeres")]
)


# Asignar los nombres de las filas

rownames(frecuencias_absolutas_entidad_sexo) <-
  entidad_sexo$entidad


# Asignar los nombres de las columnas

colnames(frecuencias_absolutas_entidad_sexo) <-
  c("Hombres", "Mujeres")


# Incorporar las distribuciones marginales

tabla_absoluta_entidad_sexo <- addmargins(
  frecuencias_absolutas_entidad_sexo
)


# Identificar los totales

rownames(tabla_absoluta_entidad_sexo)[33] <- "Total"

colnames(tabla_absoluta_entidad_sexo)[3] <- "Total"


# Mostrar los resultados

print(tabla_absoluta_entidad_sexo)


# ------------------------------------------------------------
# 9.3. FRECUENCIAS RELATIVAS CONJUNTAS
# ------------------------------------------------------------

frecuencias_relativas_entidad_sexo <- prop.table(
  frecuencias_absolutas_entidad_sexo
)


# Incorporar las frecuencias marginales

tabla_relativa_entidad_sexo <- addmargins(
  frecuencias_relativas_entidad_sexo
)


# Identificar los totales

rownames(tabla_relativa_entidad_sexo)[33] <- "Total"

colnames(tabla_relativa_entidad_sexo)[3] <- "Total"


# Mostrar los resultados

print(
  round(tabla_relativa_entidad_sexo, 4)
)


# ------------------------------------------------------------
# 9.4. FRECUENCIAS PORCENTUALES CONJUNTAS
# ------------------------------------------------------------

tabla_porcentual_entidad_sexo <-
  tabla_relativa_entidad_sexo * 100


# Mostrar los porcentajes respecto a la población nacional

print(
  round(tabla_porcentual_entidad_sexo, 4)
)


# ------------------------------------------------------------
# 9.5. VERIFICAR LOS DENOMINADORES
# ------------------------------------------------------------

stopifnot(
  all(rowSums(frecuencias_absolutas_entidad_sexo) > 0),
  all(colSums(frecuencias_absolutas_entidad_sexo) > 0)
)


# ------------------------------------------------------------
# 9.6. DISTRIBUCIÓN CONDICIONAL POR ENTIDAD FEDERATIVA
# ------------------------------------------------------------

# Calcular las proporciones por filas

relativas_entidad_sexo_filas <- prop.table(
  frecuencias_absolutas_entidad_sexo,
  margin = 1
)


# Convertir las proporciones en porcentajes

porcentajes_entidad_sexo_filas <-
  relativas_entidad_sexo_filas * 100


# Incorporar los totales de cada entidad

tabla_entidad_sexo_filas <- cbind(
  porcentajes_entidad_sexo_filas,
  Total = rowSums(porcentajes_entidad_sexo_filas)
)


# Mostrar los resultados

print(
  round(tabla_entidad_sexo_filas, 4)
)


# ------------------------------------------------------------
# 9.7. DISTRIBUCIÓN CONDICIONAL POR SEXO
# ------------------------------------------------------------

# Calcular las proporciones por columnas

relativas_entidad_sexo_columnas <- prop.table(
  frecuencias_absolutas_entidad_sexo,
  margin = 2
)


# Convertir las proporciones en porcentajes

porcentajes_entidad_sexo_columnas <-
  relativas_entidad_sexo_columnas * 100


# Incorporar los totales por sexo

tabla_entidad_sexo_columnas <- rbind(
  porcentajes_entidad_sexo_columnas,
  Total = colSums(porcentajes_entidad_sexo_columnas)
)


# Mostrar los resultados

print(
  round(tabla_entidad_sexo_columnas, 4)
)


# ------------------------------------------------------------
# 9.8. VALIDACIÓN ESTADÍSTICA
# ------------------------------------------------------------

tolerancia_entidad_sexo <- 1e-10


validacion_entidad_sexo <- c(

  dimensiones = all(
    dim(frecuencias_absolutas_entidad_sexo) == c(32, 2)
  ),

  integridad = (
    all(is.finite(frecuencias_absolutas_entidad_sexo)) &&
      all(frecuencias_absolutas_entidad_sexo >= 0)
  ),

  total_nacional = (
    sum(frecuencias_absolutas_entidad_sexo) ==
      poblacion_nacional$poblacion_total
  ),

  total_hombres = (
    sum(frecuencias_absolutas_entidad_sexo[, "Hombres"]) ==
      poblacion_nacional$hombres
  ),

  total_mujeres = (
    sum(frecuencias_absolutas_entidad_sexo[, "Mujeres"]) ==
      poblacion_nacional$mujeres
  ),

  totales_estatales = all(
    rowSums(frecuencias_absolutas_entidad_sexo) ==
      entidad_sexo$poblacion_total
  ),

  frecuencia_relativa = isTRUE(
    all.equal(
      sum(frecuencias_relativas_entidad_sexo),
      1
    )
  ),

  frecuencia_porcentual = isTRUE(
    all.equal(
      sum(frecuencias_relativas_entidad_sexo * 100),
      100
    )
  ),

  distribucion_marginal = all(
    abs(
      rowSums(frecuencias_relativas_entidad_sexo) -
        tabla_entidades$frecuencia_relativa
    ) < tolerancia_entidad_sexo
  ),

  condicional_filas = all(
    abs(
      rowSums(relativas_entidad_sexo_filas) - 1
    ) < tolerancia_entidad_sexo
  ),

  condicional_columnas = all(
    abs(
      colSums(relativas_entidad_sexo_columnas) - 1
    ) < tolerancia_entidad_sexo
  )

)


# Mostrar las validaciones

print(validacion_entidad_sexo)


# Detener la ejecución si existe alguna inconsistencia

stopifnot(
  all(validacion_entidad_sexo)
)


# ------------------------------------------------------------
# 9.9. PRESENTACIÓN DE LOS PORCENTAJES CONJUNTOS
# ------------------------------------------------------------

tabla_porcentual_entidad_sexo_presentacion <- matrix(
  sprintf("%.4f", tabla_porcentual_entidad_sexo),
  nrow = nrow(tabla_porcentual_entidad_sexo),
  dimnames = dimnames(tabla_porcentual_entidad_sexo)
)


print(
  tabla_porcentual_entidad_sexo_presentacion,
  quote = FALSE
)


# ------------------------------------------------------------
# 9.10. PRESENTACIÓN DE LOS PORCENTAJES POR FILAS
# ------------------------------------------------------------

tabla_entidad_sexo_filas_presentacion <- matrix(
  sprintf("%.4f", tabla_entidad_sexo_filas),
  nrow = nrow(tabla_entidad_sexo_filas),
  dimnames = dimnames(tabla_entidad_sexo_filas)
)


print(
  tabla_entidad_sexo_filas_presentacion,
  quote = FALSE
)


# ------------------------------------------------------------
# 9.11. PRESENTACIÓN DE LOS PORCENTAJES POR COLUMNAS
# ------------------------------------------------------------

tabla_entidad_sexo_columnas_presentacion <- matrix(
  sprintf("%.4f", tabla_entidad_sexo_columnas),
  nrow = nrow(tabla_entidad_sexo_columnas),
  dimnames = dimnames(tabla_entidad_sexo_columnas)
)


print(
  tabla_entidad_sexo_columnas_presentacion,
  quote = FALSE
)


# ------------------------------------------------------------
# FIN DE LA DISTRIBUCIÓN POR ENTIDAD FEDERATIVA Y SEXO
# ------------------------------------------------------------
# ============================================================
# 10. DISTRIBUCIÓN POR ENTIDAD FEDERATIVA Y GRUPO DE EDAD
# ============================================================


# ------------------------------------------------------------
# 10.1. SELECCIONAR LOS REGISTROS ESTATALES
# ------------------------------------------------------------

entidad_edad <- subset(
  poblacion,
  entidad != "Estados Unidos Mexicanos" &
    grupo_edad != "Total"
)


# Consultar las dimensiones

print(dim(entidad_edad))


# Verificar la estructura

stopifnot(
  nrow(entidad_edad) == 704,
  !anyNA(entidad_edad),
  !anyDuplicated(
    entidad_edad[c("entidad", "grupo_edad")]
  ),
  all(table(entidad_edad$entidad) == 22),
  all(table(entidad_edad$grupo_edad) == 32)
)


# ------------------------------------------------------------
# 10.2. ESTABLECER EL ORDEN DE LAS CATEGORÍAS
# ------------------------------------------------------------

# Ordenar las entidades por tamaño poblacional

entidad_edad$entidad <- factor(
  entidad_edad$entidad,
  levels = tabla_entidades$entidad
)


# Ordenar las categorías de edad

entidad_edad$grupo_edad <- factor(
  entidad_edad$grupo_edad,
  levels = orden_edad_sexo
)


# Comprobar que no existan categorías desconocidas

stopifnot(
  !anyNA(entidad_edad$entidad),
  !anyNA(entidad_edad$grupo_edad)
)


# ------------------------------------------------------------
# 10.3. FRECUENCIAS ABSOLUTAS CONJUNTAS
# ------------------------------------------------------------

# Construir la tabla de contingencia utilizando
# la población como frecuencia absoluta

frecuencias_absolutas_entidad_edad <- xtabs(
  poblacion_total ~ entidad + grupo_edad,
  data = entidad_edad
)


# Mostrar las dimensiones

print(
  dim(frecuencias_absolutas_entidad_edad)
)


# Mostrar las primeras filas y columnas

print(
  frecuencias_absolutas_entidad_edad[1:5, 1:5]
)


# ------------------------------------------------------------
# 10.4. DISTRIBUCIONES MARGINALES
# ------------------------------------------------------------

tabla_absoluta_entidad_edad <- addmargins(
  frecuencias_absolutas_entidad_edad
)


# Identificar los totales

rownames(tabla_absoluta_entidad_edad)[33] <- "Total"

colnames(tabla_absoluta_entidad_edad)[23] <- "Total"


# Consultar los totales por entidad federativa

print(
  tabla_absoluta_entidad_edad[, "Total"]
)


# Consultar los totales por grupo de edad

print(
  tabla_absoluta_entidad_edad["Total", ]
)


# ------------------------------------------------------------
# 10.5. FRECUENCIAS RELATIVAS CONJUNTAS
# ------------------------------------------------------------

frecuencias_relativas_entidad_edad <- prop.table(
  frecuencias_absolutas_entidad_edad
)


# Incorporar las distribuciones marginales

tabla_relativa_entidad_edad <- addmargins(
  frecuencias_relativas_entidad_edad
)


# Identificar los totales

rownames(tabla_relativa_entidad_edad)[33] <- "Total"

colnames(tabla_relativa_entidad_edad)[23] <- "Total"


# ------------------------------------------------------------
# 10.6. FRECUENCIAS PORCENTUALES CONJUNTAS
# ------------------------------------------------------------

tabla_porcentual_entidad_edad <-
  tabla_relativa_entidad_edad * 100


# Mostrar una parte de los resultados

print(
  round(
    tabla_porcentual_entidad_edad[1:5, 1:5],
    4
  )
)


# ------------------------------------------------------------
# 10.7. VERIFICAR LOS DENOMINADORES
# ------------------------------------------------------------

stopifnot(
  all(rowSums(frecuencias_absolutas_entidad_edad) > 0),
  all(colSums(frecuencias_absolutas_entidad_edad) > 0)
)


# ------------------------------------------------------------
# 10.8. DISTRIBUCIÓN CONDICIONAL POR ENTIDAD FEDERATIVA
# ------------------------------------------------------------

# Calcular la estructura etaria de cada entidad

relativas_entidad_edad_filas <- prop.table(
  frecuencias_absolutas_entidad_edad,
  margin = 1
)


# Convertir las proporciones en porcentajes

porcentajes_entidad_edad_filas <-
  relativas_entidad_edad_filas * 100


# Incorporar los totales por entidad

tabla_entidad_edad_filas <- cbind(
  porcentajes_entidad_edad_filas,
  Total = rowSums(porcentajes_entidad_edad_filas)
)


# Mostrar los resultados parciales

print(
  round(
    tabla_entidad_edad_filas[1:5, 1:5],
    4
  )
)


# ------------------------------------------------------------
# 10.9. DISTRIBUCIÓN CONDICIONAL POR GRUPO DE EDAD
# ------------------------------------------------------------

# Calcular la distribución territorial de cada grupo de edad

relativas_entidad_edad_columnas <- prop.table(
  frecuencias_absolutas_entidad_edad,
  margin = 2
)


# Convertir las proporciones en porcentajes

porcentajes_entidad_edad_columnas <-
  relativas_entidad_edad_columnas * 100


# Incorporar los totales por grupo de edad

tabla_entidad_edad_columnas <- rbind(
  porcentajes_entidad_edad_columnas,
  Total = colSums(porcentajes_entidad_edad_columnas)
)


# Mostrar los resultados parciales

print(
  round(
    tabla_entidad_edad_columnas[1:5, 1:5],
    4
  )
)


# ------------------------------------------------------------
# 10.10. PREPARAR LOS TOTALES DE REFERENCIA
# ------------------------------------------------------------

# Obtener los totales nacionales por edad

referencia_edad_nacional <- subset(
  poblacion,
  entidad == "Estados Unidos Mexicanos" &
    grupo_edad != "Total"
)


# Ordenar las categorías nacionales

referencia_edad_nacional <- referencia_edad_nacional[
  match(
    orden_edad_sexo,
    referencia_edad_nacional$grupo_edad
  ),
]


stopifnot(
  !anyNA(referencia_edad_nacional),
  nrow(referencia_edad_nacional) == 22
)


# ------------------------------------------------------------
# 10.11. VALIDACIÓN ESTADÍSTICA
# ------------------------------------------------------------

tolerancia_entidad_edad <- 1e-10


validacion_entidad_edad <- c(

  dimensiones = all(
    dim(frecuencias_absolutas_entidad_edad) == c(32, 22)
  ),

  integridad = (
    all(is.finite(frecuencias_absolutas_entidad_edad)) &&
      all(frecuencias_absolutas_entidad_edad >= 0)
  ),

  total_nacional = (
    sum(frecuencias_absolutas_entidad_edad) ==
      poblacion_nacional$poblacion_total
  ),

  totales_estatales = all(
    rowSums(frecuencias_absolutas_entidad_edad) ==
      tabla_entidades$frecuencia_absoluta
  ),

  totales_edad = all(
    colSums(frecuencias_absolutas_entidad_edad) ==
      referencia_edad_nacional$poblacion_total
  ),

  frecuencia_relativa = isTRUE(
    all.equal(
      sum(frecuencias_relativas_entidad_edad),
      1
    )
  ),

  frecuencia_porcentual = isTRUE(
    all.equal(
      sum(frecuencias_relativas_entidad_edad * 100),
      100
    )
  ),

  relativas_filas = all(
    abs(
      rowSums(relativas_entidad_edad_filas) - 1
    ) < tolerancia_entidad_edad
  ),

  relativas_columnas = all(
    abs(
      colSums(relativas_entidad_edad_columnas) - 1
    ) < tolerancia_entidad_edad
  ),

  porcentuales_filas = all(
    abs(
      rowSums(porcentajes_entidad_edad_filas) - 100
    ) < tolerancia_entidad_edad
  ),

  porcentuales_columnas = all(
    abs(
      colSums(porcentajes_entidad_edad_columnas) - 100
    ) < tolerancia_entidad_edad
  )

)


# Mostrar las validaciones

print(validacion_entidad_edad)


# Detener la ejecución ante cualquier inconsistencia

stopifnot(all(validacion_entidad_edad))


# ------------------------------------------------------------
# 10.12. CONSULTAR LA ESTRUCTURA DEMOGRÁFICA DE PUEBLA
# ------------------------------------------------------------

estructura_edad_puebla <- data.frame(

  grupo_edad = orden_edad_sexo,

  frecuencia_absoluta = as.numeric(
    frecuencias_absolutas_entidad_edad["Puebla", ]
  ),

  porcentaje_estatal = as.numeric(
    porcentajes_entidad_edad_filas["Puebla", ]
  ),

  porcentaje_nacional_grupo = as.numeric(
    porcentajes_entidad_edad_columnas["Puebla", ]
  )

)


# Preparar una copia para presentación

estructura_edad_puebla_presentacion <- estructura_edad_puebla


estructura_edad_puebla_presentacion$porcentaje_estatal <-
  sprintf(
    "%.4f",
    estructura_edad_puebla$porcentaje_estatal
  )


estructura_edad_puebla_presentacion$porcentaje_nacional_grupo <-
  sprintf(
    "%.4f",
    estructura_edad_puebla$porcentaje_nacional_grupo
  )


# Mostrar la estructura demográfica de Puebla

print(
  estructura_edad_puebla_presentacion,
  row.names = FALSE
)


# ------------------------------------------------------------
# FIN DE LA DISTRIBUCIÓN POR ENTIDAD Y GRUPO DE EDAD
# ------------------------------------------------------------
# ============================================================
# 11. VALIDACIÓN FINAL Y EXPORTACIÓN DE RESULTADOS
# ============================================================


# ------------------------------------------------------------
# 11.1. INTEGRAR LAS VALIDACIONES ESTADÍSTICAS
# ------------------------------------------------------------

comprobaciones_modulo_02 <- unlist(

  list(

    sexo = validacion_frecuencias_sexo,

    edad = validacion_frecuencias_edad,

    edad_sexo = validacion_edad_sexo,

    condicionales = validacion_condicionales,

    entidades = validacion_entidades,

    entidad_sexo = validacion_entidad_sexo,

    entidad_edad = validacion_entidad_edad

  )

)


# Mostrar todas las comprobaciones

print(comprobaciones_modulo_02)


# Consultar el número de comprobaciones

print(length(comprobaciones_modulo_02))


# ------------------------------------------------------------
# 11.2. VALIDACIÓN GENERAL DEL MÓDULO
# ------------------------------------------------------------

validacion_final_modulo_02 <- all(
  comprobaciones_modulo_02
)


# Mostrar el resultado

print(validacion_final_modulo_02)


# Detener la ejecución si existen inconsistencias

stopifnot(
  length(comprobaciones_modulo_02) == 56,
  validacion_final_modulo_02
)


# ------------------------------------------------------------
# 11.3. GENERAR EL INFORME DE VALIDACIÓN
# ------------------------------------------------------------

informe_validacion_modulo_02 <- data.frame(

  comprobacion = names(comprobaciones_modulo_02),

  resultado = as.logical(comprobaciones_modulo_02)

)


# Mostrar el informe

print(informe_validacion_modulo_02)


# ------------------------------------------------------------
# 11.4. CREAR LA CARPETA DE RESULTADOS
# ------------------------------------------------------------

ruta_resultados_modulo_02 <-
  "resultados/tablas/modulo_02"


dir.create(
  ruta_resultados_modulo_02,
  recursive = TRUE,
  showWarnings = FALSE
)


# Comprobar la existencia de la carpeta

stopifnot(
  dir.exists(ruta_resultados_modulo_02)
)


# ------------------------------------------------------------
# 11.5. FUNCIÓN PARA PREPARAR TABLAS DE CONTINGENCIA
# ------------------------------------------------------------

# Convertir las matrices en tablas exportables
# sin perder los nombres de las categorías

preparar_tabla_exportacion <- function(
    matriz,
    nombre_categoria
) {

  resultado <- data.frame(
    categoria = rownames(matriz),
    as.data.frame.matrix(matriz),
    check.names = FALSE,
    row.names = NULL
  )

  names(resultado) <- c(
    nombre_categoria,
    colnames(matriz)
  )

  return(resultado)

}


# ------------------------------------------------------------
# 11.6. COBERTURA DE LA INFORMACIÓN POR EDAD
# ------------------------------------------------------------

tabla_cobertura_edad <- data.frame(

  categoria = c(
    "Edad especificada",
    "Edad no especificada"
  ),

  frecuencia_absoluta = c(
    N_edad,
    N_no_especificada
  )

)


tabla_cobertura_edad$frecuencia_relativa <-
  tabla_cobertura_edad$frecuencia_absoluta /
  poblacion_nacional$poblacion_total


tabla_cobertura_edad$frecuencia_porcentual <-
  tabla_cobertura_edad$frecuencia_relativa * 100


# ------------------------------------------------------------
# 11.7. ORGANIZAR LAS TABLAS DEL MÓDULO
# ------------------------------------------------------------

tablas_modulo_02 <- list(

  # Distribuciones univariadas

  "01_frecuencias_sexo" = tabla_sexo,

  "02_frecuencias_edad" = tabla_edad,

  "03_frecuencias_entidades" = tabla_entidades,

  "04_cobertura_informacion_edad" =
    tabla_cobertura_edad,


  # Distribuciones conjuntas por edad y sexo

  "05_edad_sexo_absoluta" =
    preparar_tabla_exportacion(
      tabla_absoluta_edad_sexo,
      "grupo_edad"
    ),

  "06_edad_sexo_relativa" =
    preparar_tabla_exportacion(
      tabla_relativa_edad_sexo,
      "grupo_edad"
    ),

  "07_edad_sexo_porcentual" =
    preparar_tabla_exportacion(
      tabla_porcentual_edad_sexo,
      "grupo_edad"
    ),

  "08_edad_sexo_condicional_filas" =
    preparar_tabla_exportacion(
      tabla_condicional_filas,
      "grupo_edad"
    ),

  "09_edad_sexo_condicional_columnas" =
    preparar_tabla_exportacion(
      tabla_condicional_columnas,
      "grupo_edad"
    ),


  # Distribuciones conjuntas por entidad y sexo

  "10_entidad_sexo_absoluta" =
    preparar_tabla_exportacion(
      tabla_absoluta_entidad_sexo,
      "entidad"
    ),

  "11_entidad_sexo_relativa" =
    preparar_tabla_exportacion(
      tabla_relativa_entidad_sexo,
      "entidad"
    ),

  "12_entidad_sexo_porcentual" =
    preparar_tabla_exportacion(
      tabla_porcentual_entidad_sexo,
      "entidad"
    ),

  "13_entidad_sexo_condicional_filas" =
    preparar_tabla_exportacion(
      tabla_entidad_sexo_filas,
      "entidad"
    ),

  "14_entidad_sexo_condicional_columnas" =
    preparar_tabla_exportacion(
      tabla_entidad_sexo_columnas,
      "entidad"
    ),


  # Distribuciones conjuntas por entidad y edad

  "15_entidad_edad_absoluta" =
    preparar_tabla_exportacion(
      tabla_absoluta_entidad_edad,
      "entidad"
    ),

  "16_entidad_edad_relativa" =
    preparar_tabla_exportacion(
      tabla_relativa_entidad_edad,
      "entidad"
    ),

  "17_entidad_edad_porcentual" =
    preparar_tabla_exportacion(
      tabla_porcentual_entidad_edad,
      "entidad"
    ),

  "18_entidad_edad_condicional_filas" =
    preparar_tabla_exportacion(
      tabla_entidad_edad_filas,
      "entidad"
    ),

  "19_entidad_edad_condicional_columnas" =
    preparar_tabla_exportacion(
      tabla_entidad_edad_columnas,
      "entidad"
    ),


  # Aplicación territorial

  "20_estructura_edad_puebla" =
    estructura_edad_puebla,


  # Informe de validación

  "21_informe_validacion" =
    informe_validacion_modulo_02

)


# Consultar el número de tablas

print(length(tablas_modulo_02))


# Mostrar sus nombres

print(names(tablas_modulo_02))


# ------------------------------------------------------------
# 11.8. EXPORTAR LAS TABLAS EN FORMATO CSV
# ------------------------------------------------------------

for (nombre in names(tablas_modulo_02)) {

  ruta_archivo <- file.path(
    ruta_resultados_modulo_02,
    paste0(nombre, ".csv")
  )

  write.csv(
    tablas_modulo_02[[nombre]],
    file = ruta_archivo,
    row.names = FALSE,
    fileEncoding = "UTF-8"
  )

}


# ------------------------------------------------------------
# 11.9. EXPORTAR LOS RESULTADOS EN FORMATO RDS
# ------------------------------------------------------------

ruta_rds_modulo_02 <- file.path(
  ruta_resultados_modulo_02,
  "resultados_modulo_02.rds"
)


saveRDS(
  tablas_modulo_02,
  file = ruta_rds_modulo_02
)


# ------------------------------------------------------------
# 11.10. VERIFICAR LOS ARCHIVOS EXPORTADOS
# ------------------------------------------------------------

archivos_csv_modulo_02 <- file.path(

  ruta_resultados_modulo_02,

  paste0(
    names(tablas_modulo_02),
    ".csv"
  )

)


# Comprobar que existen los 21 archivos CSV

print(
  sum(file.exists(archivos_csv_modulo_02))
)


# Comprobar el archivo RDS

print(
  file.exists(ruta_rds_modulo_02)
)


stopifnot(
  length(archivos_csv_modulo_02) == 21,
  all(file.exists(archivos_csv_modulo_02)),
  file.exists(ruta_rds_modulo_02)
)


# ------------------------------------------------------------
# 11.11. VERIFICAR LA INTEGRIDAD DEL ARCHIVO RDS
# ------------------------------------------------------------

resultados_recuperados_modulo_02 <- readRDS(
  ruta_rds_modulo_02
)


integridad_rds_modulo_02 <- identical(

  tablas_modulo_02,

  resultados_recuperados_modulo_02

)


print(integridad_rds_modulo_02)


stopifnot(integridad_rds_modulo_02)


# ------------------------------------------------------------
# 11.12. VERIFICAR EL CONTENIDO DE LOS ARCHIVOS CSV
# ------------------------------------------------------------

validacion_csv_modulo_02 <- sapply(

  names(tablas_modulo_02),

  function(nombre) {

    tabla_original <- tablas_modulo_02[[nombre]]

    tabla_recuperada <- read.csv(

      file.path(
        ruta_resultados_modulo_02,
        paste0(nombre, ".csv")
      ),

      fileEncoding = "UTF-8",

      stringsAsFactors = FALSE,

      check.names = FALSE

    )

    # Verificar dimensiones y nombres de columnas

    estructura_correcta <- (
      identical(
        dim(tabla_original),
        dim(tabla_recuperada)
      ) &&
        identical(
          names(tabla_original),
          names(tabla_recuperada)
        )
    )

    # Comparar el contenido

    contenido_correcto <- all(

      mapply(

        function(original, recuperado) {

          if (is.factor(original)) {
            original <- as.character(original)
          }

          isTRUE(
            all.equal(
              original,
              recuperado,
              tolerance = 1e-12,
              check.attributes = FALSE
            )
          )

        },

        tabla_original,

        tabla_recuperada

      )

    )

    return(
      estructura_correcta &&
        contenido_correcto
    )

  }

)


# Mostrar el resultado de cada archivo

print(validacion_csv_modulo_02)


# Comprobar la integridad general

print(all(validacion_csv_modulo_02))


stopifnot(
  all(validacion_csv_modulo_02)
)


# ------------------------------------------------------------
# 11.13. RESUMEN FINAL DEL MÓDULO
# ------------------------------------------------------------

cat("\n")
cat("MÓDULO 02: DISTRIBUCIONES DE FRECUENCIAS\n")
cat("========================================\n")
cat("Validaciones estadísticas:",
    length(comprobaciones_modulo_02), "\n")
cat("Validaciones correctas:",
    sum(comprobaciones_modulo_02), "\n")
cat("Archivos CSV:", length(archivos_csv_modulo_02), "\n")
cat("Archivos RDS: 1\n")
cat("Integridad CSV:", all(validacion_csv_modulo_02), "\n")
cat("Integridad RDS:", integridad_rds_modulo_02, "\n")
cat("Estado: MÓDULO COMPLETADO\n")


# ------------------------------------------------------------
# FIN DEL MÓDULO 02
# ------------------------------------------------------------
