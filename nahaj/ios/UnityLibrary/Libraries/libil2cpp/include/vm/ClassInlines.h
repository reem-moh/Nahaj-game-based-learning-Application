#pragma once

//This file should not include anything from VM. This is included by both libil2cpp and the codegen headers
#include "il2cpp-config.h"
#include "il2cpp-class-internals.h"
#include "il2cpp-object-internals.h"

namespace il2cpp
{
namespace vm
{
    class LIBIL2CPP_CODEGEN_API ClassInlines
    {
    public:
        // we assume that the Il2CppClass's have already been initialized in this case, like in code generation
        static inline bool HasParentUnsafe(const Il2CppClass* klass, const Il2CppClass* parent) { return klass->typeHierarchyDepth >= parent->typeHierarchyDepth && klass->typeHierarchy[parent->typeHierarchyDepth - 1] == parent; }

        // This function is critical for performance, before optimization it
        // caused up to 20% of all CPU usage in code generated by il2cpp
        static IL2CPP_FORCE_INLINE bool InitFromCodegen(Il2CppClass *klass)
        {
            if (klass->initialized_and_no_error)
                return true;
            return InitFromCodegenSlow(klass);
        }

        static IL2CPP_NO_INLINE bool InitFromCodegenSlow(Il2CppClass *klass);

        //internal
        static IL2CPP_FORCE_INLINE const VirtualInvokeData& GetInterfaceInvokeDataFromVTable(Il2CppObject* obj, const Il2CppClass* itf, Il2CppMethodSlot slot)
        {
            const Il2CppClass* klass = obj->klass;
            IL2CPP_ASSERT(klass->initialized);
            IL2CPP_ASSERT(slot < itf->method_count);

            for (uint16_t i = 0; i < klass->interface_offsets_count; i++)
            {
                if (klass->interfaceOffsets[i].interfaceType == itf)
                {
                    int32_t offset = klass->interfaceOffsets[i].offset;
                    IL2CPP_ASSERT(offset != -1);
                    IL2CPP_ASSERT(offset + slot < klass->vtable_count);
                    return klass->vtable[offset + slot];
                }
            }

            return GetInterfaceInvokeDataFromVTableSlowPath(obj, itf, slot);
        }

        static IL2CPP_FORCE_INLINE const VirtualInvokeData* GetInterfaceInvokeDataFromVTable(const Il2CppClass* klass, const Il2CppClass* itf, Il2CppMethodSlot slot)
        {
            IL2CPP_ASSERT(klass->initialized);
            IL2CPP_ASSERT(slot < itf->method_count);

            for (uint16_t i = 0; i < klass->interface_offsets_count; i++)
            {
                if (klass->interfaceOffsets[i].interfaceType == itf)
                {
                    int32_t offset = klass->interfaceOffsets[i].offset;
                    IL2CPP_ASSERT(offset != -1);
                    IL2CPP_ASSERT(offset + slot < klass->vtable_count);
                    return &klass->vtable[offset + slot];
                }
            }

            return GetInterfaceInvokeDataFromVTableSlowPath(klass, itf, slot);
        }

        // we don't want this method to get inlined because that makes GetInterfaceInvokeDataFromVTable method itself very large and performance suffers
        static IL2CPP_NO_INLINE const VirtualInvokeData& GetInterfaceInvokeDataFromVTableSlowPath(Il2CppObject* obj, const Il2CppClass* itf, Il2CppMethodSlot slot);
        static IL2CPP_NO_INLINE const VirtualInvokeData* GetInterfaceInvokeDataFromVTableSlowPath(const Il2CppClass* klass, const Il2CppClass* itf, Il2CppMethodSlot slot);
    };
}
}