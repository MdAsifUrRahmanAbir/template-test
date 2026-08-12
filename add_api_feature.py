#!/usr/bin/env python3
import os
import sys

def prompt(question, default=None):
    if default:
        res = input(f"{question} [{default}]: ").strip()
        return res if res else default
    else:
        while True:
            res = input(f"{question}: ").strip()
            if res:
                return res
            print("⚠️ This field is required.")

def main():
    print("=" * 60)
    print("🚀 Flutter API Feature Automator")
    print("=" * 60)

    # 1. Streamlined Inputs
    section_name = prompt("Enter section_name (lowercase, e.g. login, edit_profile, home, forget_password)").lower()
    model_name = prompt("Enter model_name (e.g. ProductsModel, LoginModel, EditProfileModel)")
    endpoint = prompt("Enter endpoint (e.g. productsUrl, loginUrl, editProfile)")

    print("\nSelect HTTP Method:")
    print("  1. GET")
    print("  2. POST")
    print("  3. PUT")
    print("  4. DELETE")
    choice = prompt("Select option (1-4)", "1")
    http_methods = {"1": "get", "2": "post", "3": "put", "4": "delete"}
    http_verb = http_methods.get(choice, "get")

    # Automatically derive method name according to ModelName and HTTP verb (ignoring section_name)
    clean_model = model_name.replace("Model", "").strip()
    camel_model = clean_model[0].lower() + clean_model[1:] if clean_model else ""

    if http_verb == "get":
        method_name = f"get{clean_model}"
    elif http_verb == "post":
        if "login" in clean_model.lower():
            method_name = "login"
        else:
            method_name = camel_model
    elif http_verb == "put":
        method_name = f"update{clean_model}"
    elif http_verb == "delete":
        method_name = f"delete{clean_model}"
    else:
        method_name = camel_model

    print(f"💡 Automatically derived method name: {method_name}")

    # Determine if body data is needed (POST, PUT, PATCH)
    needs_data = http_verb in ["post", "put", "patch"]

    # Parameters setup
    repo_params = "{required Map<String, dynamic> data}" if needs_data else ""
    client_args = f"ApiEndpoints.{endpoint}, data: data" if needs_data else f"ApiEndpoints.{endpoint}"
    repo_call_args = "data: data" if needs_data else ""

    # 2. Determine file paths using current working directory (project root)
    base_dir = os.getcwd()

    repo_path = os.path.join(base_dir, "lib", "features", section_name, "data", "repositories", f"{section_name}_repository.dart")
    controller_path = os.path.join(base_dir, "lib", "features", section_name, "presentation", "controllers", f"{section_name}_controller.dart")

    print(f"📂 Target Repository: {repo_path}")
    print(f"📂 Target Controller: {controller_path}")

    # Names for repository and provider classes
    repo_class_name = "".join([w.capitalize() for w in section_name.split("_")]) + "Repository"
    repo_provider_name = f"{section_name}RepositoryProvider"

    # 3. Generate Repository Method Code
    repo_method_code = f"""
  // AUTO-GENERATED API METHOD
  Future<{model_name}> {method_name}({repo_params}) async {{
    final response = await _apiClient.{http_verb}({client_args});
    return {model_name}.fromJson(response.data);
  }}
"""

    # 4. Generate Controller Action Code
    controller_action_code = f"""
  // AUTO-GENERATED CONTROLLER ACTION
  Future<void> {method_name}({repo_params}) async {{
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repository.{method_name}({repo_call_args}));
  }}
"""

    # 5. Inject into Repository File
    os.makedirs(os.path.dirname(repo_path), exist_ok=True)
    if os.path.exists(repo_path):
        with open(repo_path, "r", encoding="utf-8") as f:
            repo_content = f.read()

        last_brace_idx = repo_content.rfind("}")
        if last_brace_idx != -1:
            repo_content = repo_content[:last_brace_idx] + repo_method_code + "\n}\n"
            with open(repo_path, "w", encoding="utf-8") as f:
                f.write(repo_content)
            print(f"✅ Successfully injected method into repository: {repo_path}")
        else:
            print(f"❌ Could not find closing brace in {repo_path}")
    else:
        print(f"⚠️ Repository file not found. Creating new file...")
        new_repo_content = f"""import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/constants/api_endpoints.dart';

final {repo_provider_name} = Provider<{repo_class_name}>((ref) {{
  return {repo_class_name}(ref.watch(apiClientProvider));
}});

class {repo_class_name} {{
  final ApiClient _apiClient;
  {repo_class_name}(this._apiClient);
{repo_method_code}
}}
"""
        with open(repo_path, "w", encoding="utf-8") as f:
            f.write(new_repo_content)
        print(f"✅ Created and populated repository: {repo_path}")

    # 6. Inject into Controller File
    os.makedirs(os.path.dirname(controller_path), exist_ok=True)
    if os.path.exists(controller_path):
        with open(controller_path, "r", encoding="utf-8") as f:
            ctrl_content = f.read()

        # Check if repo import exists, add if missing
        repo_import = f"import '../../data/repositories/{section_name}_repository.dart';"
        if repo_import not in ctrl_content:
            ctrl_content = repo_import + "\n" + ctrl_content

        # Check if _repository getter exists, add if missing
        if "_repository" not in ctrl_content:
            class_brace_idx = ctrl_content.find("{")
            if class_brace_idx != -1:
                getter_code = f"\n  {repo_class_name} get _repository => ref.read({repo_provider_name});\n"
                ctrl_content = ctrl_content[:class_brace_idx + 1] + getter_code + ctrl_content[class_brace_idx + 1:]

        last_brace_idx = ctrl_content.rfind("}")
        if last_brace_idx != -1:
            ctrl_content = ctrl_content[:last_brace_idx] + controller_action_code + "\n}\n"
            with open(controller_path, "w", encoding="utf-8") as f:
                f.write(ctrl_content)
            print(f"✅ Successfully injected action and ensured _repository getter in controller: {controller_path}")
        else:
            print(f"❌ Could not find closing brace in {controller_path}")
    else:
        print(f"⚠️ Controller file not found. Creating new file...")
        class_name = "".join([w.capitalize() for w in section_name.split("_")]) + "Controller"
        provider_name = f"{section_name}ControllerProvider"

        new_ctrl_content = f"""import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/{section_name}_repository.dart';

class {class_name} extends Notifier<AsyncValue<{model_name}?>> {{
  {repo_class_name} get _repository => ref.read({repo_provider_name});

  @override
  AsyncValue<{model_name}?> build() => const AsyncValue.data(null);
{controller_action_code}
}}

final {provider_name} = NotifierProvider<{class_name}, AsyncValue<{model_name}?>>({class_name}.new);
"""
        with open(controller_path, "w", encoding="utf-8") as f:
            f.write(new_ctrl_content)
        print(f"✅ Created and populated controller: {controller_path}")

    print("\n🎉 API Feature successfully added and wired up!")

if __name__ == "__main__":
    main()
