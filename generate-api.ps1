Write-Host "🚀 Generating Flutter API from http://localhost:8080/v3/api-docs..."

# Clean old generated code
Remove-Item -Recurse -Force lib\api

# Generate API client
npx @openapitools/openapi-generator-cli generate `
  -i http://localhost:8080/v3/api-docs `
  -g dart-dio `
  -o lib\api `
  --additional-properties pubName=todo_api_client,useEnumExtension=true

Write-Host "✅ Code generated in lib/api/"
Write-Host "📦 Installing dependencies..."

# Install generated package dependencies
cd lib\api
flutter pub get
cd ../..

Write-Host ""
Write-Host "✨ DONE! Generated files are in lib/api/"
Write-Host ""
Write-Host "📝 Usage:"
Write-Host "import 'package:your_app/api/lib/api.dart';"
Write-Host ""
Write-Host "final authApi = AuthenticationApi();"
Write-Host "authApi.apiClient.basePath = 'http://localhost:8080';"
