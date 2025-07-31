#!/bin/zsh
# Directorio base del repositorio
BASE_DIR=$(pwd)

echo "Iniciando el proceso de actualización y commit de submódulos..."

# Recorrer los submódulos definidos en .gitmodules
for SUBMODULE in $(git config --file .gitmodules --get-regexp path | awk '{ print $2 }'); do
	echo "Procesando submódulo: $SUBMODULE"
	# Entrar en el directorio del submódulo
	cd "$BASE_DIR/$SUBMODULE"
	# Realizar fetch y checkout a la rama 18.0
	echo "Realizando fetch origin para $SUBMODULE..."
	git fetch origin
	echo "Haciendo checkout a la rama 18.0 para $SUBMODULE..."
	git checkout 18.0
	# Volver al directorio principal y hacer el commit
	cd "$BASE_DIR"
	echo "Haciendo commit para $SUBMODULE..."
	git add "$SUBMODULE"
	git commit -m "[UPG] Checkout to 18.0 for $SUBMODULE"
done

echo "Proceso completado. Todos los submódulos fueron actualizados y sus cambios fueron comiteados."
