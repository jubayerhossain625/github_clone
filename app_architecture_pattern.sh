#!/bin/bash

echo "🚀 Creating Clean Architecture Folder Structure..."

# Core layer
mkdir -p lib/core/network
mkdir -p lib/core/local
mkdir -p lib/core/theme
mkdir -p lib/core/utils
mkdir -p lib/core/error

# Features layer
mkdir -p lib/features/repositories/data/models
mkdir -p lib/features/repositories/data/datasource
mkdir -p lib/features/repositories/data/repository

mkdir -p lib/features/repositories/domain/entities
mkdir -p lib/features/repositories/domain/repository
mkdir -p lib/features/repositories/domain/usecases

mkdir -p lib/features/repositories/presentation/pages
mkdir -p lib/features/repositories/presentation/widgets
mkdir -p lib/features/repositories/presentation/providers

# App entry
mkdir -p lib/app

# Create empty Dart files (optional but helpful)
touch lib/core/network/github_api_service.dart
touch lib/core/local/local_storage_service.dart
touch lib/core/theme/app_theme.dart
touch lib/core/utils/date_formatter.dart
touch lib/core/error/failures.dart

touch lib/features/repositories/data/models/repository_model.dart
touch lib/features/repositories/data/datasource/remote_datasource.dart
touch lib/features/repositories/data/datasource/local_datasource.dart
touch lib/features/repositories/data/repository/repository_impl.dart

touch lib/features/repositories/domain/entities/repository_entity.dart
touch lib/features/repositories/domain/repository/repository.dart
touch lib/features/repositories/domain/usecases/get_repositories_usecase.dart

touch lib/features/repositories/presentation/pages/home_page.dart
touch lib/features/repositories/presentation/pages/repository_details_page.dart
touch lib/features/repositories/presentation/widgets/repository_tile.dart
touch lib/features/repositories/presentation/providers/repository_provider.dart
touch lib/features/repositories/presentation/providers/sort_provider.dart

touch lib/app/app.dart
touch lib/main.dart

echo "✅ Architecture created successfully!"