#include <iostream>
#include <vector>
#include <string>
#include <cctype>

using namespace std;

// Guardar usuarios y contraseñas
vector<string> usuarios;
vector<string> contrasenas;

// Verifica si la contraseña es segura
bool VerificarContrasena(string pass) {
    bool mayuscula = false;
    bool numero = false;
    bool simbolo = false;

    if (pass.length() < 8)
        return false;

    for (char c : pass) {
        if (isupper(c)) mayuscula = true;
        else if (isdigit(c)) numero = true;
        else if (ispunct(c)) simbolo = true;
    }

    return mayuscula && numero && simbolo;
}

// Registrar usuario
void RegistrarUsuario() {
    string usuario, pass;

    cout << "Ingrese usuario: ";
    cin >> usuario;

    cout << "Ingrese contraseña: ";
    cin >> pass;

    usuarios.push_back(usuario);
    contrasenas.push_back(pass);

    if (VerificarContrasena(pass))
        cout << "Contraseña SEGURA\n";
    else
        cout << "⚠ ALERTA: Contraseña DÉBIL\n";
}

// Mostrar usuarios
void MostrarUsuarios() {
    cout << "\nUsuarios registrados:\n";
    for (int i = 0; i < usuarios.size(); i++) {
        cout << "- " << usuarios[i] << endl;
    }
}

int main() {
    int opcion;

    do {
        cout << "\n--- GESTOR DE CONTRASEÑAS ---\n";
        cout << "1. Registrar usuario\n";
        cout << "2. Mostrar usuarios\n";
        cout << "3. Salir\n";
        cout << "Opción: ";
        cin >> opcion;

        switch (opcion) {
            case 1:
                RegistrarUsuario();
                break;
            case 2:
                MostrarUsuarios();
                break;
            case 3:
                cout << "Saliendo...\n";
                break;
            default:
                cout << "Opción inválida\n";
        }
    } while (opcion != 3);

    return 0;
}
