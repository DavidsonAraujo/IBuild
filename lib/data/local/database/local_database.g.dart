// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

// ignore_for_file: type=lint
class $ItensLocalTable extends ItensLocal
    with TableInfo<$ItensLocalTable, ItensLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItensLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _subprojetoIdMeta =
      const VerificationMeta('subprojetoId');
  @override
  late final GeneratedColumn<String> subprojetoId = GeneratedColumn<String>(
      'subprojeto_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<String> tag = GeneratedColumn<String>(
      'tag', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _grupoMeta = const VerificationMeta('grupo');
  @override
  late final GeneratedColumn<String> grupo = GeneratedColumn<String>(
      'grupo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _subgrupoMeta =
      const VerificationMeta('subgrupo');
  @override
  late final GeneratedColumn<String> subgrupo = GeneratedColumn<String>(
      'subgrupo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _componenteMeta =
      const VerificationMeta('componente');
  @override
  late final GeneratedColumn<String> componente = GeneratedColumn<String>(
      'componente', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  @override
  late final GeneratedColumn<String> descricao = GeneratedColumn<String>(
      'descricao', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _diametroMeta =
      const VerificationMeta('diametro');
  @override
  late final GeneratedColumn<String> diametro = GeneratedColumn<String>(
      'diametro', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pendente'));
  static const VerificationMeta _revisaoAtualMeta =
      const VerificationMeta('revisaoAtual');
  @override
  late final GeneratedColumn<String> revisaoAtual = GeneratedColumn<String>(
      'revisao_atual', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _atualizadoEmMeta =
      const VerificationMeta('atualizadoEm');
  @override
  late final GeneratedColumn<DateTime> atualizadoEm = GeneratedColumn<DateTime>(
      'atualizado_em', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
        subprojetoId,
        tag,
        grupo,
        subgrupo,
        componente,
        descricao,
        diametro,
        status,
        revisaoAtual,
        atualizadoEm
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'itens_local';
  @override
  VerificationContext validateIntegrity(Insertable<ItensLocalData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('subprojeto_id')) {
      context.handle(
          _subprojetoIdMeta,
          subprojetoId.isAcceptableOrUnknown(
              data['subprojeto_id']!, _subprojetoIdMeta));
    } else if (isInserting) {
      context.missing(_subprojetoIdMeta);
    }
    if (data.containsKey('tag')) {
      context.handle(
          _tagMeta, tag.isAcceptableOrUnknown(data['tag']!, _tagMeta));
    } else if (isInserting) {
      context.missing(_tagMeta);
    }
    if (data.containsKey('grupo')) {
      context.handle(
          _grupoMeta, grupo.isAcceptableOrUnknown(data['grupo']!, _grupoMeta));
    }
    if (data.containsKey('subgrupo')) {
      context.handle(_subgrupoMeta,
          subgrupo.isAcceptableOrUnknown(data['subgrupo']!, _subgrupoMeta));
    }
    if (data.containsKey('componente')) {
      context.handle(
          _componenteMeta,
          componente.isAcceptableOrUnknown(
              data['componente']!, _componenteMeta));
    }
    if (data.containsKey('descricao')) {
      context.handle(_descricaoMeta,
          descricao.isAcceptableOrUnknown(data['descricao']!, _descricaoMeta));
    }
    if (data.containsKey('diametro')) {
      context.handle(_diametroMeta,
          diametro.isAcceptableOrUnknown(data['diametro']!, _diametroMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('revisao_atual')) {
      context.handle(
          _revisaoAtualMeta,
          revisaoAtual.isAcceptableOrUnknown(
              data['revisao_atual']!, _revisaoAtualMeta));
    }
    if (data.containsKey('atualizado_em')) {
      context.handle(
          _atualizadoEmMeta,
          atualizadoEm.isAcceptableOrUnknown(
              data['atualizado_em']!, _atualizadoEmMeta));
    } else if (isInserting) {
      context.missing(_atualizadoEmMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ItensLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItensLocalData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      subprojetoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subprojeto_id'])!,
      tag: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tag'])!,
      grupo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}grupo']),
      subgrupo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subgrupo']),
      componente: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}componente']),
      descricao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descricao']),
      diametro: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}diametro']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      revisaoAtual: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}revisao_atual']),
      atualizadoEm: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}atualizado_em'])!,
    );
  }

  @override
  $ItensLocalTable createAlias(String alias) {
    return $ItensLocalTable(attachedDatabase, alias);
  }
}

class ItensLocalData extends DataClass implements Insertable<ItensLocalData> {
  final String id;
  final String tenantId;
  final String subprojetoId;
  final String tag;
  final String? grupo;
  final String? subgrupo;
  final String? componente;
  final String? descricao;
  final String? diametro;
  final String status;
  final String? revisaoAtual;
  final DateTime atualizadoEm;
  const ItensLocalData(
      {required this.id,
      required this.tenantId,
      required this.subprojetoId,
      required this.tag,
      this.grupo,
      this.subgrupo,
      this.componente,
      this.descricao,
      this.diametro,
      required this.status,
      this.revisaoAtual,
      required this.atualizadoEm});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['subprojeto_id'] = Variable<String>(subprojetoId);
    map['tag'] = Variable<String>(tag);
    if (!nullToAbsent || grupo != null) {
      map['grupo'] = Variable<String>(grupo);
    }
    if (!nullToAbsent || subgrupo != null) {
      map['subgrupo'] = Variable<String>(subgrupo);
    }
    if (!nullToAbsent || componente != null) {
      map['componente'] = Variable<String>(componente);
    }
    if (!nullToAbsent || descricao != null) {
      map['descricao'] = Variable<String>(descricao);
    }
    if (!nullToAbsent || diametro != null) {
      map['diametro'] = Variable<String>(diametro);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || revisaoAtual != null) {
      map['revisao_atual'] = Variable<String>(revisaoAtual);
    }
    map['atualizado_em'] = Variable<DateTime>(atualizadoEm);
    return map;
  }

  ItensLocalCompanion toCompanion(bool nullToAbsent) {
    return ItensLocalCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      subprojetoId: Value(subprojetoId),
      tag: Value(tag),
      grupo:
          grupo == null && nullToAbsent ? const Value.absent() : Value(grupo),
      subgrupo: subgrupo == null && nullToAbsent
          ? const Value.absent()
          : Value(subgrupo),
      componente: componente == null && nullToAbsent
          ? const Value.absent()
          : Value(componente),
      descricao: descricao == null && nullToAbsent
          ? const Value.absent()
          : Value(descricao),
      diametro: diametro == null && nullToAbsent
          ? const Value.absent()
          : Value(diametro),
      status: Value(status),
      revisaoAtual: revisaoAtual == null && nullToAbsent
          ? const Value.absent()
          : Value(revisaoAtual),
      atualizadoEm: Value(atualizadoEm),
    );
  }

  factory ItensLocalData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItensLocalData(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      subprojetoId: serializer.fromJson<String>(json['subprojetoId']),
      tag: serializer.fromJson<String>(json['tag']),
      grupo: serializer.fromJson<String?>(json['grupo']),
      subgrupo: serializer.fromJson<String?>(json['subgrupo']),
      componente: serializer.fromJson<String?>(json['componente']),
      descricao: serializer.fromJson<String?>(json['descricao']),
      diametro: serializer.fromJson<String?>(json['diametro']),
      status: serializer.fromJson<String>(json['status']),
      revisaoAtual: serializer.fromJson<String?>(json['revisaoAtual']),
      atualizadoEm: serializer.fromJson<DateTime>(json['atualizadoEm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'subprojetoId': serializer.toJson<String>(subprojetoId),
      'tag': serializer.toJson<String>(tag),
      'grupo': serializer.toJson<String?>(grupo),
      'subgrupo': serializer.toJson<String?>(subgrupo),
      'componente': serializer.toJson<String?>(componente),
      'descricao': serializer.toJson<String?>(descricao),
      'diametro': serializer.toJson<String?>(diametro),
      'status': serializer.toJson<String>(status),
      'revisaoAtual': serializer.toJson<String?>(revisaoAtual),
      'atualizadoEm': serializer.toJson<DateTime>(atualizadoEm),
    };
  }

  ItensLocalData copyWith(
          {String? id,
          String? tenantId,
          String? subprojetoId,
          String? tag,
          Value<String?> grupo = const Value.absent(),
          Value<String?> subgrupo = const Value.absent(),
          Value<String?> componente = const Value.absent(),
          Value<String?> descricao = const Value.absent(),
          Value<String?> diametro = const Value.absent(),
          String? status,
          Value<String?> revisaoAtual = const Value.absent(),
          DateTime? atualizadoEm}) =>
      ItensLocalData(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        subprojetoId: subprojetoId ?? this.subprojetoId,
        tag: tag ?? this.tag,
        grupo: grupo.present ? grupo.value : this.grupo,
        subgrupo: subgrupo.present ? subgrupo.value : this.subgrupo,
        componente: componente.present ? componente.value : this.componente,
        descricao: descricao.present ? descricao.value : this.descricao,
        diametro: diametro.present ? diametro.value : this.diametro,
        status: status ?? this.status,
        revisaoAtual:
            revisaoAtual.present ? revisaoAtual.value : this.revisaoAtual,
        atualizadoEm: atualizadoEm ?? this.atualizadoEm,
      );
  ItensLocalData copyWithCompanion(ItensLocalCompanion data) {
    return ItensLocalData(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      subprojetoId: data.subprojetoId.present
          ? data.subprojetoId.value
          : this.subprojetoId,
      tag: data.tag.present ? data.tag.value : this.tag,
      grupo: data.grupo.present ? data.grupo.value : this.grupo,
      subgrupo: data.subgrupo.present ? data.subgrupo.value : this.subgrupo,
      componente:
          data.componente.present ? data.componente.value : this.componente,
      descricao: data.descricao.present ? data.descricao.value : this.descricao,
      diametro: data.diametro.present ? data.diametro.value : this.diametro,
      status: data.status.present ? data.status.value : this.status,
      revisaoAtual: data.revisaoAtual.present
          ? data.revisaoAtual.value
          : this.revisaoAtual,
      atualizadoEm: data.atualizadoEm.present
          ? data.atualizadoEm.value
          : this.atualizadoEm,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ItensLocalData(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('subprojetoId: $subprojetoId, ')
          ..write('tag: $tag, ')
          ..write('grupo: $grupo, ')
          ..write('subgrupo: $subgrupo, ')
          ..write('componente: $componente, ')
          ..write('descricao: $descricao, ')
          ..write('diametro: $diametro, ')
          ..write('status: $status, ')
          ..write('revisaoAtual: $revisaoAtual, ')
          ..write('atualizadoEm: $atualizadoEm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      tenantId,
      subprojetoId,
      tag,
      grupo,
      subgrupo,
      componente,
      descricao,
      diametro,
      status,
      revisaoAtual,
      atualizadoEm);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItensLocalData &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.subprojetoId == this.subprojetoId &&
          other.tag == this.tag &&
          other.grupo == this.grupo &&
          other.subgrupo == this.subgrupo &&
          other.componente == this.componente &&
          other.descricao == this.descricao &&
          other.diametro == this.diametro &&
          other.status == this.status &&
          other.revisaoAtual == this.revisaoAtual &&
          other.atualizadoEm == this.atualizadoEm);
}

class ItensLocalCompanion extends UpdateCompanion<ItensLocalData> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> subprojetoId;
  final Value<String> tag;
  final Value<String?> grupo;
  final Value<String?> subgrupo;
  final Value<String?> componente;
  final Value<String?> descricao;
  final Value<String?> diametro;
  final Value<String> status;
  final Value<String?> revisaoAtual;
  final Value<DateTime> atualizadoEm;
  final Value<int> rowid;
  const ItensLocalCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.subprojetoId = const Value.absent(),
    this.tag = const Value.absent(),
    this.grupo = const Value.absent(),
    this.subgrupo = const Value.absent(),
    this.componente = const Value.absent(),
    this.descricao = const Value.absent(),
    this.diametro = const Value.absent(),
    this.status = const Value.absent(),
    this.revisaoAtual = const Value.absent(),
    this.atualizadoEm = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ItensLocalCompanion.insert({
    required String id,
    required String tenantId,
    required String subprojetoId,
    required String tag,
    this.grupo = const Value.absent(),
    this.subgrupo = const Value.absent(),
    this.componente = const Value.absent(),
    this.descricao = const Value.absent(),
    this.diametro = const Value.absent(),
    this.status = const Value.absent(),
    this.revisaoAtual = const Value.absent(),
    required DateTime atualizadoEm,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        subprojetoId = Value(subprojetoId),
        tag = Value(tag),
        atualizadoEm = Value(atualizadoEm);
  static Insertable<ItensLocalData> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? subprojetoId,
    Expression<String>? tag,
    Expression<String>? grupo,
    Expression<String>? subgrupo,
    Expression<String>? componente,
    Expression<String>? descricao,
    Expression<String>? diametro,
    Expression<String>? status,
    Expression<String>? revisaoAtual,
    Expression<DateTime>? atualizadoEm,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (subprojetoId != null) 'subprojeto_id': subprojetoId,
      if (tag != null) 'tag': tag,
      if (grupo != null) 'grupo': grupo,
      if (subgrupo != null) 'subgrupo': subgrupo,
      if (componente != null) 'componente': componente,
      if (descricao != null) 'descricao': descricao,
      if (diametro != null) 'diametro': diametro,
      if (status != null) 'status': status,
      if (revisaoAtual != null) 'revisao_atual': revisaoAtual,
      if (atualizadoEm != null) 'atualizado_em': atualizadoEm,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ItensLocalCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? subprojetoId,
      Value<String>? tag,
      Value<String?>? grupo,
      Value<String?>? subgrupo,
      Value<String?>? componente,
      Value<String?>? descricao,
      Value<String?>? diametro,
      Value<String>? status,
      Value<String?>? revisaoAtual,
      Value<DateTime>? atualizadoEm,
      Value<int>? rowid}) {
    return ItensLocalCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      subprojetoId: subprojetoId ?? this.subprojetoId,
      tag: tag ?? this.tag,
      grupo: grupo ?? this.grupo,
      subgrupo: subgrupo ?? this.subgrupo,
      componente: componente ?? this.componente,
      descricao: descricao ?? this.descricao,
      diametro: diametro ?? this.diametro,
      status: status ?? this.status,
      revisaoAtual: revisaoAtual ?? this.revisaoAtual,
      atualizadoEm: atualizadoEm ?? this.atualizadoEm,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (subprojetoId.present) {
      map['subprojeto_id'] = Variable<String>(subprojetoId.value);
    }
    if (tag.present) {
      map['tag'] = Variable<String>(tag.value);
    }
    if (grupo.present) {
      map['grupo'] = Variable<String>(grupo.value);
    }
    if (subgrupo.present) {
      map['subgrupo'] = Variable<String>(subgrupo.value);
    }
    if (componente.present) {
      map['componente'] = Variable<String>(componente.value);
    }
    if (descricao.present) {
      map['descricao'] = Variable<String>(descricao.value);
    }
    if (diametro.present) {
      map['diametro'] = Variable<String>(diametro.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (revisaoAtual.present) {
      map['revisao_atual'] = Variable<String>(revisaoAtual.value);
    }
    if (atualizadoEm.present) {
      map['atualizado_em'] = Variable<DateTime>(atualizadoEm.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItensLocalCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('subprojetoId: $subprojetoId, ')
          ..write('tag: $tag, ')
          ..write('grupo: $grupo, ')
          ..write('subgrupo: $subgrupo, ')
          ..write('componente: $componente, ')
          ..write('descricao: $descricao, ')
          ..write('diametro: $diametro, ')
          ..write('status: $status, ')
          ..write('revisaoAtual: $revisaoAtual, ')
          ..write('atualizadoEm: $atualizadoEm, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EventosLocalTable extends EventosLocal
    with TableInfo<$EventosLocalTable, EventosLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventosLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _faseIdMeta = const VerificationMeta('faseId');
  @override
  late final GeneratedColumn<String> faseId = GeneratedColumn<String>(
      'fase_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<String> codigo = GeneratedColumn<String>(
      'codigo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _percentualMeta =
      const VerificationMeta('percentual');
  @override
  late final GeneratedColumn<double> percentual = GeneratedColumn<double>(
      'percentual', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _ordemMeta = const VerificationMeta('ordem');
  @override
  late final GeneratedColumn<int> ordem = GeneratedColumn<int>(
      'ordem', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _ativoMeta = const VerificationMeta('ativo');
  @override
  late final GeneratedColumn<bool> ativo = GeneratedColumn<bool>(
      'ativo', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("ativo" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns =>
      [id, tenantId, faseId, codigo, nome, percentual, ordem, ativo];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'eventos_local';
  @override
  VerificationContext validateIntegrity(Insertable<EventosLocalData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('fase_id')) {
      context.handle(_faseIdMeta,
          faseId.isAcceptableOrUnknown(data['fase_id']!, _faseIdMeta));
    } else if (isInserting) {
      context.missing(_faseIdMeta);
    }
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    } else if (isInserting) {
      context.missing(_codigoMeta);
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('percentual')) {
      context.handle(
          _percentualMeta,
          percentual.isAcceptableOrUnknown(
              data['percentual']!, _percentualMeta));
    }
    if (data.containsKey('ordem')) {
      context.handle(
          _ordemMeta, ordem.isAcceptableOrUnknown(data['ordem']!, _ordemMeta));
    }
    if (data.containsKey('ativo')) {
      context.handle(
          _ativoMeta, ativo.isAcceptableOrUnknown(data['ativo']!, _ativoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventosLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventosLocalData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      faseId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fase_id'])!,
      codigo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}codigo'])!,
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
      percentual: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}percentual']),
      ordem: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ordem'])!,
      ativo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}ativo'])!,
    );
  }

  @override
  $EventosLocalTable createAlias(String alias) {
    return $EventosLocalTable(attachedDatabase, alias);
  }
}

class EventosLocalData extends DataClass
    implements Insertable<EventosLocalData> {
  final String id;
  final String tenantId;
  final String faseId;
  final String codigo;
  final String nome;
  final double? percentual;
  final int ordem;
  final bool ativo;
  const EventosLocalData(
      {required this.id,
      required this.tenantId,
      required this.faseId,
      required this.codigo,
      required this.nome,
      this.percentual,
      required this.ordem,
      required this.ativo});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['fase_id'] = Variable<String>(faseId);
    map['codigo'] = Variable<String>(codigo);
    map['nome'] = Variable<String>(nome);
    if (!nullToAbsent || percentual != null) {
      map['percentual'] = Variable<double>(percentual);
    }
    map['ordem'] = Variable<int>(ordem);
    map['ativo'] = Variable<bool>(ativo);
    return map;
  }

  EventosLocalCompanion toCompanion(bool nullToAbsent) {
    return EventosLocalCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      faseId: Value(faseId),
      codigo: Value(codigo),
      nome: Value(nome),
      percentual: percentual == null && nullToAbsent
          ? const Value.absent()
          : Value(percentual),
      ordem: Value(ordem),
      ativo: Value(ativo),
    );
  }

  factory EventosLocalData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventosLocalData(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      faseId: serializer.fromJson<String>(json['faseId']),
      codigo: serializer.fromJson<String>(json['codigo']),
      nome: serializer.fromJson<String>(json['nome']),
      percentual: serializer.fromJson<double?>(json['percentual']),
      ordem: serializer.fromJson<int>(json['ordem']),
      ativo: serializer.fromJson<bool>(json['ativo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'faseId': serializer.toJson<String>(faseId),
      'codigo': serializer.toJson<String>(codigo),
      'nome': serializer.toJson<String>(nome),
      'percentual': serializer.toJson<double?>(percentual),
      'ordem': serializer.toJson<int>(ordem),
      'ativo': serializer.toJson<bool>(ativo),
    };
  }

  EventosLocalData copyWith(
          {String? id,
          String? tenantId,
          String? faseId,
          String? codigo,
          String? nome,
          Value<double?> percentual = const Value.absent(),
          int? ordem,
          bool? ativo}) =>
      EventosLocalData(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        faseId: faseId ?? this.faseId,
        codigo: codigo ?? this.codigo,
        nome: nome ?? this.nome,
        percentual: percentual.present ? percentual.value : this.percentual,
        ordem: ordem ?? this.ordem,
        ativo: ativo ?? this.ativo,
      );
  EventosLocalData copyWithCompanion(EventosLocalCompanion data) {
    return EventosLocalData(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      faseId: data.faseId.present ? data.faseId.value : this.faseId,
      codigo: data.codigo.present ? data.codigo.value : this.codigo,
      nome: data.nome.present ? data.nome.value : this.nome,
      percentual:
          data.percentual.present ? data.percentual.value : this.percentual,
      ordem: data.ordem.present ? data.ordem.value : this.ordem,
      ativo: data.ativo.present ? data.ativo.value : this.ativo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventosLocalData(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('faseId: $faseId, ')
          ..write('codigo: $codigo, ')
          ..write('nome: $nome, ')
          ..write('percentual: $percentual, ')
          ..write('ordem: $ordem, ')
          ..write('ativo: $ativo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, tenantId, faseId, codigo, nome, percentual, ordem, ativo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventosLocalData &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.faseId == this.faseId &&
          other.codigo == this.codigo &&
          other.nome == this.nome &&
          other.percentual == this.percentual &&
          other.ordem == this.ordem &&
          other.ativo == this.ativo);
}

class EventosLocalCompanion extends UpdateCompanion<EventosLocalData> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> faseId;
  final Value<String> codigo;
  final Value<String> nome;
  final Value<double?> percentual;
  final Value<int> ordem;
  final Value<bool> ativo;
  final Value<int> rowid;
  const EventosLocalCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.faseId = const Value.absent(),
    this.codigo = const Value.absent(),
    this.nome = const Value.absent(),
    this.percentual = const Value.absent(),
    this.ordem = const Value.absent(),
    this.ativo = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EventosLocalCompanion.insert({
    required String id,
    required String tenantId,
    required String faseId,
    required String codigo,
    required String nome,
    this.percentual = const Value.absent(),
    this.ordem = const Value.absent(),
    this.ativo = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        faseId = Value(faseId),
        codigo = Value(codigo),
        nome = Value(nome);
  static Insertable<EventosLocalData> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? faseId,
    Expression<String>? codigo,
    Expression<String>? nome,
    Expression<double>? percentual,
    Expression<int>? ordem,
    Expression<bool>? ativo,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (faseId != null) 'fase_id': faseId,
      if (codigo != null) 'codigo': codigo,
      if (nome != null) 'nome': nome,
      if (percentual != null) 'percentual': percentual,
      if (ordem != null) 'ordem': ordem,
      if (ativo != null) 'ativo': ativo,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EventosLocalCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? faseId,
      Value<String>? codigo,
      Value<String>? nome,
      Value<double?>? percentual,
      Value<int>? ordem,
      Value<bool>? ativo,
      Value<int>? rowid}) {
    return EventosLocalCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      faseId: faseId ?? this.faseId,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
      percentual: percentual ?? this.percentual,
      ordem: ordem ?? this.ordem,
      ativo: ativo ?? this.ativo,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (faseId.present) {
      map['fase_id'] = Variable<String>(faseId.value);
    }
    if (codigo.present) {
      map['codigo'] = Variable<String>(codigo.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (percentual.present) {
      map['percentual'] = Variable<double>(percentual.value);
    }
    if (ordem.present) {
      map['ordem'] = Variable<int>(ordem.value);
    }
    if (ativo.present) {
      map['ativo'] = Variable<bool>(ativo.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventosLocalCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('faseId: $faseId, ')
          ..write('codigo: $codigo, ')
          ..write('nome: $nome, ')
          ..write('percentual: $percentual, ')
          ..write('ordem: $ordem, ')
          ..write('ativo: $ativo, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FolhasTarefaLocalTable extends FolhasTarefaLocal
    with TableInfo<$FolhasTarefaLocalTable, FolhasTarefaLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FolhasTarefaLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _osIdMeta = const VerificationMeta('osId');
  @override
  late final GeneratedColumn<String> osId = GeneratedColumn<String>(
      'os_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _subprojetoIdMeta =
      const VerificationMeta('subprojetoId');
  @override
  late final GeneratedColumn<String> subprojetoId = GeneratedColumn<String>(
      'subprojeto_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _periodoIdMeta =
      const VerificationMeta('periodoId');
  @override
  late final GeneratedColumn<String> periodoId = GeneratedColumn<String>(
      'periodo_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sequencialMeta =
      const VerificationMeta('sequencial');
  @override
  late final GeneratedColumn<String> sequencial = GeneratedColumn<String>(
      'sequencial', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('aberta'));
  static const VerificationMeta _dataInicioMeta =
      const VerificationMeta('dataInicio');
  @override
  late final GeneratedColumn<DateTime> dataInicio = GeneratedColumn<DateTime>(
      'data_inicio', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _dataFimMeta =
      const VerificationMeta('dataFim');
  @override
  late final GeneratedColumn<DateTime> dataFim = GeneratedColumn<DateTime>(
      'data_fim', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
        osId,
        subprojetoId,
        periodoId,
        sequencial,
        status,
        dataInicio,
        dataFim
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'folhas_tarefa_local';
  @override
  VerificationContext validateIntegrity(
      Insertable<FolhasTarefaLocalData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('os_id')) {
      context.handle(
          _osIdMeta, osId.isAcceptableOrUnknown(data['os_id']!, _osIdMeta));
    } else if (isInserting) {
      context.missing(_osIdMeta);
    }
    if (data.containsKey('subprojeto_id')) {
      context.handle(
          _subprojetoIdMeta,
          subprojetoId.isAcceptableOrUnknown(
              data['subprojeto_id']!, _subprojetoIdMeta));
    } else if (isInserting) {
      context.missing(_subprojetoIdMeta);
    }
    if (data.containsKey('periodo_id')) {
      context.handle(_periodoIdMeta,
          periodoId.isAcceptableOrUnknown(data['periodo_id']!, _periodoIdMeta));
    } else if (isInserting) {
      context.missing(_periodoIdMeta);
    }
    if (data.containsKey('sequencial')) {
      context.handle(
          _sequencialMeta,
          sequencial.isAcceptableOrUnknown(
              data['sequencial']!, _sequencialMeta));
    } else if (isInserting) {
      context.missing(_sequencialMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('data_inicio')) {
      context.handle(
          _dataInicioMeta,
          dataInicio.isAcceptableOrUnknown(
              data['data_inicio']!, _dataInicioMeta));
    }
    if (data.containsKey('data_fim')) {
      context.handle(_dataFimMeta,
          dataFim.isAcceptableOrUnknown(data['data_fim']!, _dataFimMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FolhasTarefaLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FolhasTarefaLocalData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      osId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}os_id'])!,
      subprojetoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subprojeto_id'])!,
      periodoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}periodo_id'])!,
      sequencial: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sequencial'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      dataInicio: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_inicio']),
      dataFim: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_fim']),
    );
  }

  @override
  $FolhasTarefaLocalTable createAlias(String alias) {
    return $FolhasTarefaLocalTable(attachedDatabase, alias);
  }
}

class FolhasTarefaLocalData extends DataClass
    implements Insertable<FolhasTarefaLocalData> {
  final String id;
  final String tenantId;
  final String osId;
  final String subprojetoId;
  final String periodoId;
  final String sequencial;
  final String status;
  final DateTime? dataInicio;
  final DateTime? dataFim;
  const FolhasTarefaLocalData(
      {required this.id,
      required this.tenantId,
      required this.osId,
      required this.subprojetoId,
      required this.periodoId,
      required this.sequencial,
      required this.status,
      this.dataInicio,
      this.dataFim});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['os_id'] = Variable<String>(osId);
    map['subprojeto_id'] = Variable<String>(subprojetoId);
    map['periodo_id'] = Variable<String>(periodoId);
    map['sequencial'] = Variable<String>(sequencial);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || dataInicio != null) {
      map['data_inicio'] = Variable<DateTime>(dataInicio);
    }
    if (!nullToAbsent || dataFim != null) {
      map['data_fim'] = Variable<DateTime>(dataFim);
    }
    return map;
  }

  FolhasTarefaLocalCompanion toCompanion(bool nullToAbsent) {
    return FolhasTarefaLocalCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      osId: Value(osId),
      subprojetoId: Value(subprojetoId),
      periodoId: Value(periodoId),
      sequencial: Value(sequencial),
      status: Value(status),
      dataInicio: dataInicio == null && nullToAbsent
          ? const Value.absent()
          : Value(dataInicio),
      dataFim: dataFim == null && nullToAbsent
          ? const Value.absent()
          : Value(dataFim),
    );
  }

  factory FolhasTarefaLocalData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FolhasTarefaLocalData(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      osId: serializer.fromJson<String>(json['osId']),
      subprojetoId: serializer.fromJson<String>(json['subprojetoId']),
      periodoId: serializer.fromJson<String>(json['periodoId']),
      sequencial: serializer.fromJson<String>(json['sequencial']),
      status: serializer.fromJson<String>(json['status']),
      dataInicio: serializer.fromJson<DateTime?>(json['dataInicio']),
      dataFim: serializer.fromJson<DateTime?>(json['dataFim']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'osId': serializer.toJson<String>(osId),
      'subprojetoId': serializer.toJson<String>(subprojetoId),
      'periodoId': serializer.toJson<String>(periodoId),
      'sequencial': serializer.toJson<String>(sequencial),
      'status': serializer.toJson<String>(status),
      'dataInicio': serializer.toJson<DateTime?>(dataInicio),
      'dataFim': serializer.toJson<DateTime?>(dataFim),
    };
  }

  FolhasTarefaLocalData copyWith(
          {String? id,
          String? tenantId,
          String? osId,
          String? subprojetoId,
          String? periodoId,
          String? sequencial,
          String? status,
          Value<DateTime?> dataInicio = const Value.absent(),
          Value<DateTime?> dataFim = const Value.absent()}) =>
      FolhasTarefaLocalData(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        osId: osId ?? this.osId,
        subprojetoId: subprojetoId ?? this.subprojetoId,
        periodoId: periodoId ?? this.periodoId,
        sequencial: sequencial ?? this.sequencial,
        status: status ?? this.status,
        dataInicio: dataInicio.present ? dataInicio.value : this.dataInicio,
        dataFim: dataFim.present ? dataFim.value : this.dataFim,
      );
  FolhasTarefaLocalData copyWithCompanion(FolhasTarefaLocalCompanion data) {
    return FolhasTarefaLocalData(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      osId: data.osId.present ? data.osId.value : this.osId,
      subprojetoId: data.subprojetoId.present
          ? data.subprojetoId.value
          : this.subprojetoId,
      periodoId: data.periodoId.present ? data.periodoId.value : this.periodoId,
      sequencial:
          data.sequencial.present ? data.sequencial.value : this.sequencial,
      status: data.status.present ? data.status.value : this.status,
      dataInicio:
          data.dataInicio.present ? data.dataInicio.value : this.dataInicio,
      dataFim: data.dataFim.present ? data.dataFim.value : this.dataFim,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FolhasTarefaLocalData(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('osId: $osId, ')
          ..write('subprojetoId: $subprojetoId, ')
          ..write('periodoId: $periodoId, ')
          ..write('sequencial: $sequencial, ')
          ..write('status: $status, ')
          ..write('dataInicio: $dataInicio, ')
          ..write('dataFim: $dataFim')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tenantId, osId, subprojetoId, periodoId,
      sequencial, status, dataInicio, dataFim);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FolhasTarefaLocalData &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.osId == this.osId &&
          other.subprojetoId == this.subprojetoId &&
          other.periodoId == this.periodoId &&
          other.sequencial == this.sequencial &&
          other.status == this.status &&
          other.dataInicio == this.dataInicio &&
          other.dataFim == this.dataFim);
}

class FolhasTarefaLocalCompanion
    extends UpdateCompanion<FolhasTarefaLocalData> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> osId;
  final Value<String> subprojetoId;
  final Value<String> periodoId;
  final Value<String> sequencial;
  final Value<String> status;
  final Value<DateTime?> dataInicio;
  final Value<DateTime?> dataFim;
  final Value<int> rowid;
  const FolhasTarefaLocalCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.osId = const Value.absent(),
    this.subprojetoId = const Value.absent(),
    this.periodoId = const Value.absent(),
    this.sequencial = const Value.absent(),
    this.status = const Value.absent(),
    this.dataInicio = const Value.absent(),
    this.dataFim = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FolhasTarefaLocalCompanion.insert({
    required String id,
    required String tenantId,
    required String osId,
    required String subprojetoId,
    required String periodoId,
    required String sequencial,
    this.status = const Value.absent(),
    this.dataInicio = const Value.absent(),
    this.dataFim = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        osId = Value(osId),
        subprojetoId = Value(subprojetoId),
        periodoId = Value(periodoId),
        sequencial = Value(sequencial);
  static Insertable<FolhasTarefaLocalData> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? osId,
    Expression<String>? subprojetoId,
    Expression<String>? periodoId,
    Expression<String>? sequencial,
    Expression<String>? status,
    Expression<DateTime>? dataInicio,
    Expression<DateTime>? dataFim,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (osId != null) 'os_id': osId,
      if (subprojetoId != null) 'subprojeto_id': subprojetoId,
      if (periodoId != null) 'periodo_id': periodoId,
      if (sequencial != null) 'sequencial': sequencial,
      if (status != null) 'status': status,
      if (dataInicio != null) 'data_inicio': dataInicio,
      if (dataFim != null) 'data_fim': dataFim,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FolhasTarefaLocalCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? osId,
      Value<String>? subprojetoId,
      Value<String>? periodoId,
      Value<String>? sequencial,
      Value<String>? status,
      Value<DateTime?>? dataInicio,
      Value<DateTime?>? dataFim,
      Value<int>? rowid}) {
    return FolhasTarefaLocalCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      osId: osId ?? this.osId,
      subprojetoId: subprojetoId ?? this.subprojetoId,
      periodoId: periodoId ?? this.periodoId,
      sequencial: sequencial ?? this.sequencial,
      status: status ?? this.status,
      dataInicio: dataInicio ?? this.dataInicio,
      dataFim: dataFim ?? this.dataFim,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (osId.present) {
      map['os_id'] = Variable<String>(osId.value);
    }
    if (subprojetoId.present) {
      map['subprojeto_id'] = Variable<String>(subprojetoId.value);
    }
    if (periodoId.present) {
      map['periodo_id'] = Variable<String>(periodoId.value);
    }
    if (sequencial.present) {
      map['sequencial'] = Variable<String>(sequencial.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (dataInicio.present) {
      map['data_inicio'] = Variable<DateTime>(dataInicio.value);
    }
    if (dataFim.present) {
      map['data_fim'] = Variable<DateTime>(dataFim.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FolhasTarefaLocalCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('osId: $osId, ')
          ..write('subprojetoId: $subprojetoId, ')
          ..write('periodoId: $periodoId, ')
          ..write('sequencial: $sequencial, ')
          ..write('status: $status, ')
          ..write('dataInicio: $dataInicio, ')
          ..write('dataFim: $dataFim, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FolhaTarefaItensLocalTable extends FolhaTarefaItensLocal
    with TableInfo<$FolhaTarefaItensLocalTable, FolhaTarefaItensLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FolhaTarefaItensLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _folhaTarefaIdMeta =
      const VerificationMeta('folhaTarefaId');
  @override
  late final GeneratedColumn<String> folhaTarefaId = GeneratedColumn<String>(
      'folha_tarefa_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
      'item_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _eventoIdMeta =
      const VerificationMeta('eventoId');
  @override
  late final GeneratedColumn<String> eventoId = GeneratedColumn<String>(
      'evento_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _periodoMeta =
      const VerificationMeta('periodo');
  @override
  late final GeneratedColumn<String> periodo = GeneratedColumn<String>(
      'periodo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _prioridadeMeta =
      const VerificationMeta('prioridade');
  @override
  late final GeneratedColumn<int> prioridade = GeneratedColumn<int>(
      'prioridade', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _executadoMeta =
      const VerificationMeta('executado');
  @override
  late final GeneratedColumn<bool> executado = GeneratedColumn<bool>(
      'executado', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("executado" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _ticketIdMeta =
      const VerificationMeta('ticketId');
  @override
  late final GeneratedColumn<String> ticketId = GeneratedColumn<String>(
      'ticket_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
        folhaTarefaId,
        itemId,
        eventoId,
        periodo,
        prioridade,
        executado,
        ticketId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'folha_tarefa_itens_local';
  @override
  VerificationContext validateIntegrity(
      Insertable<FolhaTarefaItensLocalData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('folha_tarefa_id')) {
      context.handle(
          _folhaTarefaIdMeta,
          folhaTarefaId.isAcceptableOrUnknown(
              data['folha_tarefa_id']!, _folhaTarefaIdMeta));
    } else if (isInserting) {
      context.missing(_folhaTarefaIdMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('evento_id')) {
      context.handle(_eventoIdMeta,
          eventoId.isAcceptableOrUnknown(data['evento_id']!, _eventoIdMeta));
    } else if (isInserting) {
      context.missing(_eventoIdMeta);
    }
    if (data.containsKey('periodo')) {
      context.handle(_periodoMeta,
          periodo.isAcceptableOrUnknown(data['periodo']!, _periodoMeta));
    }
    if (data.containsKey('prioridade')) {
      context.handle(
          _prioridadeMeta,
          prioridade.isAcceptableOrUnknown(
              data['prioridade']!, _prioridadeMeta));
    }
    if (data.containsKey('executado')) {
      context.handle(_executadoMeta,
          executado.isAcceptableOrUnknown(data['executado']!, _executadoMeta));
    }
    if (data.containsKey('ticket_id')) {
      context.handle(_ticketIdMeta,
          ticketId.isAcceptableOrUnknown(data['ticket_id']!, _ticketIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FolhaTarefaItensLocalData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FolhaTarefaItensLocalData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      folhaTarefaId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}folha_tarefa_id'])!,
      itemId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_id'])!,
      eventoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}evento_id'])!,
      periodo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}periodo']),
      prioridade: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}prioridade'])!,
      executado: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}executado'])!,
      ticketId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ticket_id']),
    );
  }

  @override
  $FolhaTarefaItensLocalTable createAlias(String alias) {
    return $FolhaTarefaItensLocalTable(attachedDatabase, alias);
  }
}

class FolhaTarefaItensLocalData extends DataClass
    implements Insertable<FolhaTarefaItensLocalData> {
  final String id;
  final String tenantId;
  final String folhaTarefaId;
  final String itemId;
  final String eventoId;
  final String? periodo;
  final int prioridade;
  final bool executado;
  final String? ticketId;
  const FolhaTarefaItensLocalData(
      {required this.id,
      required this.tenantId,
      required this.folhaTarefaId,
      required this.itemId,
      required this.eventoId,
      this.periodo,
      required this.prioridade,
      required this.executado,
      this.ticketId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['folha_tarefa_id'] = Variable<String>(folhaTarefaId);
    map['item_id'] = Variable<String>(itemId);
    map['evento_id'] = Variable<String>(eventoId);
    if (!nullToAbsent || periodo != null) {
      map['periodo'] = Variable<String>(periodo);
    }
    map['prioridade'] = Variable<int>(prioridade);
    map['executado'] = Variable<bool>(executado);
    if (!nullToAbsent || ticketId != null) {
      map['ticket_id'] = Variable<String>(ticketId);
    }
    return map;
  }

  FolhaTarefaItensLocalCompanion toCompanion(bool nullToAbsent) {
    return FolhaTarefaItensLocalCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      folhaTarefaId: Value(folhaTarefaId),
      itemId: Value(itemId),
      eventoId: Value(eventoId),
      periodo: periodo == null && nullToAbsent
          ? const Value.absent()
          : Value(periodo),
      prioridade: Value(prioridade),
      executado: Value(executado),
      ticketId: ticketId == null && nullToAbsent
          ? const Value.absent()
          : Value(ticketId),
    );
  }

  factory FolhaTarefaItensLocalData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FolhaTarefaItensLocalData(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      folhaTarefaId: serializer.fromJson<String>(json['folhaTarefaId']),
      itemId: serializer.fromJson<String>(json['itemId']),
      eventoId: serializer.fromJson<String>(json['eventoId']),
      periodo: serializer.fromJson<String?>(json['periodo']),
      prioridade: serializer.fromJson<int>(json['prioridade']),
      executado: serializer.fromJson<bool>(json['executado']),
      ticketId: serializer.fromJson<String?>(json['ticketId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'folhaTarefaId': serializer.toJson<String>(folhaTarefaId),
      'itemId': serializer.toJson<String>(itemId),
      'eventoId': serializer.toJson<String>(eventoId),
      'periodo': serializer.toJson<String?>(periodo),
      'prioridade': serializer.toJson<int>(prioridade),
      'executado': serializer.toJson<bool>(executado),
      'ticketId': serializer.toJson<String?>(ticketId),
    };
  }

  FolhaTarefaItensLocalData copyWith(
          {String? id,
          String? tenantId,
          String? folhaTarefaId,
          String? itemId,
          String? eventoId,
          Value<String?> periodo = const Value.absent(),
          int? prioridade,
          bool? executado,
          Value<String?> ticketId = const Value.absent()}) =>
      FolhaTarefaItensLocalData(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        folhaTarefaId: folhaTarefaId ?? this.folhaTarefaId,
        itemId: itemId ?? this.itemId,
        eventoId: eventoId ?? this.eventoId,
        periodo: periodo.present ? periodo.value : this.periodo,
        prioridade: prioridade ?? this.prioridade,
        executado: executado ?? this.executado,
        ticketId: ticketId.present ? ticketId.value : this.ticketId,
      );
  FolhaTarefaItensLocalData copyWithCompanion(
      FolhaTarefaItensLocalCompanion data) {
    return FolhaTarefaItensLocalData(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      folhaTarefaId: data.folhaTarefaId.present
          ? data.folhaTarefaId.value
          : this.folhaTarefaId,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      eventoId: data.eventoId.present ? data.eventoId.value : this.eventoId,
      periodo: data.periodo.present ? data.periodo.value : this.periodo,
      prioridade:
          data.prioridade.present ? data.prioridade.value : this.prioridade,
      executado: data.executado.present ? data.executado.value : this.executado,
      ticketId: data.ticketId.present ? data.ticketId.value : this.ticketId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FolhaTarefaItensLocalData(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('folhaTarefaId: $folhaTarefaId, ')
          ..write('itemId: $itemId, ')
          ..write('eventoId: $eventoId, ')
          ..write('periodo: $periodo, ')
          ..write('prioridade: $prioridade, ')
          ..write('executado: $executado, ')
          ..write('ticketId: $ticketId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tenantId, folhaTarefaId, itemId, eventoId,
      periodo, prioridade, executado, ticketId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FolhaTarefaItensLocalData &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.folhaTarefaId == this.folhaTarefaId &&
          other.itemId == this.itemId &&
          other.eventoId == this.eventoId &&
          other.periodo == this.periodo &&
          other.prioridade == this.prioridade &&
          other.executado == this.executado &&
          other.ticketId == this.ticketId);
}

class FolhaTarefaItensLocalCompanion
    extends UpdateCompanion<FolhaTarefaItensLocalData> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> folhaTarefaId;
  final Value<String> itemId;
  final Value<String> eventoId;
  final Value<String?> periodo;
  final Value<int> prioridade;
  final Value<bool> executado;
  final Value<String?> ticketId;
  final Value<int> rowid;
  const FolhaTarefaItensLocalCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.folhaTarefaId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.eventoId = const Value.absent(),
    this.periodo = const Value.absent(),
    this.prioridade = const Value.absent(),
    this.executado = const Value.absent(),
    this.ticketId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FolhaTarefaItensLocalCompanion.insert({
    required String id,
    required String tenantId,
    required String folhaTarefaId,
    required String itemId,
    required String eventoId,
    this.periodo = const Value.absent(),
    this.prioridade = const Value.absent(),
    this.executado = const Value.absent(),
    this.ticketId = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        folhaTarefaId = Value(folhaTarefaId),
        itemId = Value(itemId),
        eventoId = Value(eventoId);
  static Insertable<FolhaTarefaItensLocalData> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? folhaTarefaId,
    Expression<String>? itemId,
    Expression<String>? eventoId,
    Expression<String>? periodo,
    Expression<int>? prioridade,
    Expression<bool>? executado,
    Expression<String>? ticketId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (folhaTarefaId != null) 'folha_tarefa_id': folhaTarefaId,
      if (itemId != null) 'item_id': itemId,
      if (eventoId != null) 'evento_id': eventoId,
      if (periodo != null) 'periodo': periodo,
      if (prioridade != null) 'prioridade': prioridade,
      if (executado != null) 'executado': executado,
      if (ticketId != null) 'ticket_id': ticketId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FolhaTarefaItensLocalCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? folhaTarefaId,
      Value<String>? itemId,
      Value<String>? eventoId,
      Value<String?>? periodo,
      Value<int>? prioridade,
      Value<bool>? executado,
      Value<String?>? ticketId,
      Value<int>? rowid}) {
    return FolhaTarefaItensLocalCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      folhaTarefaId: folhaTarefaId ?? this.folhaTarefaId,
      itemId: itemId ?? this.itemId,
      eventoId: eventoId ?? this.eventoId,
      periodo: periodo ?? this.periodo,
      prioridade: prioridade ?? this.prioridade,
      executado: executado ?? this.executado,
      ticketId: ticketId ?? this.ticketId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (folhaTarefaId.present) {
      map['folha_tarefa_id'] = Variable<String>(folhaTarefaId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (eventoId.present) {
      map['evento_id'] = Variable<String>(eventoId.value);
    }
    if (periodo.present) {
      map['periodo'] = Variable<String>(periodo.value);
    }
    if (prioridade.present) {
      map['prioridade'] = Variable<int>(prioridade.value);
    }
    if (executado.present) {
      map['executado'] = Variable<bool>(executado.value);
    }
    if (ticketId.present) {
      map['ticket_id'] = Variable<String>(ticketId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FolhaTarefaItensLocalCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('folhaTarefaId: $folhaTarefaId, ')
          ..write('itemId: $itemId, ')
          ..write('eventoId: $eventoId, ')
          ..write('periodo: $periodo, ')
          ..write('prioridade: $prioridade, ')
          ..write('executado: $executado, ')
          ..write('ticketId: $ticketId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TicketsLocalTable extends TicketsLocal
    with TableInfo<$TicketsLocalTable, TicketsLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TicketsLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _folhaTarefaIdMeta =
      const VerificationMeta('folhaTarefaId');
  @override
  late final GeneratedColumn<String> folhaTarefaId = GeneratedColumn<String>(
      'folha_tarefa_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _numeroMeta = const VerificationMeta('numero');
  @override
  late final GeneratedColumn<BigInt> numero = GeneratedColumn<BigInt>(
      'numero', aliasedName, false,
      type: DriftSqlType.bigInt, requiredDuringInsert: true);
  static const VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<String> codigo = GeneratedColumn<String>(
      'codigo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _geradoOfflineMeta =
      const VerificationMeta('geradoOffline');
  @override
  late final GeneratedColumn<bool> geradoOffline = GeneratedColumn<bool>(
      'gerado_offline', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("gerado_offline" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _geradoEmMeta =
      const VerificationMeta('geradoEm');
  @override
  late final GeneratedColumn<DateTime> geradoEm = GeneratedColumn<DateTime>(
      'gerado_em', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, tenantId, folhaTarefaId, numero, codigo, geradoOffline, geradoEm];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tickets_local';
  @override
  VerificationContext validateIntegrity(Insertable<TicketsLocalData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('folha_tarefa_id')) {
      context.handle(
          _folhaTarefaIdMeta,
          folhaTarefaId.isAcceptableOrUnknown(
              data['folha_tarefa_id']!, _folhaTarefaIdMeta));
    } else if (isInserting) {
      context.missing(_folhaTarefaIdMeta);
    }
    if (data.containsKey('numero')) {
      context.handle(_numeroMeta,
          numero.isAcceptableOrUnknown(data['numero']!, _numeroMeta));
    } else if (isInserting) {
      context.missing(_numeroMeta);
    }
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    } else if (isInserting) {
      context.missing(_codigoMeta);
    }
    if (data.containsKey('gerado_offline')) {
      context.handle(
          _geradoOfflineMeta,
          geradoOffline.isAcceptableOrUnknown(
              data['gerado_offline']!, _geradoOfflineMeta));
    }
    if (data.containsKey('gerado_em')) {
      context.handle(_geradoEmMeta,
          geradoEm.isAcceptableOrUnknown(data['gerado_em']!, _geradoEmMeta));
    } else if (isInserting) {
      context.missing(_geradoEmMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TicketsLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TicketsLocalData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      folhaTarefaId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}folha_tarefa_id'])!,
      numero: attachedDatabase.typeMapping
          .read(DriftSqlType.bigInt, data['${effectivePrefix}numero'])!,
      codigo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}codigo'])!,
      geradoOffline: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}gerado_offline'])!,
      geradoEm: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}gerado_em'])!,
    );
  }

  @override
  $TicketsLocalTable createAlias(String alias) {
    return $TicketsLocalTable(attachedDatabase, alias);
  }
}

class TicketsLocalData extends DataClass
    implements Insertable<TicketsLocalData> {
  final String id;
  final String tenantId;
  final String folhaTarefaId;
  final BigInt numero;
  final String codigo;
  final bool geradoOffline;
  final DateTime geradoEm;
  const TicketsLocalData(
      {required this.id,
      required this.tenantId,
      required this.folhaTarefaId,
      required this.numero,
      required this.codigo,
      required this.geradoOffline,
      required this.geradoEm});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['folha_tarefa_id'] = Variable<String>(folhaTarefaId);
    map['numero'] = Variable<BigInt>(numero);
    map['codigo'] = Variable<String>(codigo);
    map['gerado_offline'] = Variable<bool>(geradoOffline);
    map['gerado_em'] = Variable<DateTime>(geradoEm);
    return map;
  }

  TicketsLocalCompanion toCompanion(bool nullToAbsent) {
    return TicketsLocalCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      folhaTarefaId: Value(folhaTarefaId),
      numero: Value(numero),
      codigo: Value(codigo),
      geradoOffline: Value(geradoOffline),
      geradoEm: Value(geradoEm),
    );
  }

  factory TicketsLocalData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TicketsLocalData(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      folhaTarefaId: serializer.fromJson<String>(json['folhaTarefaId']),
      numero: serializer.fromJson<BigInt>(json['numero']),
      codigo: serializer.fromJson<String>(json['codigo']),
      geradoOffline: serializer.fromJson<bool>(json['geradoOffline']),
      geradoEm: serializer.fromJson<DateTime>(json['geradoEm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'folhaTarefaId': serializer.toJson<String>(folhaTarefaId),
      'numero': serializer.toJson<BigInt>(numero),
      'codigo': serializer.toJson<String>(codigo),
      'geradoOffline': serializer.toJson<bool>(geradoOffline),
      'geradoEm': serializer.toJson<DateTime>(geradoEm),
    };
  }

  TicketsLocalData copyWith(
          {String? id,
          String? tenantId,
          String? folhaTarefaId,
          BigInt? numero,
          String? codigo,
          bool? geradoOffline,
          DateTime? geradoEm}) =>
      TicketsLocalData(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        folhaTarefaId: folhaTarefaId ?? this.folhaTarefaId,
        numero: numero ?? this.numero,
        codigo: codigo ?? this.codigo,
        geradoOffline: geradoOffline ?? this.geradoOffline,
        geradoEm: geradoEm ?? this.geradoEm,
      );
  TicketsLocalData copyWithCompanion(TicketsLocalCompanion data) {
    return TicketsLocalData(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      folhaTarefaId: data.folhaTarefaId.present
          ? data.folhaTarefaId.value
          : this.folhaTarefaId,
      numero: data.numero.present ? data.numero.value : this.numero,
      codigo: data.codigo.present ? data.codigo.value : this.codigo,
      geradoOffline: data.geradoOffline.present
          ? data.geradoOffline.value
          : this.geradoOffline,
      geradoEm: data.geradoEm.present ? data.geradoEm.value : this.geradoEm,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TicketsLocalData(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('folhaTarefaId: $folhaTarefaId, ')
          ..write('numero: $numero, ')
          ..write('codigo: $codigo, ')
          ..write('geradoOffline: $geradoOffline, ')
          ..write('geradoEm: $geradoEm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, tenantId, folhaTarefaId, numero, codigo, geradoOffline, geradoEm);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TicketsLocalData &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.folhaTarefaId == this.folhaTarefaId &&
          other.numero == this.numero &&
          other.codigo == this.codigo &&
          other.geradoOffline == this.geradoOffline &&
          other.geradoEm == this.geradoEm);
}

class TicketsLocalCompanion extends UpdateCompanion<TicketsLocalData> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> folhaTarefaId;
  final Value<BigInt> numero;
  final Value<String> codigo;
  final Value<bool> geradoOffline;
  final Value<DateTime> geradoEm;
  final Value<int> rowid;
  const TicketsLocalCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.folhaTarefaId = const Value.absent(),
    this.numero = const Value.absent(),
    this.codigo = const Value.absent(),
    this.geradoOffline = const Value.absent(),
    this.geradoEm = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TicketsLocalCompanion.insert({
    required String id,
    required String tenantId,
    required String folhaTarefaId,
    required BigInt numero,
    required String codigo,
    this.geradoOffline = const Value.absent(),
    required DateTime geradoEm,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        folhaTarefaId = Value(folhaTarefaId),
        numero = Value(numero),
        codigo = Value(codigo),
        geradoEm = Value(geradoEm);
  static Insertable<TicketsLocalData> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? folhaTarefaId,
    Expression<BigInt>? numero,
    Expression<String>? codigo,
    Expression<bool>? geradoOffline,
    Expression<DateTime>? geradoEm,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (folhaTarefaId != null) 'folha_tarefa_id': folhaTarefaId,
      if (numero != null) 'numero': numero,
      if (codigo != null) 'codigo': codigo,
      if (geradoOffline != null) 'gerado_offline': geradoOffline,
      if (geradoEm != null) 'gerado_em': geradoEm,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TicketsLocalCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? folhaTarefaId,
      Value<BigInt>? numero,
      Value<String>? codigo,
      Value<bool>? geradoOffline,
      Value<DateTime>? geradoEm,
      Value<int>? rowid}) {
    return TicketsLocalCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      folhaTarefaId: folhaTarefaId ?? this.folhaTarefaId,
      numero: numero ?? this.numero,
      codigo: codigo ?? this.codigo,
      geradoOffline: geradoOffline ?? this.geradoOffline,
      geradoEm: geradoEm ?? this.geradoEm,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (folhaTarefaId.present) {
      map['folha_tarefa_id'] = Variable<String>(folhaTarefaId.value);
    }
    if (numero.present) {
      map['numero'] = Variable<BigInt>(numero.value);
    }
    if (codigo.present) {
      map['codigo'] = Variable<String>(codigo.value);
    }
    if (geradoOffline.present) {
      map['gerado_offline'] = Variable<bool>(geradoOffline.value);
    }
    if (geradoEm.present) {
      map['gerado_em'] = Variable<DateTime>(geradoEm.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TicketsLocalCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('folhaTarefaId: $folhaTarefaId, ')
          ..write('numero: $numero, ')
          ..write('codigo: $codigo, ')
          ..write('geradoOffline: $geradoOffline, ')
          ..write('geradoEm: $geradoEm, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ApontamentosLocalTable extends ApontamentosLocal
    with TableInfo<$ApontamentosLocalTable, ApontamentosLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ApontamentosLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
      'item_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _eventoIdMeta =
      const VerificationMeta('eventoId');
  @override
  late final GeneratedColumn<String> eventoId = GeneratedColumn<String>(
      'evento_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ticketIdMeta =
      const VerificationMeta('ticketId');
  @override
  late final GeneratedColumn<String> ticketId = GeneratedColumn<String>(
      'ticket_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _equipeIdMeta =
      const VerificationMeta('equipeId');
  @override
  late final GeneratedColumn<String> equipeId = GeneratedColumn<String>(
      'equipe_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _efetivoIdMeta =
      const VerificationMeta('efetivoId');
  @override
  late final GeneratedColumn<String> efetivoId = GeneratedColumn<String>(
      'efetivo_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dataExecucaoMeta =
      const VerificationMeta('dataExecucao');
  @override
  late final GeneratedColumn<DateTime> dataExecucao = GeneratedColumn<DateTime>(
      'data_execucao', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _qtdPrevistaMeta =
      const VerificationMeta('qtdPrevista');
  @override
  late final GeneratedColumn<double> qtdPrevista = GeneratedColumn<double>(
      'qtd_prevista', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _qtdRealizadaMeta =
      const VerificationMeta('qtdRealizada');
  @override
  late final GeneratedColumn<double> qtdRealizada = GeneratedColumn<double>(
      'qtd_realizada', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('rascunho'));
  static const VerificationMeta _idOfflineMeta =
      const VerificationMeta('idOffline');
  @override
  late final GeneratedColumn<String> idOffline = GeneratedColumn<String>(
      'id_offline', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sincronizadoEmMeta =
      const VerificationMeta('sincronizadoEm');
  @override
  late final GeneratedColumn<DateTime> sincronizadoEm =
      GeneratedColumn<DateTime>('sincronizado_em', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _criadoEmMeta =
      const VerificationMeta('criadoEm');
  @override
  late final GeneratedColumn<DateTime> criadoEm = GeneratedColumn<DateTime>(
      'criado_em', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _usuarioIdMeta =
      const VerificationMeta('usuarioId');
  @override
  late final GeneratedColumn<String> usuarioId = GeneratedColumn<String>(
      'usuario_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
        itemId,
        eventoId,
        ticketId,
        equipeId,
        efetivoId,
        dataExecucao,
        qtdPrevista,
        qtdRealizada,
        status,
        idOffline,
        sincronizadoEm,
        criadoEm,
        usuarioId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'apontamentos_local';
  @override
  VerificationContext validateIntegrity(
      Insertable<ApontamentosLocalData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('evento_id')) {
      context.handle(_eventoIdMeta,
          eventoId.isAcceptableOrUnknown(data['evento_id']!, _eventoIdMeta));
    } else if (isInserting) {
      context.missing(_eventoIdMeta);
    }
    if (data.containsKey('ticket_id')) {
      context.handle(_ticketIdMeta,
          ticketId.isAcceptableOrUnknown(data['ticket_id']!, _ticketIdMeta));
    }
    if (data.containsKey('equipe_id')) {
      context.handle(_equipeIdMeta,
          equipeId.isAcceptableOrUnknown(data['equipe_id']!, _equipeIdMeta));
    }
    if (data.containsKey('efetivo_id')) {
      context.handle(_efetivoIdMeta,
          efetivoId.isAcceptableOrUnknown(data['efetivo_id']!, _efetivoIdMeta));
    }
    if (data.containsKey('data_execucao')) {
      context.handle(
          _dataExecucaoMeta,
          dataExecucao.isAcceptableOrUnknown(
              data['data_execucao']!, _dataExecucaoMeta));
    } else if (isInserting) {
      context.missing(_dataExecucaoMeta);
    }
    if (data.containsKey('qtd_prevista')) {
      context.handle(
          _qtdPrevistaMeta,
          qtdPrevista.isAcceptableOrUnknown(
              data['qtd_prevista']!, _qtdPrevistaMeta));
    }
    if (data.containsKey('qtd_realizada')) {
      context.handle(
          _qtdRealizadaMeta,
          qtdRealizada.isAcceptableOrUnknown(
              data['qtd_realizada']!, _qtdRealizadaMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('id_offline')) {
      context.handle(_idOfflineMeta,
          idOffline.isAcceptableOrUnknown(data['id_offline']!, _idOfflineMeta));
    }
    if (data.containsKey('sincronizado_em')) {
      context.handle(
          _sincronizadoEmMeta,
          sincronizadoEm.isAcceptableOrUnknown(
              data['sincronizado_em']!, _sincronizadoEmMeta));
    }
    if (data.containsKey('criado_em')) {
      context.handle(_criadoEmMeta,
          criadoEm.isAcceptableOrUnknown(data['criado_em']!, _criadoEmMeta));
    } else if (isInserting) {
      context.missing(_criadoEmMeta);
    }
    if (data.containsKey('usuario_id')) {
      context.handle(_usuarioIdMeta,
          usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ApontamentosLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ApontamentosLocalData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      itemId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_id'])!,
      eventoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}evento_id'])!,
      ticketId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ticket_id']),
      equipeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}equipe_id']),
      efetivoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}efetivo_id']),
      dataExecucao: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}data_execucao'])!,
      qtdPrevista: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}qtd_prevista']),
      qtdRealizada: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}qtd_realizada']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      idOffline: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id_offline']),
      sincronizadoEm: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}sincronizado_em']),
      criadoEm: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}criado_em'])!,
      usuarioId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}usuario_id']),
    );
  }

  @override
  $ApontamentosLocalTable createAlias(String alias) {
    return $ApontamentosLocalTable(attachedDatabase, alias);
  }
}

class ApontamentosLocalData extends DataClass
    implements Insertable<ApontamentosLocalData> {
  final String id;
  final String tenantId;
  final String itemId;
  final String eventoId;
  final String? ticketId;
  final String? equipeId;
  final String? efetivoId;
  final DateTime dataExecucao;
  final double? qtdPrevista;
  final double? qtdRealizada;
  final String status;
  final String? idOffline;
  final DateTime? sincronizadoEm;
  final DateTime criadoEm;
  final String? usuarioId;
  const ApontamentosLocalData(
      {required this.id,
      required this.tenantId,
      required this.itemId,
      required this.eventoId,
      this.ticketId,
      this.equipeId,
      this.efetivoId,
      required this.dataExecucao,
      this.qtdPrevista,
      this.qtdRealizada,
      required this.status,
      this.idOffline,
      this.sincronizadoEm,
      required this.criadoEm,
      this.usuarioId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['item_id'] = Variable<String>(itemId);
    map['evento_id'] = Variable<String>(eventoId);
    if (!nullToAbsent || ticketId != null) {
      map['ticket_id'] = Variable<String>(ticketId);
    }
    if (!nullToAbsent || equipeId != null) {
      map['equipe_id'] = Variable<String>(equipeId);
    }
    if (!nullToAbsent || efetivoId != null) {
      map['efetivo_id'] = Variable<String>(efetivoId);
    }
    map['data_execucao'] = Variable<DateTime>(dataExecucao);
    if (!nullToAbsent || qtdPrevista != null) {
      map['qtd_prevista'] = Variable<double>(qtdPrevista);
    }
    if (!nullToAbsent || qtdRealizada != null) {
      map['qtd_realizada'] = Variable<double>(qtdRealizada);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || idOffline != null) {
      map['id_offline'] = Variable<String>(idOffline);
    }
    if (!nullToAbsent || sincronizadoEm != null) {
      map['sincronizado_em'] = Variable<DateTime>(sincronizadoEm);
    }
    map['criado_em'] = Variable<DateTime>(criadoEm);
    if (!nullToAbsent || usuarioId != null) {
      map['usuario_id'] = Variable<String>(usuarioId);
    }
    return map;
  }

  ApontamentosLocalCompanion toCompanion(bool nullToAbsent) {
    return ApontamentosLocalCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      itemId: Value(itemId),
      eventoId: Value(eventoId),
      ticketId: ticketId == null && nullToAbsent
          ? const Value.absent()
          : Value(ticketId),
      equipeId: equipeId == null && nullToAbsent
          ? const Value.absent()
          : Value(equipeId),
      efetivoId: efetivoId == null && nullToAbsent
          ? const Value.absent()
          : Value(efetivoId),
      dataExecucao: Value(dataExecucao),
      qtdPrevista: qtdPrevista == null && nullToAbsent
          ? const Value.absent()
          : Value(qtdPrevista),
      qtdRealizada: qtdRealizada == null && nullToAbsent
          ? const Value.absent()
          : Value(qtdRealizada),
      status: Value(status),
      idOffline: idOffline == null && nullToAbsent
          ? const Value.absent()
          : Value(idOffline),
      sincronizadoEm: sincronizadoEm == null && nullToAbsent
          ? const Value.absent()
          : Value(sincronizadoEm),
      criadoEm: Value(criadoEm),
      usuarioId: usuarioId == null && nullToAbsent
          ? const Value.absent()
          : Value(usuarioId),
    );
  }

  factory ApontamentosLocalData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ApontamentosLocalData(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      itemId: serializer.fromJson<String>(json['itemId']),
      eventoId: serializer.fromJson<String>(json['eventoId']),
      ticketId: serializer.fromJson<String?>(json['ticketId']),
      equipeId: serializer.fromJson<String?>(json['equipeId']),
      efetivoId: serializer.fromJson<String?>(json['efetivoId']),
      dataExecucao: serializer.fromJson<DateTime>(json['dataExecucao']),
      qtdPrevista: serializer.fromJson<double?>(json['qtdPrevista']),
      qtdRealizada: serializer.fromJson<double?>(json['qtdRealizada']),
      status: serializer.fromJson<String>(json['status']),
      idOffline: serializer.fromJson<String?>(json['idOffline']),
      sincronizadoEm: serializer.fromJson<DateTime?>(json['sincronizadoEm']),
      criadoEm: serializer.fromJson<DateTime>(json['criadoEm']),
      usuarioId: serializer.fromJson<String?>(json['usuarioId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'itemId': serializer.toJson<String>(itemId),
      'eventoId': serializer.toJson<String>(eventoId),
      'ticketId': serializer.toJson<String?>(ticketId),
      'equipeId': serializer.toJson<String?>(equipeId),
      'efetivoId': serializer.toJson<String?>(efetivoId),
      'dataExecucao': serializer.toJson<DateTime>(dataExecucao),
      'qtdPrevista': serializer.toJson<double?>(qtdPrevista),
      'qtdRealizada': serializer.toJson<double?>(qtdRealizada),
      'status': serializer.toJson<String>(status),
      'idOffline': serializer.toJson<String?>(idOffline),
      'sincronizadoEm': serializer.toJson<DateTime?>(sincronizadoEm),
      'criadoEm': serializer.toJson<DateTime>(criadoEm),
      'usuarioId': serializer.toJson<String?>(usuarioId),
    };
  }

  ApontamentosLocalData copyWith(
          {String? id,
          String? tenantId,
          String? itemId,
          String? eventoId,
          Value<String?> ticketId = const Value.absent(),
          Value<String?> equipeId = const Value.absent(),
          Value<String?> efetivoId = const Value.absent(),
          DateTime? dataExecucao,
          Value<double?> qtdPrevista = const Value.absent(),
          Value<double?> qtdRealizada = const Value.absent(),
          String? status,
          Value<String?> idOffline = const Value.absent(),
          Value<DateTime?> sincronizadoEm = const Value.absent(),
          DateTime? criadoEm,
          Value<String?> usuarioId = const Value.absent()}) =>
      ApontamentosLocalData(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        itemId: itemId ?? this.itemId,
        eventoId: eventoId ?? this.eventoId,
        ticketId: ticketId.present ? ticketId.value : this.ticketId,
        equipeId: equipeId.present ? equipeId.value : this.equipeId,
        efetivoId: efetivoId.present ? efetivoId.value : this.efetivoId,
        dataExecucao: dataExecucao ?? this.dataExecucao,
        qtdPrevista: qtdPrevista.present ? qtdPrevista.value : this.qtdPrevista,
        qtdRealizada:
            qtdRealizada.present ? qtdRealizada.value : this.qtdRealizada,
        status: status ?? this.status,
        idOffline: idOffline.present ? idOffline.value : this.idOffline,
        sincronizadoEm:
            sincronizadoEm.present ? sincronizadoEm.value : this.sincronizadoEm,
        criadoEm: criadoEm ?? this.criadoEm,
        usuarioId: usuarioId.present ? usuarioId.value : this.usuarioId,
      );
  ApontamentosLocalData copyWithCompanion(ApontamentosLocalCompanion data) {
    return ApontamentosLocalData(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      eventoId: data.eventoId.present ? data.eventoId.value : this.eventoId,
      ticketId: data.ticketId.present ? data.ticketId.value : this.ticketId,
      equipeId: data.equipeId.present ? data.equipeId.value : this.equipeId,
      efetivoId: data.efetivoId.present ? data.efetivoId.value : this.efetivoId,
      dataExecucao: data.dataExecucao.present
          ? data.dataExecucao.value
          : this.dataExecucao,
      qtdPrevista:
          data.qtdPrevista.present ? data.qtdPrevista.value : this.qtdPrevista,
      qtdRealizada: data.qtdRealizada.present
          ? data.qtdRealizada.value
          : this.qtdRealizada,
      status: data.status.present ? data.status.value : this.status,
      idOffline: data.idOffline.present ? data.idOffline.value : this.idOffline,
      sincronizadoEm: data.sincronizadoEm.present
          ? data.sincronizadoEm.value
          : this.sincronizadoEm,
      criadoEm: data.criadoEm.present ? data.criadoEm.value : this.criadoEm,
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ApontamentosLocalData(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('itemId: $itemId, ')
          ..write('eventoId: $eventoId, ')
          ..write('ticketId: $ticketId, ')
          ..write('equipeId: $equipeId, ')
          ..write('efetivoId: $efetivoId, ')
          ..write('dataExecucao: $dataExecucao, ')
          ..write('qtdPrevista: $qtdPrevista, ')
          ..write('qtdRealizada: $qtdRealizada, ')
          ..write('status: $status, ')
          ..write('idOffline: $idOffline, ')
          ..write('sincronizadoEm: $sincronizadoEm, ')
          ..write('criadoEm: $criadoEm, ')
          ..write('usuarioId: $usuarioId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      tenantId,
      itemId,
      eventoId,
      ticketId,
      equipeId,
      efetivoId,
      dataExecucao,
      qtdPrevista,
      qtdRealizada,
      status,
      idOffline,
      sincronizadoEm,
      criadoEm,
      usuarioId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ApontamentosLocalData &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.itemId == this.itemId &&
          other.eventoId == this.eventoId &&
          other.ticketId == this.ticketId &&
          other.equipeId == this.equipeId &&
          other.efetivoId == this.efetivoId &&
          other.dataExecucao == this.dataExecucao &&
          other.qtdPrevista == this.qtdPrevista &&
          other.qtdRealizada == this.qtdRealizada &&
          other.status == this.status &&
          other.idOffline == this.idOffline &&
          other.sincronizadoEm == this.sincronizadoEm &&
          other.criadoEm == this.criadoEm &&
          other.usuarioId == this.usuarioId);
}

class ApontamentosLocalCompanion
    extends UpdateCompanion<ApontamentosLocalData> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> itemId;
  final Value<String> eventoId;
  final Value<String?> ticketId;
  final Value<String?> equipeId;
  final Value<String?> efetivoId;
  final Value<DateTime> dataExecucao;
  final Value<double?> qtdPrevista;
  final Value<double?> qtdRealizada;
  final Value<String> status;
  final Value<String?> idOffline;
  final Value<DateTime?> sincronizadoEm;
  final Value<DateTime> criadoEm;
  final Value<String?> usuarioId;
  final Value<int> rowid;
  const ApontamentosLocalCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.eventoId = const Value.absent(),
    this.ticketId = const Value.absent(),
    this.equipeId = const Value.absent(),
    this.efetivoId = const Value.absent(),
    this.dataExecucao = const Value.absent(),
    this.qtdPrevista = const Value.absent(),
    this.qtdRealizada = const Value.absent(),
    this.status = const Value.absent(),
    this.idOffline = const Value.absent(),
    this.sincronizadoEm = const Value.absent(),
    this.criadoEm = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ApontamentosLocalCompanion.insert({
    required String id,
    required String tenantId,
    required String itemId,
    required String eventoId,
    this.ticketId = const Value.absent(),
    this.equipeId = const Value.absent(),
    this.efetivoId = const Value.absent(),
    required DateTime dataExecucao,
    this.qtdPrevista = const Value.absent(),
    this.qtdRealizada = const Value.absent(),
    this.status = const Value.absent(),
    this.idOffline = const Value.absent(),
    this.sincronizadoEm = const Value.absent(),
    required DateTime criadoEm,
    this.usuarioId = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        itemId = Value(itemId),
        eventoId = Value(eventoId),
        dataExecucao = Value(dataExecucao),
        criadoEm = Value(criadoEm);
  static Insertable<ApontamentosLocalData> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? itemId,
    Expression<String>? eventoId,
    Expression<String>? ticketId,
    Expression<String>? equipeId,
    Expression<String>? efetivoId,
    Expression<DateTime>? dataExecucao,
    Expression<double>? qtdPrevista,
    Expression<double>? qtdRealizada,
    Expression<String>? status,
    Expression<String>? idOffline,
    Expression<DateTime>? sincronizadoEm,
    Expression<DateTime>? criadoEm,
    Expression<String>? usuarioId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (itemId != null) 'item_id': itemId,
      if (eventoId != null) 'evento_id': eventoId,
      if (ticketId != null) 'ticket_id': ticketId,
      if (equipeId != null) 'equipe_id': equipeId,
      if (efetivoId != null) 'efetivo_id': efetivoId,
      if (dataExecucao != null) 'data_execucao': dataExecucao,
      if (qtdPrevista != null) 'qtd_prevista': qtdPrevista,
      if (qtdRealizada != null) 'qtd_realizada': qtdRealizada,
      if (status != null) 'status': status,
      if (idOffline != null) 'id_offline': idOffline,
      if (sincronizadoEm != null) 'sincronizado_em': sincronizadoEm,
      if (criadoEm != null) 'criado_em': criadoEm,
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ApontamentosLocalCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? itemId,
      Value<String>? eventoId,
      Value<String?>? ticketId,
      Value<String?>? equipeId,
      Value<String?>? efetivoId,
      Value<DateTime>? dataExecucao,
      Value<double?>? qtdPrevista,
      Value<double?>? qtdRealizada,
      Value<String>? status,
      Value<String?>? idOffline,
      Value<DateTime?>? sincronizadoEm,
      Value<DateTime>? criadoEm,
      Value<String?>? usuarioId,
      Value<int>? rowid}) {
    return ApontamentosLocalCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      itemId: itemId ?? this.itemId,
      eventoId: eventoId ?? this.eventoId,
      ticketId: ticketId ?? this.ticketId,
      equipeId: equipeId ?? this.equipeId,
      efetivoId: efetivoId ?? this.efetivoId,
      dataExecucao: dataExecucao ?? this.dataExecucao,
      qtdPrevista: qtdPrevista ?? this.qtdPrevista,
      qtdRealizada: qtdRealizada ?? this.qtdRealizada,
      status: status ?? this.status,
      idOffline: idOffline ?? this.idOffline,
      sincronizadoEm: sincronizadoEm ?? this.sincronizadoEm,
      criadoEm: criadoEm ?? this.criadoEm,
      usuarioId: usuarioId ?? this.usuarioId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (eventoId.present) {
      map['evento_id'] = Variable<String>(eventoId.value);
    }
    if (ticketId.present) {
      map['ticket_id'] = Variable<String>(ticketId.value);
    }
    if (equipeId.present) {
      map['equipe_id'] = Variable<String>(equipeId.value);
    }
    if (efetivoId.present) {
      map['efetivo_id'] = Variable<String>(efetivoId.value);
    }
    if (dataExecucao.present) {
      map['data_execucao'] = Variable<DateTime>(dataExecucao.value);
    }
    if (qtdPrevista.present) {
      map['qtd_prevista'] = Variable<double>(qtdPrevista.value);
    }
    if (qtdRealizada.present) {
      map['qtd_realizada'] = Variable<double>(qtdRealizada.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (idOffline.present) {
      map['id_offline'] = Variable<String>(idOffline.value);
    }
    if (sincronizadoEm.present) {
      map['sincronizado_em'] = Variable<DateTime>(sincronizadoEm.value);
    }
    if (criadoEm.present) {
      map['criado_em'] = Variable<DateTime>(criadoEm.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<String>(usuarioId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ApontamentosLocalCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('itemId: $itemId, ')
          ..write('eventoId: $eventoId, ')
          ..write('ticketId: $ticketId, ')
          ..write('equipeId: $equipeId, ')
          ..write('efetivoId: $efetivoId, ')
          ..write('dataExecucao: $dataExecucao, ')
          ..write('qtdPrevista: $qtdPrevista, ')
          ..write('qtdRealizada: $qtdRealizada, ')
          ..write('status: $status, ')
          ..write('idOffline: $idOffline, ')
          ..write('sincronizadoEm: $sincronizadoEm, ')
          ..write('criadoEm: $criadoEm, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FilaSyncTable extends FilaSync
    with TableInfo<$FilaSyncTable, FilaSyncData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FilaSyncTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _tabelaMeta = const VerificationMeta('tabela');
  @override
  late final GeneratedColumn<String> tabela = GeneratedColumn<String>(
      'tabela', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _operacaoMeta =
      const VerificationMeta('operacao');
  @override
  late final GeneratedColumn<String> operacao = GeneratedColumn<String>(
      'operacao', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _registroIdMeta =
      const VerificationMeta('registroId');
  @override
  late final GeneratedColumn<String> registroId = GeneratedColumn<String>(
      'registro_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadMeta =
      const VerificationMeta('payload');
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
      'payload', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tentativasMeta =
      const VerificationMeta('tentativas');
  @override
  late final GeneratedColumn<int> tentativas = GeneratedColumn<int>(
      'tentativas', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _criadoEmMeta =
      const VerificationMeta('criadoEm');
  @override
  late final GeneratedColumn<DateTime> criadoEm = GeneratedColumn<DateTime>(
      'criado_em', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _proximaTentativaMeta =
      const VerificationMeta('proximaTentativa');
  @override
  late final GeneratedColumn<DateTime> proximaTentativa =
      GeneratedColumn<DateTime>('proxima_tentativa', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _processadoMeta =
      const VerificationMeta('processado');
  @override
  late final GeneratedColumn<bool> processado = GeneratedColumn<bool>(
      'processado', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("processado" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tabela,
        operacao,
        registroId,
        payload,
        tentativas,
        criadoEm,
        proximaTentativa,
        processado
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fila_sync';
  @override
  VerificationContext validateIntegrity(Insertable<FilaSyncData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tabela')) {
      context.handle(_tabelaMeta,
          tabela.isAcceptableOrUnknown(data['tabela']!, _tabelaMeta));
    } else if (isInserting) {
      context.missing(_tabelaMeta);
    }
    if (data.containsKey('operacao')) {
      context.handle(_operacaoMeta,
          operacao.isAcceptableOrUnknown(data['operacao']!, _operacaoMeta));
    } else if (isInserting) {
      context.missing(_operacaoMeta);
    }
    if (data.containsKey('registro_id')) {
      context.handle(
          _registroIdMeta,
          registroId.isAcceptableOrUnknown(
              data['registro_id']!, _registroIdMeta));
    } else if (isInserting) {
      context.missing(_registroIdMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('tentativas')) {
      context.handle(
          _tentativasMeta,
          tentativas.isAcceptableOrUnknown(
              data['tentativas']!, _tentativasMeta));
    }
    if (data.containsKey('criado_em')) {
      context.handle(_criadoEmMeta,
          criadoEm.isAcceptableOrUnknown(data['criado_em']!, _criadoEmMeta));
    } else if (isInserting) {
      context.missing(_criadoEmMeta);
    }
    if (data.containsKey('proxima_tentativa')) {
      context.handle(
          _proximaTentativaMeta,
          proximaTentativa.isAcceptableOrUnknown(
              data['proxima_tentativa']!, _proximaTentativaMeta));
    } else if (isInserting) {
      context.missing(_proximaTentativaMeta);
    }
    if (data.containsKey('processado')) {
      context.handle(
          _processadoMeta,
          processado.isAcceptableOrUnknown(
              data['processado']!, _processadoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FilaSyncData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FilaSyncData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      tabela: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tabela'])!,
      operacao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operacao'])!,
      registroId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}registro_id'])!,
      payload: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload'])!,
      tentativas: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tentativas'])!,
      criadoEm: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}criado_em'])!,
      proximaTentativa: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}proxima_tentativa'])!,
      processado: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}processado'])!,
    );
  }

  @override
  $FilaSyncTable createAlias(String alias) {
    return $FilaSyncTable(attachedDatabase, alias);
  }
}

class FilaSyncData extends DataClass implements Insertable<FilaSyncData> {
  final int id;
  final String tabela;
  final String operacao;
  final String registroId;
  final String payload;
  final int tentativas;
  final DateTime criadoEm;
  final DateTime proximaTentativa;
  final bool processado;
  const FilaSyncData(
      {required this.id,
      required this.tabela,
      required this.operacao,
      required this.registroId,
      required this.payload,
      required this.tentativas,
      required this.criadoEm,
      required this.proximaTentativa,
      required this.processado});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tabela'] = Variable<String>(tabela);
    map['operacao'] = Variable<String>(operacao);
    map['registro_id'] = Variable<String>(registroId);
    map['payload'] = Variable<String>(payload);
    map['tentativas'] = Variable<int>(tentativas);
    map['criado_em'] = Variable<DateTime>(criadoEm);
    map['proxima_tentativa'] = Variable<DateTime>(proximaTentativa);
    map['processado'] = Variable<bool>(processado);
    return map;
  }

  FilaSyncCompanion toCompanion(bool nullToAbsent) {
    return FilaSyncCompanion(
      id: Value(id),
      tabela: Value(tabela),
      operacao: Value(operacao),
      registroId: Value(registroId),
      payload: Value(payload),
      tentativas: Value(tentativas),
      criadoEm: Value(criadoEm),
      proximaTentativa: Value(proximaTentativa),
      processado: Value(processado),
    );
  }

  factory FilaSyncData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FilaSyncData(
      id: serializer.fromJson<int>(json['id']),
      tabela: serializer.fromJson<String>(json['tabela']),
      operacao: serializer.fromJson<String>(json['operacao']),
      registroId: serializer.fromJson<String>(json['registroId']),
      payload: serializer.fromJson<String>(json['payload']),
      tentativas: serializer.fromJson<int>(json['tentativas']),
      criadoEm: serializer.fromJson<DateTime>(json['criadoEm']),
      proximaTentativa: serializer.fromJson<DateTime>(json['proximaTentativa']),
      processado: serializer.fromJson<bool>(json['processado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tabela': serializer.toJson<String>(tabela),
      'operacao': serializer.toJson<String>(operacao),
      'registroId': serializer.toJson<String>(registroId),
      'payload': serializer.toJson<String>(payload),
      'tentativas': serializer.toJson<int>(tentativas),
      'criadoEm': serializer.toJson<DateTime>(criadoEm),
      'proximaTentativa': serializer.toJson<DateTime>(proximaTentativa),
      'processado': serializer.toJson<bool>(processado),
    };
  }

  FilaSyncData copyWith(
          {int? id,
          String? tabela,
          String? operacao,
          String? registroId,
          String? payload,
          int? tentativas,
          DateTime? criadoEm,
          DateTime? proximaTentativa,
          bool? processado}) =>
      FilaSyncData(
        id: id ?? this.id,
        tabela: tabela ?? this.tabela,
        operacao: operacao ?? this.operacao,
        registroId: registroId ?? this.registroId,
        payload: payload ?? this.payload,
        tentativas: tentativas ?? this.tentativas,
        criadoEm: criadoEm ?? this.criadoEm,
        proximaTentativa: proximaTentativa ?? this.proximaTentativa,
        processado: processado ?? this.processado,
      );
  FilaSyncData copyWithCompanion(FilaSyncCompanion data) {
    return FilaSyncData(
      id: data.id.present ? data.id.value : this.id,
      tabela: data.tabela.present ? data.tabela.value : this.tabela,
      operacao: data.operacao.present ? data.operacao.value : this.operacao,
      registroId:
          data.registroId.present ? data.registroId.value : this.registroId,
      payload: data.payload.present ? data.payload.value : this.payload,
      tentativas:
          data.tentativas.present ? data.tentativas.value : this.tentativas,
      criadoEm: data.criadoEm.present ? data.criadoEm.value : this.criadoEm,
      proximaTentativa: data.proximaTentativa.present
          ? data.proximaTentativa.value
          : this.proximaTentativa,
      processado:
          data.processado.present ? data.processado.value : this.processado,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FilaSyncData(')
          ..write('id: $id, ')
          ..write('tabela: $tabela, ')
          ..write('operacao: $operacao, ')
          ..write('registroId: $registroId, ')
          ..write('payload: $payload, ')
          ..write('tentativas: $tentativas, ')
          ..write('criadoEm: $criadoEm, ')
          ..write('proximaTentativa: $proximaTentativa, ')
          ..write('processado: $processado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tabela, operacao, registroId, payload,
      tentativas, criadoEm, proximaTentativa, processado);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FilaSyncData &&
          other.id == this.id &&
          other.tabela == this.tabela &&
          other.operacao == this.operacao &&
          other.registroId == this.registroId &&
          other.payload == this.payload &&
          other.tentativas == this.tentativas &&
          other.criadoEm == this.criadoEm &&
          other.proximaTentativa == this.proximaTentativa &&
          other.processado == this.processado);
}

class FilaSyncCompanion extends UpdateCompanion<FilaSyncData> {
  final Value<int> id;
  final Value<String> tabela;
  final Value<String> operacao;
  final Value<String> registroId;
  final Value<String> payload;
  final Value<int> tentativas;
  final Value<DateTime> criadoEm;
  final Value<DateTime> proximaTentativa;
  final Value<bool> processado;
  const FilaSyncCompanion({
    this.id = const Value.absent(),
    this.tabela = const Value.absent(),
    this.operacao = const Value.absent(),
    this.registroId = const Value.absent(),
    this.payload = const Value.absent(),
    this.tentativas = const Value.absent(),
    this.criadoEm = const Value.absent(),
    this.proximaTentativa = const Value.absent(),
    this.processado = const Value.absent(),
  });
  FilaSyncCompanion.insert({
    this.id = const Value.absent(),
    required String tabela,
    required String operacao,
    required String registroId,
    required String payload,
    this.tentativas = const Value.absent(),
    required DateTime criadoEm,
    required DateTime proximaTentativa,
    this.processado = const Value.absent(),
  })  : tabela = Value(tabela),
        operacao = Value(operacao),
        registroId = Value(registroId),
        payload = Value(payload),
        criadoEm = Value(criadoEm),
        proximaTentativa = Value(proximaTentativa);
  static Insertable<FilaSyncData> custom({
    Expression<int>? id,
    Expression<String>? tabela,
    Expression<String>? operacao,
    Expression<String>? registroId,
    Expression<String>? payload,
    Expression<int>? tentativas,
    Expression<DateTime>? criadoEm,
    Expression<DateTime>? proximaTentativa,
    Expression<bool>? processado,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tabela != null) 'tabela': tabela,
      if (operacao != null) 'operacao': operacao,
      if (registroId != null) 'registro_id': registroId,
      if (payload != null) 'payload': payload,
      if (tentativas != null) 'tentativas': tentativas,
      if (criadoEm != null) 'criado_em': criadoEm,
      if (proximaTentativa != null) 'proxima_tentativa': proximaTentativa,
      if (processado != null) 'processado': processado,
    });
  }

  FilaSyncCompanion copyWith(
      {Value<int>? id,
      Value<String>? tabela,
      Value<String>? operacao,
      Value<String>? registroId,
      Value<String>? payload,
      Value<int>? tentativas,
      Value<DateTime>? criadoEm,
      Value<DateTime>? proximaTentativa,
      Value<bool>? processado}) {
    return FilaSyncCompanion(
      id: id ?? this.id,
      tabela: tabela ?? this.tabela,
      operacao: operacao ?? this.operacao,
      registroId: registroId ?? this.registroId,
      payload: payload ?? this.payload,
      tentativas: tentativas ?? this.tentativas,
      criadoEm: criadoEm ?? this.criadoEm,
      proximaTentativa: proximaTentativa ?? this.proximaTentativa,
      processado: processado ?? this.processado,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tabela.present) {
      map['tabela'] = Variable<String>(tabela.value);
    }
    if (operacao.present) {
      map['operacao'] = Variable<String>(operacao.value);
    }
    if (registroId.present) {
      map['registro_id'] = Variable<String>(registroId.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (tentativas.present) {
      map['tentativas'] = Variable<int>(tentativas.value);
    }
    if (criadoEm.present) {
      map['criado_em'] = Variable<DateTime>(criadoEm.value);
    }
    if (proximaTentativa.present) {
      map['proxima_tentativa'] = Variable<DateTime>(proximaTentativa.value);
    }
    if (processado.present) {
      map['processado'] = Variable<bool>(processado.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FilaSyncCompanion(')
          ..write('id: $id, ')
          ..write('tabela: $tabela, ')
          ..write('operacao: $operacao, ')
          ..write('registroId: $registroId, ')
          ..write('payload: $payload, ')
          ..write('tentativas: $tentativas, ')
          ..write('criadoEm: $criadoEm, ')
          ..write('proximaTentativa: $proximaTentativa, ')
          ..write('processado: $processado')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  $LocalDatabaseManager get managers => $LocalDatabaseManager(this);
  late final $ItensLocalTable itensLocal = $ItensLocalTable(this);
  late final $EventosLocalTable eventosLocal = $EventosLocalTable(this);
  late final $FolhasTarefaLocalTable folhasTarefaLocal =
      $FolhasTarefaLocalTable(this);
  late final $FolhaTarefaItensLocalTable folhaTarefaItensLocal =
      $FolhaTarefaItensLocalTable(this);
  late final $TicketsLocalTable ticketsLocal = $TicketsLocalTable(this);
  late final $ApontamentosLocalTable apontamentosLocal =
      $ApontamentosLocalTable(this);
  late final $FilaSyncTable filaSync = $FilaSyncTable(this);
  late final ApontamentoDao apontamentoDao =
      ApontamentoDao(this as LocalDatabase);
  late final ItemDao itemDao = ItemDao(this as LocalDatabase);
  late final FolhaTarefaDao folhaTarefaDao =
      FolhaTarefaDao(this as LocalDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        itensLocal,
        eventosLocal,
        folhasTarefaLocal,
        folhaTarefaItensLocal,
        ticketsLocal,
        apontamentosLocal,
        filaSync
      ];
}

typedef $$ItensLocalTableCreateCompanionBuilder = ItensLocalCompanion Function({
  required String id,
  required String tenantId,
  required String subprojetoId,
  required String tag,
  Value<String?> grupo,
  Value<String?> subgrupo,
  Value<String?> componente,
  Value<String?> descricao,
  Value<String?> diametro,
  Value<String> status,
  Value<String?> revisaoAtual,
  required DateTime atualizadoEm,
  Value<int> rowid,
});
typedef $$ItensLocalTableUpdateCompanionBuilder = ItensLocalCompanion Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> subprojetoId,
  Value<String> tag,
  Value<String?> grupo,
  Value<String?> subgrupo,
  Value<String?> componente,
  Value<String?> descricao,
  Value<String?> diametro,
  Value<String> status,
  Value<String?> revisaoAtual,
  Value<DateTime> atualizadoEm,
  Value<int> rowid,
});

class $$ItensLocalTableFilterComposer
    extends Composer<_$LocalDatabase, $ItensLocalTable> {
  $$ItensLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get subprojetoId => $composableBuilder(
      column: $table.subprojetoId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tag => $composableBuilder(
      column: $table.tag, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get grupo => $composableBuilder(
      column: $table.grupo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get subgrupo => $composableBuilder(
      column: $table.subgrupo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get componente => $composableBuilder(
      column: $table.componente, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descricao => $composableBuilder(
      column: $table.descricao, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get diametro => $composableBuilder(
      column: $table.diametro, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get revisaoAtual => $composableBuilder(
      column: $table.revisaoAtual, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get atualizadoEm => $composableBuilder(
      column: $table.atualizadoEm, builder: (column) => ColumnFilters(column));
}

class $$ItensLocalTableOrderingComposer
    extends Composer<_$LocalDatabase, $ItensLocalTable> {
  $$ItensLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get subprojetoId => $composableBuilder(
      column: $table.subprojetoId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tag => $composableBuilder(
      column: $table.tag, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get grupo => $composableBuilder(
      column: $table.grupo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get subgrupo => $composableBuilder(
      column: $table.subgrupo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get componente => $composableBuilder(
      column: $table.componente, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descricao => $composableBuilder(
      column: $table.descricao, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get diametro => $composableBuilder(
      column: $table.diametro, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get revisaoAtual => $composableBuilder(
      column: $table.revisaoAtual,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get atualizadoEm => $composableBuilder(
      column: $table.atualizadoEm,
      builder: (column) => ColumnOrderings(column));
}

class $$ItensLocalTableAnnotationComposer
    extends Composer<_$LocalDatabase, $ItensLocalTable> {
  $$ItensLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get subprojetoId => $composableBuilder(
      column: $table.subprojetoId, builder: (column) => column);

  GeneratedColumn<String> get tag =>
      $composableBuilder(column: $table.tag, builder: (column) => column);

  GeneratedColumn<String> get grupo =>
      $composableBuilder(column: $table.grupo, builder: (column) => column);

  GeneratedColumn<String> get subgrupo =>
      $composableBuilder(column: $table.subgrupo, builder: (column) => column);

  GeneratedColumn<String> get componente => $composableBuilder(
      column: $table.componente, builder: (column) => column);

  GeneratedColumn<String> get descricao =>
      $composableBuilder(column: $table.descricao, builder: (column) => column);

  GeneratedColumn<String> get diametro =>
      $composableBuilder(column: $table.diametro, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get revisaoAtual => $composableBuilder(
      column: $table.revisaoAtual, builder: (column) => column);

  GeneratedColumn<DateTime> get atualizadoEm => $composableBuilder(
      column: $table.atualizadoEm, builder: (column) => column);
}

class $$ItensLocalTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $ItensLocalTable,
    ItensLocalData,
    $$ItensLocalTableFilterComposer,
    $$ItensLocalTableOrderingComposer,
    $$ItensLocalTableAnnotationComposer,
    $$ItensLocalTableCreateCompanionBuilder,
    $$ItensLocalTableUpdateCompanionBuilder,
    (
      ItensLocalData,
      BaseReferences<_$LocalDatabase, $ItensLocalTable, ItensLocalData>
    ),
    ItensLocalData,
    PrefetchHooks Function()> {
  $$ItensLocalTableTableManager(_$LocalDatabase db, $ItensLocalTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItensLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItensLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItensLocalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> subprojetoId = const Value.absent(),
            Value<String> tag = const Value.absent(),
            Value<String?> grupo = const Value.absent(),
            Value<String?> subgrupo = const Value.absent(),
            Value<String?> componente = const Value.absent(),
            Value<String?> descricao = const Value.absent(),
            Value<String?> diametro = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> revisaoAtual = const Value.absent(),
            Value<DateTime> atualizadoEm = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ItensLocalCompanion(
            id: id,
            tenantId: tenantId,
            subprojetoId: subprojetoId,
            tag: tag,
            grupo: grupo,
            subgrupo: subgrupo,
            componente: componente,
            descricao: descricao,
            diametro: diametro,
            status: status,
            revisaoAtual: revisaoAtual,
            atualizadoEm: atualizadoEm,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String subprojetoId,
            required String tag,
            Value<String?> grupo = const Value.absent(),
            Value<String?> subgrupo = const Value.absent(),
            Value<String?> componente = const Value.absent(),
            Value<String?> descricao = const Value.absent(),
            Value<String?> diametro = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> revisaoAtual = const Value.absent(),
            required DateTime atualizadoEm,
            Value<int> rowid = const Value.absent(),
          }) =>
              ItensLocalCompanion.insert(
            id: id,
            tenantId: tenantId,
            subprojetoId: subprojetoId,
            tag: tag,
            grupo: grupo,
            subgrupo: subgrupo,
            componente: componente,
            descricao: descricao,
            diametro: diametro,
            status: status,
            revisaoAtual: revisaoAtual,
            atualizadoEm: atualizadoEm,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ItensLocalTableProcessedTableManager = ProcessedTableManager<
    _$LocalDatabase,
    $ItensLocalTable,
    ItensLocalData,
    $$ItensLocalTableFilterComposer,
    $$ItensLocalTableOrderingComposer,
    $$ItensLocalTableAnnotationComposer,
    $$ItensLocalTableCreateCompanionBuilder,
    $$ItensLocalTableUpdateCompanionBuilder,
    (
      ItensLocalData,
      BaseReferences<_$LocalDatabase, $ItensLocalTable, ItensLocalData>
    ),
    ItensLocalData,
    PrefetchHooks Function()>;
typedef $$EventosLocalTableCreateCompanionBuilder = EventosLocalCompanion
    Function({
  required String id,
  required String tenantId,
  required String faseId,
  required String codigo,
  required String nome,
  Value<double?> percentual,
  Value<int> ordem,
  Value<bool> ativo,
  Value<int> rowid,
});
typedef $$EventosLocalTableUpdateCompanionBuilder = EventosLocalCompanion
    Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> faseId,
  Value<String> codigo,
  Value<String> nome,
  Value<double?> percentual,
  Value<int> ordem,
  Value<bool> ativo,
  Value<int> rowid,
});

class $$EventosLocalTableFilterComposer
    extends Composer<_$LocalDatabase, $EventosLocalTable> {
  $$EventosLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get faseId => $composableBuilder(
      column: $table.faseId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get codigo => $composableBuilder(
      column: $table.codigo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get percentual => $composableBuilder(
      column: $table.percentual, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ordem => $composableBuilder(
      column: $table.ordem, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get ativo => $composableBuilder(
      column: $table.ativo, builder: (column) => ColumnFilters(column));
}

class $$EventosLocalTableOrderingComposer
    extends Composer<_$LocalDatabase, $EventosLocalTable> {
  $$EventosLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get faseId => $composableBuilder(
      column: $table.faseId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get codigo => $composableBuilder(
      column: $table.codigo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get percentual => $composableBuilder(
      column: $table.percentual, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ordem => $composableBuilder(
      column: $table.ordem, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get ativo => $composableBuilder(
      column: $table.ativo, builder: (column) => ColumnOrderings(column));
}

class $$EventosLocalTableAnnotationComposer
    extends Composer<_$LocalDatabase, $EventosLocalTable> {
  $$EventosLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get faseId =>
      $composableBuilder(column: $table.faseId, builder: (column) => column);

  GeneratedColumn<String> get codigo =>
      $composableBuilder(column: $table.codigo, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<double> get percentual => $composableBuilder(
      column: $table.percentual, builder: (column) => column);

  GeneratedColumn<int> get ordem =>
      $composableBuilder(column: $table.ordem, builder: (column) => column);

  GeneratedColumn<bool> get ativo =>
      $composableBuilder(column: $table.ativo, builder: (column) => column);
}

class $$EventosLocalTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $EventosLocalTable,
    EventosLocalData,
    $$EventosLocalTableFilterComposer,
    $$EventosLocalTableOrderingComposer,
    $$EventosLocalTableAnnotationComposer,
    $$EventosLocalTableCreateCompanionBuilder,
    $$EventosLocalTableUpdateCompanionBuilder,
    (
      EventosLocalData,
      BaseReferences<_$LocalDatabase, $EventosLocalTable, EventosLocalData>
    ),
    EventosLocalData,
    PrefetchHooks Function()> {
  $$EventosLocalTableTableManager(_$LocalDatabase db, $EventosLocalTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventosLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventosLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventosLocalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> faseId = const Value.absent(),
            Value<String> codigo = const Value.absent(),
            Value<String> nome = const Value.absent(),
            Value<double?> percentual = const Value.absent(),
            Value<int> ordem = const Value.absent(),
            Value<bool> ativo = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EventosLocalCompanion(
            id: id,
            tenantId: tenantId,
            faseId: faseId,
            codigo: codigo,
            nome: nome,
            percentual: percentual,
            ordem: ordem,
            ativo: ativo,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String faseId,
            required String codigo,
            required String nome,
            Value<double?> percentual = const Value.absent(),
            Value<int> ordem = const Value.absent(),
            Value<bool> ativo = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EventosLocalCompanion.insert(
            id: id,
            tenantId: tenantId,
            faseId: faseId,
            codigo: codigo,
            nome: nome,
            percentual: percentual,
            ordem: ordem,
            ativo: ativo,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$EventosLocalTableProcessedTableManager = ProcessedTableManager<
    _$LocalDatabase,
    $EventosLocalTable,
    EventosLocalData,
    $$EventosLocalTableFilterComposer,
    $$EventosLocalTableOrderingComposer,
    $$EventosLocalTableAnnotationComposer,
    $$EventosLocalTableCreateCompanionBuilder,
    $$EventosLocalTableUpdateCompanionBuilder,
    (
      EventosLocalData,
      BaseReferences<_$LocalDatabase, $EventosLocalTable, EventosLocalData>
    ),
    EventosLocalData,
    PrefetchHooks Function()>;
typedef $$FolhasTarefaLocalTableCreateCompanionBuilder
    = FolhasTarefaLocalCompanion Function({
  required String id,
  required String tenantId,
  required String osId,
  required String subprojetoId,
  required String periodoId,
  required String sequencial,
  Value<String> status,
  Value<DateTime?> dataInicio,
  Value<DateTime?> dataFim,
  Value<int> rowid,
});
typedef $$FolhasTarefaLocalTableUpdateCompanionBuilder
    = FolhasTarefaLocalCompanion Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> osId,
  Value<String> subprojetoId,
  Value<String> periodoId,
  Value<String> sequencial,
  Value<String> status,
  Value<DateTime?> dataInicio,
  Value<DateTime?> dataFim,
  Value<int> rowid,
});

class $$FolhasTarefaLocalTableFilterComposer
    extends Composer<_$LocalDatabase, $FolhasTarefaLocalTable> {
  $$FolhasTarefaLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get osId => $composableBuilder(
      column: $table.osId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get subprojetoId => $composableBuilder(
      column: $table.subprojetoId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get periodoId => $composableBuilder(
      column: $table.periodoId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sequencial => $composableBuilder(
      column: $table.sequencial, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataInicio => $composableBuilder(
      column: $table.dataInicio, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataFim => $composableBuilder(
      column: $table.dataFim, builder: (column) => ColumnFilters(column));
}

class $$FolhasTarefaLocalTableOrderingComposer
    extends Composer<_$LocalDatabase, $FolhasTarefaLocalTable> {
  $$FolhasTarefaLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get osId => $composableBuilder(
      column: $table.osId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get subprojetoId => $composableBuilder(
      column: $table.subprojetoId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get periodoId => $composableBuilder(
      column: $table.periodoId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sequencial => $composableBuilder(
      column: $table.sequencial, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataInicio => $composableBuilder(
      column: $table.dataInicio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataFim => $composableBuilder(
      column: $table.dataFim, builder: (column) => ColumnOrderings(column));
}

class $$FolhasTarefaLocalTableAnnotationComposer
    extends Composer<_$LocalDatabase, $FolhasTarefaLocalTable> {
  $$FolhasTarefaLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get osId =>
      $composableBuilder(column: $table.osId, builder: (column) => column);

  GeneratedColumn<String> get subprojetoId => $composableBuilder(
      column: $table.subprojetoId, builder: (column) => column);

  GeneratedColumn<String> get periodoId =>
      $composableBuilder(column: $table.periodoId, builder: (column) => column);

  GeneratedColumn<String> get sequencial => $composableBuilder(
      column: $table.sequencial, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get dataInicio => $composableBuilder(
      column: $table.dataInicio, builder: (column) => column);

  GeneratedColumn<DateTime> get dataFim =>
      $composableBuilder(column: $table.dataFim, builder: (column) => column);
}

class $$FolhasTarefaLocalTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $FolhasTarefaLocalTable,
    FolhasTarefaLocalData,
    $$FolhasTarefaLocalTableFilterComposer,
    $$FolhasTarefaLocalTableOrderingComposer,
    $$FolhasTarefaLocalTableAnnotationComposer,
    $$FolhasTarefaLocalTableCreateCompanionBuilder,
    $$FolhasTarefaLocalTableUpdateCompanionBuilder,
    (
      FolhasTarefaLocalData,
      BaseReferences<_$LocalDatabase, $FolhasTarefaLocalTable,
          FolhasTarefaLocalData>
    ),
    FolhasTarefaLocalData,
    PrefetchHooks Function()> {
  $$FolhasTarefaLocalTableTableManager(
      _$LocalDatabase db, $FolhasTarefaLocalTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FolhasTarefaLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FolhasTarefaLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FolhasTarefaLocalTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> osId = const Value.absent(),
            Value<String> subprojetoId = const Value.absent(),
            Value<String> periodoId = const Value.absent(),
            Value<String> sequencial = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime?> dataInicio = const Value.absent(),
            Value<DateTime?> dataFim = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FolhasTarefaLocalCompanion(
            id: id,
            tenantId: tenantId,
            osId: osId,
            subprojetoId: subprojetoId,
            periodoId: periodoId,
            sequencial: sequencial,
            status: status,
            dataInicio: dataInicio,
            dataFim: dataFim,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String osId,
            required String subprojetoId,
            required String periodoId,
            required String sequencial,
            Value<String> status = const Value.absent(),
            Value<DateTime?> dataInicio = const Value.absent(),
            Value<DateTime?> dataFim = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FolhasTarefaLocalCompanion.insert(
            id: id,
            tenantId: tenantId,
            osId: osId,
            subprojetoId: subprojetoId,
            periodoId: periodoId,
            sequencial: sequencial,
            status: status,
            dataInicio: dataInicio,
            dataFim: dataFim,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FolhasTarefaLocalTableProcessedTableManager = ProcessedTableManager<
    _$LocalDatabase,
    $FolhasTarefaLocalTable,
    FolhasTarefaLocalData,
    $$FolhasTarefaLocalTableFilterComposer,
    $$FolhasTarefaLocalTableOrderingComposer,
    $$FolhasTarefaLocalTableAnnotationComposer,
    $$FolhasTarefaLocalTableCreateCompanionBuilder,
    $$FolhasTarefaLocalTableUpdateCompanionBuilder,
    (
      FolhasTarefaLocalData,
      BaseReferences<_$LocalDatabase, $FolhasTarefaLocalTable,
          FolhasTarefaLocalData>
    ),
    FolhasTarefaLocalData,
    PrefetchHooks Function()>;
typedef $$FolhaTarefaItensLocalTableCreateCompanionBuilder
    = FolhaTarefaItensLocalCompanion Function({
  required String id,
  required String tenantId,
  required String folhaTarefaId,
  required String itemId,
  required String eventoId,
  Value<String?> periodo,
  Value<int> prioridade,
  Value<bool> executado,
  Value<String?> ticketId,
  Value<int> rowid,
});
typedef $$FolhaTarefaItensLocalTableUpdateCompanionBuilder
    = FolhaTarefaItensLocalCompanion Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> folhaTarefaId,
  Value<String> itemId,
  Value<String> eventoId,
  Value<String?> periodo,
  Value<int> prioridade,
  Value<bool> executado,
  Value<String?> ticketId,
  Value<int> rowid,
});

class $$FolhaTarefaItensLocalTableFilterComposer
    extends Composer<_$LocalDatabase, $FolhaTarefaItensLocalTable> {
  $$FolhaTarefaItensLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get folhaTarefaId => $composableBuilder(
      column: $table.folhaTarefaId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get itemId => $composableBuilder(
      column: $table.itemId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get eventoId => $composableBuilder(
      column: $table.eventoId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get periodo => $composableBuilder(
      column: $table.periodo, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get prioridade => $composableBuilder(
      column: $table.prioridade, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get executado => $composableBuilder(
      column: $table.executado, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ticketId => $composableBuilder(
      column: $table.ticketId, builder: (column) => ColumnFilters(column));
}

class $$FolhaTarefaItensLocalTableOrderingComposer
    extends Composer<_$LocalDatabase, $FolhaTarefaItensLocalTable> {
  $$FolhaTarefaItensLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get folhaTarefaId => $composableBuilder(
      column: $table.folhaTarefaId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get itemId => $composableBuilder(
      column: $table.itemId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get eventoId => $composableBuilder(
      column: $table.eventoId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get periodo => $composableBuilder(
      column: $table.periodo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get prioridade => $composableBuilder(
      column: $table.prioridade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get executado => $composableBuilder(
      column: $table.executado, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ticketId => $composableBuilder(
      column: $table.ticketId, builder: (column) => ColumnOrderings(column));
}

class $$FolhaTarefaItensLocalTableAnnotationComposer
    extends Composer<_$LocalDatabase, $FolhaTarefaItensLocalTable> {
  $$FolhaTarefaItensLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get folhaTarefaId => $composableBuilder(
      column: $table.folhaTarefaId, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<String> get eventoId =>
      $composableBuilder(column: $table.eventoId, builder: (column) => column);

  GeneratedColumn<String> get periodo =>
      $composableBuilder(column: $table.periodo, builder: (column) => column);

  GeneratedColumn<int> get prioridade => $composableBuilder(
      column: $table.prioridade, builder: (column) => column);

  GeneratedColumn<bool> get executado =>
      $composableBuilder(column: $table.executado, builder: (column) => column);

  GeneratedColumn<String> get ticketId =>
      $composableBuilder(column: $table.ticketId, builder: (column) => column);
}

class $$FolhaTarefaItensLocalTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $FolhaTarefaItensLocalTable,
    FolhaTarefaItensLocalData,
    $$FolhaTarefaItensLocalTableFilterComposer,
    $$FolhaTarefaItensLocalTableOrderingComposer,
    $$FolhaTarefaItensLocalTableAnnotationComposer,
    $$FolhaTarefaItensLocalTableCreateCompanionBuilder,
    $$FolhaTarefaItensLocalTableUpdateCompanionBuilder,
    (
      FolhaTarefaItensLocalData,
      BaseReferences<_$LocalDatabase, $FolhaTarefaItensLocalTable,
          FolhaTarefaItensLocalData>
    ),
    FolhaTarefaItensLocalData,
    PrefetchHooks Function()> {
  $$FolhaTarefaItensLocalTableTableManager(
      _$LocalDatabase db, $FolhaTarefaItensLocalTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FolhaTarefaItensLocalTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$FolhaTarefaItensLocalTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FolhaTarefaItensLocalTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> folhaTarefaId = const Value.absent(),
            Value<String> itemId = const Value.absent(),
            Value<String> eventoId = const Value.absent(),
            Value<String?> periodo = const Value.absent(),
            Value<int> prioridade = const Value.absent(),
            Value<bool> executado = const Value.absent(),
            Value<String?> ticketId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FolhaTarefaItensLocalCompanion(
            id: id,
            tenantId: tenantId,
            folhaTarefaId: folhaTarefaId,
            itemId: itemId,
            eventoId: eventoId,
            periodo: periodo,
            prioridade: prioridade,
            executado: executado,
            ticketId: ticketId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String folhaTarefaId,
            required String itemId,
            required String eventoId,
            Value<String?> periodo = const Value.absent(),
            Value<int> prioridade = const Value.absent(),
            Value<bool> executado = const Value.absent(),
            Value<String?> ticketId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FolhaTarefaItensLocalCompanion.insert(
            id: id,
            tenantId: tenantId,
            folhaTarefaId: folhaTarefaId,
            itemId: itemId,
            eventoId: eventoId,
            periodo: periodo,
            prioridade: prioridade,
            executado: executado,
            ticketId: ticketId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FolhaTarefaItensLocalTableProcessedTableManager
    = ProcessedTableManager<
        _$LocalDatabase,
        $FolhaTarefaItensLocalTable,
        FolhaTarefaItensLocalData,
        $$FolhaTarefaItensLocalTableFilterComposer,
        $$FolhaTarefaItensLocalTableOrderingComposer,
        $$FolhaTarefaItensLocalTableAnnotationComposer,
        $$FolhaTarefaItensLocalTableCreateCompanionBuilder,
        $$FolhaTarefaItensLocalTableUpdateCompanionBuilder,
        (
          FolhaTarefaItensLocalData,
          BaseReferences<_$LocalDatabase, $FolhaTarefaItensLocalTable,
              FolhaTarefaItensLocalData>
        ),
        FolhaTarefaItensLocalData,
        PrefetchHooks Function()>;
typedef $$TicketsLocalTableCreateCompanionBuilder = TicketsLocalCompanion
    Function({
  required String id,
  required String tenantId,
  required String folhaTarefaId,
  required BigInt numero,
  required String codigo,
  Value<bool> geradoOffline,
  required DateTime geradoEm,
  Value<int> rowid,
});
typedef $$TicketsLocalTableUpdateCompanionBuilder = TicketsLocalCompanion
    Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> folhaTarefaId,
  Value<BigInt> numero,
  Value<String> codigo,
  Value<bool> geradoOffline,
  Value<DateTime> geradoEm,
  Value<int> rowid,
});

class $$TicketsLocalTableFilterComposer
    extends Composer<_$LocalDatabase, $TicketsLocalTable> {
  $$TicketsLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get folhaTarefaId => $composableBuilder(
      column: $table.folhaTarefaId, builder: (column) => ColumnFilters(column));

  ColumnFilters<BigInt> get numero => $composableBuilder(
      column: $table.numero, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get codigo => $composableBuilder(
      column: $table.codigo, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get geradoOffline => $composableBuilder(
      column: $table.geradoOffline, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get geradoEm => $composableBuilder(
      column: $table.geradoEm, builder: (column) => ColumnFilters(column));
}

class $$TicketsLocalTableOrderingComposer
    extends Composer<_$LocalDatabase, $TicketsLocalTable> {
  $$TicketsLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get folhaTarefaId => $composableBuilder(
      column: $table.folhaTarefaId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<BigInt> get numero => $composableBuilder(
      column: $table.numero, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get codigo => $composableBuilder(
      column: $table.codigo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get geradoOffline => $composableBuilder(
      column: $table.geradoOffline,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get geradoEm => $composableBuilder(
      column: $table.geradoEm, builder: (column) => ColumnOrderings(column));
}

class $$TicketsLocalTableAnnotationComposer
    extends Composer<_$LocalDatabase, $TicketsLocalTable> {
  $$TicketsLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get folhaTarefaId => $composableBuilder(
      column: $table.folhaTarefaId, builder: (column) => column);

  GeneratedColumn<BigInt> get numero =>
      $composableBuilder(column: $table.numero, builder: (column) => column);

  GeneratedColumn<String> get codigo =>
      $composableBuilder(column: $table.codigo, builder: (column) => column);

  GeneratedColumn<bool> get geradoOffline => $composableBuilder(
      column: $table.geradoOffline, builder: (column) => column);

  GeneratedColumn<DateTime> get geradoEm =>
      $composableBuilder(column: $table.geradoEm, builder: (column) => column);
}

class $$TicketsLocalTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $TicketsLocalTable,
    TicketsLocalData,
    $$TicketsLocalTableFilterComposer,
    $$TicketsLocalTableOrderingComposer,
    $$TicketsLocalTableAnnotationComposer,
    $$TicketsLocalTableCreateCompanionBuilder,
    $$TicketsLocalTableUpdateCompanionBuilder,
    (
      TicketsLocalData,
      BaseReferences<_$LocalDatabase, $TicketsLocalTable, TicketsLocalData>
    ),
    TicketsLocalData,
    PrefetchHooks Function()> {
  $$TicketsLocalTableTableManager(_$LocalDatabase db, $TicketsLocalTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TicketsLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TicketsLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TicketsLocalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> folhaTarefaId = const Value.absent(),
            Value<BigInt> numero = const Value.absent(),
            Value<String> codigo = const Value.absent(),
            Value<bool> geradoOffline = const Value.absent(),
            Value<DateTime> geradoEm = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TicketsLocalCompanion(
            id: id,
            tenantId: tenantId,
            folhaTarefaId: folhaTarefaId,
            numero: numero,
            codigo: codigo,
            geradoOffline: geradoOffline,
            geradoEm: geradoEm,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String folhaTarefaId,
            required BigInt numero,
            required String codigo,
            Value<bool> geradoOffline = const Value.absent(),
            required DateTime geradoEm,
            Value<int> rowid = const Value.absent(),
          }) =>
              TicketsLocalCompanion.insert(
            id: id,
            tenantId: tenantId,
            folhaTarefaId: folhaTarefaId,
            numero: numero,
            codigo: codigo,
            geradoOffline: geradoOffline,
            geradoEm: geradoEm,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TicketsLocalTableProcessedTableManager = ProcessedTableManager<
    _$LocalDatabase,
    $TicketsLocalTable,
    TicketsLocalData,
    $$TicketsLocalTableFilterComposer,
    $$TicketsLocalTableOrderingComposer,
    $$TicketsLocalTableAnnotationComposer,
    $$TicketsLocalTableCreateCompanionBuilder,
    $$TicketsLocalTableUpdateCompanionBuilder,
    (
      TicketsLocalData,
      BaseReferences<_$LocalDatabase, $TicketsLocalTable, TicketsLocalData>
    ),
    TicketsLocalData,
    PrefetchHooks Function()>;
typedef $$ApontamentosLocalTableCreateCompanionBuilder
    = ApontamentosLocalCompanion Function({
  required String id,
  required String tenantId,
  required String itemId,
  required String eventoId,
  Value<String?> ticketId,
  Value<String?> equipeId,
  Value<String?> efetivoId,
  required DateTime dataExecucao,
  Value<double?> qtdPrevista,
  Value<double?> qtdRealizada,
  Value<String> status,
  Value<String?> idOffline,
  Value<DateTime?> sincronizadoEm,
  required DateTime criadoEm,
  Value<String?> usuarioId,
  Value<int> rowid,
});
typedef $$ApontamentosLocalTableUpdateCompanionBuilder
    = ApontamentosLocalCompanion Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> itemId,
  Value<String> eventoId,
  Value<String?> ticketId,
  Value<String?> equipeId,
  Value<String?> efetivoId,
  Value<DateTime> dataExecucao,
  Value<double?> qtdPrevista,
  Value<double?> qtdRealizada,
  Value<String> status,
  Value<String?> idOffline,
  Value<DateTime?> sincronizadoEm,
  Value<DateTime> criadoEm,
  Value<String?> usuarioId,
  Value<int> rowid,
});

class $$ApontamentosLocalTableFilterComposer
    extends Composer<_$LocalDatabase, $ApontamentosLocalTable> {
  $$ApontamentosLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get itemId => $composableBuilder(
      column: $table.itemId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get eventoId => $composableBuilder(
      column: $table.eventoId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ticketId => $composableBuilder(
      column: $table.ticketId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get equipeId => $composableBuilder(
      column: $table.equipeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get efetivoId => $composableBuilder(
      column: $table.efetivoId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataExecucao => $composableBuilder(
      column: $table.dataExecucao, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get qtdPrevista => $composableBuilder(
      column: $table.qtdPrevista, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get qtdRealizada => $composableBuilder(
      column: $table.qtdRealizada, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get idOffline => $composableBuilder(
      column: $table.idOffline, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get sincronizadoEm => $composableBuilder(
      column: $table.sincronizadoEm,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get criadoEm => $composableBuilder(
      column: $table.criadoEm, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get usuarioId => $composableBuilder(
      column: $table.usuarioId, builder: (column) => ColumnFilters(column));
}

class $$ApontamentosLocalTableOrderingComposer
    extends Composer<_$LocalDatabase, $ApontamentosLocalTable> {
  $$ApontamentosLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get itemId => $composableBuilder(
      column: $table.itemId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get eventoId => $composableBuilder(
      column: $table.eventoId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ticketId => $composableBuilder(
      column: $table.ticketId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get equipeId => $composableBuilder(
      column: $table.equipeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get efetivoId => $composableBuilder(
      column: $table.efetivoId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataExecucao => $composableBuilder(
      column: $table.dataExecucao,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get qtdPrevista => $composableBuilder(
      column: $table.qtdPrevista, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get qtdRealizada => $composableBuilder(
      column: $table.qtdRealizada,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get idOffline => $composableBuilder(
      column: $table.idOffline, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get sincronizadoEm => $composableBuilder(
      column: $table.sincronizadoEm,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get criadoEm => $composableBuilder(
      column: $table.criadoEm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get usuarioId => $composableBuilder(
      column: $table.usuarioId, builder: (column) => ColumnOrderings(column));
}

class $$ApontamentosLocalTableAnnotationComposer
    extends Composer<_$LocalDatabase, $ApontamentosLocalTable> {
  $$ApontamentosLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<String> get eventoId =>
      $composableBuilder(column: $table.eventoId, builder: (column) => column);

  GeneratedColumn<String> get ticketId =>
      $composableBuilder(column: $table.ticketId, builder: (column) => column);

  GeneratedColumn<String> get equipeId =>
      $composableBuilder(column: $table.equipeId, builder: (column) => column);

  GeneratedColumn<String> get efetivoId =>
      $composableBuilder(column: $table.efetivoId, builder: (column) => column);

  GeneratedColumn<DateTime> get dataExecucao => $composableBuilder(
      column: $table.dataExecucao, builder: (column) => column);

  GeneratedColumn<double> get qtdPrevista => $composableBuilder(
      column: $table.qtdPrevista, builder: (column) => column);

  GeneratedColumn<double> get qtdRealizada => $composableBuilder(
      column: $table.qtdRealizada, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get idOffline =>
      $composableBuilder(column: $table.idOffline, builder: (column) => column);

  GeneratedColumn<DateTime> get sincronizadoEm => $composableBuilder(
      column: $table.sincronizadoEm, builder: (column) => column);

  GeneratedColumn<DateTime> get criadoEm =>
      $composableBuilder(column: $table.criadoEm, builder: (column) => column);

  GeneratedColumn<String> get usuarioId =>
      $composableBuilder(column: $table.usuarioId, builder: (column) => column);
}

class $$ApontamentosLocalTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $ApontamentosLocalTable,
    ApontamentosLocalData,
    $$ApontamentosLocalTableFilterComposer,
    $$ApontamentosLocalTableOrderingComposer,
    $$ApontamentosLocalTableAnnotationComposer,
    $$ApontamentosLocalTableCreateCompanionBuilder,
    $$ApontamentosLocalTableUpdateCompanionBuilder,
    (
      ApontamentosLocalData,
      BaseReferences<_$LocalDatabase, $ApontamentosLocalTable,
          ApontamentosLocalData>
    ),
    ApontamentosLocalData,
    PrefetchHooks Function()> {
  $$ApontamentosLocalTableTableManager(
      _$LocalDatabase db, $ApontamentosLocalTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ApontamentosLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ApontamentosLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ApontamentosLocalTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> itemId = const Value.absent(),
            Value<String> eventoId = const Value.absent(),
            Value<String?> ticketId = const Value.absent(),
            Value<String?> equipeId = const Value.absent(),
            Value<String?> efetivoId = const Value.absent(),
            Value<DateTime> dataExecucao = const Value.absent(),
            Value<double?> qtdPrevista = const Value.absent(),
            Value<double?> qtdRealizada = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> idOffline = const Value.absent(),
            Value<DateTime?> sincronizadoEm = const Value.absent(),
            Value<DateTime> criadoEm = const Value.absent(),
            Value<String?> usuarioId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ApontamentosLocalCompanion(
            id: id,
            tenantId: tenantId,
            itemId: itemId,
            eventoId: eventoId,
            ticketId: ticketId,
            equipeId: equipeId,
            efetivoId: efetivoId,
            dataExecucao: dataExecucao,
            qtdPrevista: qtdPrevista,
            qtdRealizada: qtdRealizada,
            status: status,
            idOffline: idOffline,
            sincronizadoEm: sincronizadoEm,
            criadoEm: criadoEm,
            usuarioId: usuarioId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String itemId,
            required String eventoId,
            Value<String?> ticketId = const Value.absent(),
            Value<String?> equipeId = const Value.absent(),
            Value<String?> efetivoId = const Value.absent(),
            required DateTime dataExecucao,
            Value<double?> qtdPrevista = const Value.absent(),
            Value<double?> qtdRealizada = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> idOffline = const Value.absent(),
            Value<DateTime?> sincronizadoEm = const Value.absent(),
            required DateTime criadoEm,
            Value<String?> usuarioId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ApontamentosLocalCompanion.insert(
            id: id,
            tenantId: tenantId,
            itemId: itemId,
            eventoId: eventoId,
            ticketId: ticketId,
            equipeId: equipeId,
            efetivoId: efetivoId,
            dataExecucao: dataExecucao,
            qtdPrevista: qtdPrevista,
            qtdRealizada: qtdRealizada,
            status: status,
            idOffline: idOffline,
            sincronizadoEm: sincronizadoEm,
            criadoEm: criadoEm,
            usuarioId: usuarioId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ApontamentosLocalTableProcessedTableManager = ProcessedTableManager<
    _$LocalDatabase,
    $ApontamentosLocalTable,
    ApontamentosLocalData,
    $$ApontamentosLocalTableFilterComposer,
    $$ApontamentosLocalTableOrderingComposer,
    $$ApontamentosLocalTableAnnotationComposer,
    $$ApontamentosLocalTableCreateCompanionBuilder,
    $$ApontamentosLocalTableUpdateCompanionBuilder,
    (
      ApontamentosLocalData,
      BaseReferences<_$LocalDatabase, $ApontamentosLocalTable,
          ApontamentosLocalData>
    ),
    ApontamentosLocalData,
    PrefetchHooks Function()>;
typedef $$FilaSyncTableCreateCompanionBuilder = FilaSyncCompanion Function({
  Value<int> id,
  required String tabela,
  required String operacao,
  required String registroId,
  required String payload,
  Value<int> tentativas,
  required DateTime criadoEm,
  required DateTime proximaTentativa,
  Value<bool> processado,
});
typedef $$FilaSyncTableUpdateCompanionBuilder = FilaSyncCompanion Function({
  Value<int> id,
  Value<String> tabela,
  Value<String> operacao,
  Value<String> registroId,
  Value<String> payload,
  Value<int> tentativas,
  Value<DateTime> criadoEm,
  Value<DateTime> proximaTentativa,
  Value<bool> processado,
});

class $$FilaSyncTableFilterComposer
    extends Composer<_$LocalDatabase, $FilaSyncTable> {
  $$FilaSyncTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tabela => $composableBuilder(
      column: $table.tabela, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operacao => $composableBuilder(
      column: $table.operacao, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get registroId => $composableBuilder(
      column: $table.registroId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get tentativas => $composableBuilder(
      column: $table.tentativas, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get criadoEm => $composableBuilder(
      column: $table.criadoEm, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get proximaTentativa => $composableBuilder(
      column: $table.proximaTentativa,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get processado => $composableBuilder(
      column: $table.processado, builder: (column) => ColumnFilters(column));
}

class $$FilaSyncTableOrderingComposer
    extends Composer<_$LocalDatabase, $FilaSyncTable> {
  $$FilaSyncTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tabela => $composableBuilder(
      column: $table.tabela, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operacao => $composableBuilder(
      column: $table.operacao, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get registroId => $composableBuilder(
      column: $table.registroId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get tentativas => $composableBuilder(
      column: $table.tentativas, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get criadoEm => $composableBuilder(
      column: $table.criadoEm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get proximaTentativa => $composableBuilder(
      column: $table.proximaTentativa,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get processado => $composableBuilder(
      column: $table.processado, builder: (column) => ColumnOrderings(column));
}

class $$FilaSyncTableAnnotationComposer
    extends Composer<_$LocalDatabase, $FilaSyncTable> {
  $$FilaSyncTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tabela =>
      $composableBuilder(column: $table.tabela, builder: (column) => column);

  GeneratedColumn<String> get operacao =>
      $composableBuilder(column: $table.operacao, builder: (column) => column);

  GeneratedColumn<String> get registroId => $composableBuilder(
      column: $table.registroId, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<int> get tentativas => $composableBuilder(
      column: $table.tentativas, builder: (column) => column);

  GeneratedColumn<DateTime> get criadoEm =>
      $composableBuilder(column: $table.criadoEm, builder: (column) => column);

  GeneratedColumn<DateTime> get proximaTentativa => $composableBuilder(
      column: $table.proximaTentativa, builder: (column) => column);

  GeneratedColumn<bool> get processado => $composableBuilder(
      column: $table.processado, builder: (column) => column);
}

class $$FilaSyncTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $FilaSyncTable,
    FilaSyncData,
    $$FilaSyncTableFilterComposer,
    $$FilaSyncTableOrderingComposer,
    $$FilaSyncTableAnnotationComposer,
    $$FilaSyncTableCreateCompanionBuilder,
    $$FilaSyncTableUpdateCompanionBuilder,
    (
      FilaSyncData,
      BaseReferences<_$LocalDatabase, $FilaSyncTable, FilaSyncData>
    ),
    FilaSyncData,
    PrefetchHooks Function()> {
  $$FilaSyncTableTableManager(_$LocalDatabase db, $FilaSyncTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FilaSyncTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FilaSyncTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FilaSyncTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> tabela = const Value.absent(),
            Value<String> operacao = const Value.absent(),
            Value<String> registroId = const Value.absent(),
            Value<String> payload = const Value.absent(),
            Value<int> tentativas = const Value.absent(),
            Value<DateTime> criadoEm = const Value.absent(),
            Value<DateTime> proximaTentativa = const Value.absent(),
            Value<bool> processado = const Value.absent(),
          }) =>
              FilaSyncCompanion(
            id: id,
            tabela: tabela,
            operacao: operacao,
            registroId: registroId,
            payload: payload,
            tentativas: tentativas,
            criadoEm: criadoEm,
            proximaTentativa: proximaTentativa,
            processado: processado,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String tabela,
            required String operacao,
            required String registroId,
            required String payload,
            Value<int> tentativas = const Value.absent(),
            required DateTime criadoEm,
            required DateTime proximaTentativa,
            Value<bool> processado = const Value.absent(),
          }) =>
              FilaSyncCompanion.insert(
            id: id,
            tabela: tabela,
            operacao: operacao,
            registroId: registroId,
            payload: payload,
            tentativas: tentativas,
            criadoEm: criadoEm,
            proximaTentativa: proximaTentativa,
            processado: processado,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FilaSyncTableProcessedTableManager = ProcessedTableManager<
    _$LocalDatabase,
    $FilaSyncTable,
    FilaSyncData,
    $$FilaSyncTableFilterComposer,
    $$FilaSyncTableOrderingComposer,
    $$FilaSyncTableAnnotationComposer,
    $$FilaSyncTableCreateCompanionBuilder,
    $$FilaSyncTableUpdateCompanionBuilder,
    (
      FilaSyncData,
      BaseReferences<_$LocalDatabase, $FilaSyncTable, FilaSyncData>
    ),
    FilaSyncData,
    PrefetchHooks Function()>;

class $LocalDatabaseManager {
  final _$LocalDatabase _db;
  $LocalDatabaseManager(this._db);
  $$ItensLocalTableTableManager get itensLocal =>
      $$ItensLocalTableTableManager(_db, _db.itensLocal);
  $$EventosLocalTableTableManager get eventosLocal =>
      $$EventosLocalTableTableManager(_db, _db.eventosLocal);
  $$FolhasTarefaLocalTableTableManager get folhasTarefaLocal =>
      $$FolhasTarefaLocalTableTableManager(_db, _db.folhasTarefaLocal);
  $$FolhaTarefaItensLocalTableTableManager get folhaTarefaItensLocal =>
      $$FolhaTarefaItensLocalTableTableManager(_db, _db.folhaTarefaItensLocal);
  $$TicketsLocalTableTableManager get ticketsLocal =>
      $$TicketsLocalTableTableManager(_db, _db.ticketsLocal);
  $$ApontamentosLocalTableTableManager get apontamentosLocal =>
      $$ApontamentosLocalTableTableManager(_db, _db.apontamentosLocal);
  $$FilaSyncTableTableManager get filaSync =>
      $$FilaSyncTableTableManager(_db, _db.filaSync);
}
