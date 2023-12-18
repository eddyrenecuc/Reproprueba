pkg load database

% Establecer la conexión a la base de datos
conn = pq_connect(setdbopts('dbname', 'examenparcial1', 'host', 'localhost', 'port', '5432', 'user', 'postgres', 'password', 'eddyrene'));

while true
    % Mostrar menú
    disp("1. Agregar Pedido");
    disp("2. Actualizar Pedido por Identificación");
    disp("3. Eliminar Pedido por Identificación");
    disp("4. Mostrar Lista de Pedidos");
    disp("5. Salir");

    % Solicitar opción al usuario
    opcion = input("Seleccione una opción: ");

    switch opcion
        case 1
            % Agregar problema4
            identificacion = input("Ingrese la identificación: ");
            cliente = input("Ingrese el nombre del cliente: ", 's');
            producto = input("Ingrese el nombre del producto: ", 's');
            entrega = input("¿Entregado? (Sí/No): ", 's');

            % Crear y ejecutar la consulta de inserción
            insert_query = sprintf("INSERT INTO problema4 (identificacion, cliente, producto, entrega) VALUES ('%d', '%s', '%s', '%s');", identificacion, cliente, producto, entrega);
            pq_exec_params(conn, insert_query);

            disp("Pedido agregado exitosamente.");

        case 2
            % Actualizar problema4 por identificación
            identificacion = input("Ingrese la identificación del problema4 a actualizar: ");

            % Verificar si el problema4 existe
            select_query = sprintf("SELECT * FROM problema4 WHERE identificacion = '%d';", identificacion);
            result = pq_exec_params(conn, select_query);

            if ~isempty(result.data)
                disp("Información actual del problema4:");
                disp(result.data);

                % Solicitar nueva información
                entrega = input("¿Entregado? (Sí/No): ", 's');

                % Crear y ejecutar la consulta de actualización
                update_query = sprintf("UPDATE problema4 SET entrega = '%s' WHERE identificacion = '%d';", entrega, identificacion);
                pq_exec_params(conn, update_query);

                disp("Pedido actualizado exitosamente.");
            else
                disp("No se encontró un problema4 con la identificación proporcionada.");
            end

        case 3
            % Eliminar problema4 por identificación
            identificacion = input("Ingrese la identificación del problema4 a eliminar: ");

            % Verificar si el problema4 existe
            select_query = sprintf("SELECT * FROM problema4 WHERE identificacion = '%d';", identificacion);
            result = pq_exec_params(conn, select_query);

            if ~isempty(result.data)
                % Crear y ejecutar la consulta de eliminación
                delete_query = sprintf("DELETE FROM problema4 WHERE identificacion = '%d';", identificacion);
                pq_exec_params(conn, delete_query);

                disp("Pedido eliminado exitosamente.");
            else
                disp("No se encontró un problema4 con la identificación proporcionada.");
            end

        case 4
            % Mostrar lista de pedidos
            select_all_query = "SELECT * FROM problema4;";
            result = pq_exec_params(conn, select_all_query);

            disp("Lista de Pedidos:");
            disp(result.data);

        case 5
            % Salir del programa
            pq_close(conn);
            disp("¡Hasta luego!");
            return;

        otherwise
            disp("Opción no válida. Por favor, seleccione una opción válida.");
    end
end
